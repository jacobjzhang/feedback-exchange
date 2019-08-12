class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /matches
  # GET /matches.json
  def index
    @matches = my_matches.paginate(page: 1)
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
  end

  def paginate_mine
    # matches = my_matches.to_a
    # @curr_page = params[:page].to_i
    # @total_pages = matches.count

    @matches = my_matches.paginate(page: params[:page])
    if @matches.length == 0
      head :ok, content_type: "text/html"
    else
      # @match = matches[@curr_page]
      render 'index'
    end
  end

  # GET /matches/new
  def new
    project = Project.find(params[:project_id])
    if project.existing_matches
      flash[:alert] = 'There are already outstanding matches for this project that are not complete.'
    else
      @match = MatchCreator.create_match
    end
  end

  # GET /matches/1/edit
  def edit
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new(match_params)

    respond_to do |format|
      if @match.save
        format.html { redirect_to @match, notice: 'Match was successfully created.' }
        format.json { render :show, status: :created, location: @match }
      else
        format.html { render :new }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
  def update
    respond_to do |format|
      if @match.update(match_params)
        format.html { redirect_to @match, notice: 'Match was successfully updated.' }
        format.json { render :show, status: :ok, location: @match }
      else
        format.html { render :edit }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match.destroy
    respond_to do |format|
      format.html { redirect_to matches_url, notice: 'Match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def my_matches
      @my_matches ||= Match.where(user: current_user).where(status: 'pending')
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:creator_first, :creator_second, :score_card_from_first, :score_card_from_second, :will_exchange_info_first, :will_exchange_info_second)
    end
end
