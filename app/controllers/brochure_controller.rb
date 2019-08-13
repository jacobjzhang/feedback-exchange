class BrochureController < ApplicationController
  def index
    # faster than randomizing whole table
    @projects = Project.find(Project.pluck(:id).sample(3))
  end
end
