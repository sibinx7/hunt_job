class ProjectsController < InheritedResources::Base
  # before_action :authenticate_user?

  layout "dashboard"
  # def index
  #
  # end
  # def new
  #
  # end

  def create
    # Save project data

    @my_skills = params[:project][:skill].split(",")


    project = Project.new(project_params)
    # puts YAML::dump(params)
    if project.save!
      # Check existence  of skills, if exist update relation table
      @my_skills.each_with_index  do |f,index|
        if not (Skill.where(name:f).exists?)
          skill = Skill.new(:name=>f)
          # project.skills << skill
        else
          skill = Skill.where(:name => f)
          # project.skills << skill
        end
      end
      redirect_to projects_path
      # Other wise create and update existence table
    else
      render 'projects/new'
    end

  end

  def edit
    @current_user = current_user
    @skillArray = []
    @project = Project.find(params[:id])
    @project.skills.each do |s|
      @skillArray << s.name
    end
  end

  private

    def project_params
      params.require(:project).permit(:title, :description, :creator, :min_budget, :max_budget, :close_date,:assigned_to,:status,:close)
    end
    
    # def skill_params
    #   params.require(:skill).permit(:name)
    # end
end

