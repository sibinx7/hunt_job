class ProjectsController < InheritedResources::Base

  layout "dashboard"
  # def index
  #
  # end
  # def new
  #
  # end

  def create
    @project
  end


  private

    def project_params
      params.require(:project).permit(:title, :description, :creator, :skills, :min_budget, :max_budget, :duration, :developer)
    end
    
    # def skill_params
    #   params.require(:skill).permit(:name)
    # end
end

