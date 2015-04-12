class SkillsController < ApplicationController
  layout 'dashboard', :except => :json_view

  def index
  end

  def create
    puts "Here i reach"
    puts params[:skills].inspect
    @my_skills = params[:skills].split(",")

    @user = User.find(current_user.id)
    @my_skills.each  do |skills|
      if not (Skill.where(name:skills).exists?)
        @user.skills <<  Skill.new(:name => skills)
      else
        puts @user.skills.where(name:skills).count
        if @user.skills.where(name:skills).count == 0
          @user.skills <<  Skill.where(name:skills)
        end
      end
    end
    render :json => {
               :my_skills => @user.skills
    }
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
