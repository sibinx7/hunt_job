class SkillsController < ApplicationController
  layout 'dashboard', :except => :json_view

  def index
  end

  def create
  end

  def store
  end

  def edit
  end

  def update
  end

  def delete
  end

  def json_view
    @skills = Skill.all
    respond_to do |format|
      format.html
      format.json {render :json => @skills}
    end
  end

  private

  def skill_params
    params.require(:skill).permit(:id,:name)
  end
end
