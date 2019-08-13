class BrochureController < ApplicationController
  def index
    @projects = Project.order("RANDOM()").limit(3)
  end
end
