class ProjectsController < InheritedResources::Base

  private

    def project_params
      params.require(:project).permit(:title, :description, :creator, :skills, :min_budget, :max_budget, :duration, :developer)
    end
end

