class ProjectsController < ApplicationController
  include ProjectHelper

  before_action :set_project, only: [:show, :matches, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:new, :create]
  before_action :require_permission, only: [:edit, :update, :delete]

  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = @project || Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    if current_user.nil?
      # Store the form data in the session so we can retrieve it after login
      session[:project] = params[:project]
      # Redirect the user to register/login
      redirect_to new_user_registration_path
    else
      handle_params_categories
      add_http_if_necessary

      @project = Project.new(project_params.merge(user: current_user))

      respond_to do |format|
        if @project.save
          format.html { redirect_to @project, notice: 'Project was successfully created.<br \>Your website will be shown to other users once you have feedback credits. <strong><u><a href="/review">Get some by submitting a scorecard here</a></u></strong>.' }
          format.json { render :show, status: :created, location: @project }
        else
          format.html { render :new }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end

      find_first_match
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    handle_params_categories
    add_http_if_necessary

    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def add_http_if_necessary
      params_url = params[:project]["url"]
      unless params_url[/\Ahttp:\/\//] || params_url[/\Ahttps:\/\//]
        params[:project]["url"] = "https://#{params_url}"
      end
    end

    def find_first_match
      MatchCreator.create_match(current_user)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :url, :description, :user_id, :category_list, categories: [])
    end

    def require_permission
      if current_user != Project.find(params[:id]).user
        redirect_to project_path, alert: "You don't have access to change this project."
      end
    end
end
