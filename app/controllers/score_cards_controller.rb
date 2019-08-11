class ScoreCardsController < ApplicationController
  before_action :set_project
  before_action :set_score_card, only: [:show, :edit, :update, :destroy]  
  before_action :authenticate_user!  

  # GET /score_cards
  # GET /score_cards.json
  def index
    @score_cards = ScoreCard.all
  end

  def example
    @score_card = ScoreCard.new(
      idea_rating: 3,
      idea: "There's been several technical interview prep sites that have spun up over the years, so I'm not sure this is breaking new ground. The focus on Javascript (for webdevelopers) and delivery via a daily email is decent, but I'm not sure you're adding any value that you wouldn't otherwise get for free.",
      design_rating: 3,
      design: "Pretty good design, but could be more modern. Pages are a little long. Not a lot of consistent brand colors.",
      experience_rating: 4,
      experience: "I like how each interview question is presented in the order that they need to be studied (question, try out, hints, walkthrough). It might help to hide some content initially too, as the pages are pretty long.",
      usability_rating: 2,
      usability: "I'm personally not a software engineer, so I wouldn't use it. I could, however, see some friends using it.",
      monetization_rating: 4,
      monetization: "Monetization strategy is obvious -- charge for content. You might have trouble marketing this in a sea of competitors.",
      suggestions: "Find a way to differentiate yourself from the other technical prep sites. Maybe try adding video, or improve the functionality of the code editor.",
      submitted_at: Time.zone.now,
      user_id: 1,
      project_id: 1
    ).save!
  end

  # GET /score_cards/1
  # GET /score_cards/1.json
  def show
  end

  # GET /score_cards/new
  def new
    @score_card = ScoreCard.new
  end

  # GET /score_cards/1/edit
  def edit
  end

  # POST /score_cards
  # POST /score_cards.json
  def create
    @score_card = ScoreCard.new(score_card_params.merge(user: current_user, project: @project))

    respond_to do |format|
      if @score_card.save
        format.html { redirect_to project_score_card_path(@project, @score_card), notice: 'Score card was successfully created.' }
        format.json { render :show, status: :created, location: @score_card }
      else
        format.html { render :new }
        format.json { render json: @score_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /score_cards/1
  # PATCH/PUT /score_cards/1.json
  def update
    respond_to do |format|
      if @score_card.update(score_card_params)
        format.html { redirect_to @score_card, notice: 'Score card was successfully updated.' }
        format.json { render :show, status: :ok, location: @score_card }
      else
        format.html { render :edit }
        format.json { render json: @score_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /score_cards/1
  # DELETE /score_cards/1.json
  def destroy
    @score_card.destroy
    respond_to do |format|
      format.html { redirect_to score_cards_url, notice: 'Score card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      if params[:project_id]
        @project = Project.find(params[:project_id])
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_score_card
      @score_card = ScoreCard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_card_params
      params.require(:score_card).permit(:idea_rating, :idea, :design_rating, :design, :experience_rating, :experience, :usability_rating, :usability, :monetization_rating, :monetization, :suggestions, :submitted_at, :user_id, :project_id)
    end
end
