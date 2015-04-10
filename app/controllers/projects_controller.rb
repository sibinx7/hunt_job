class ProjectsController < InheritedResources::Base
  # before_action :authenticate_user?

  layout "dashboard"

  def index
    @projects = Project.paginate(:page => params[:page],:per_page => 20)
    @projectArray = Array.new
    @projects.each_with_index do |f,index|
      @projectArray[index] =  {
          'skills'     => Project.find(f.id).skills,
          'creator'    => User.find(f.creator).name
      }

    end
  end

  def show
    @project = Project.find(params[:id])
    @projectCreator = User.find(@project.creator).name
  end


  def create
    # Save project data

    @my_skills = params[:project][:skill].split(",")

    project = Project.new(project_params)
    saved = project.save
    # puts YAML::dump(params)
    if saved
      # Check existence  of skills, if exist update relation table
      @my_skills.each  do |skills|
        if not (Skill.where(name:skills).exists?)
          project.skills <<  Skill.new(:name => skills)
        else
         project.skills <<  Skill.where(name:skills)
        end
      end
      redirect_to projects_path

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

  def update
    @my_skills = params[:project][:skill].split(",")
    @project   = Project.find(params[:id])
    saved = @project.update(project_params)
    @project.skills.clear
    if  saved
      # Check existence  of skills, if exist update relation table
      @my_skills.each  do |skills|
        if not (Skill.where(name:skills).exists?)
          @project.skills <<  Skill.new(:name => skills)
        else
          @project.skills <<  Skill.where(name:skills)
        end
      end
      redirect_to projects_path

    else
      render action :update, :params => {:id => params[:id]}
    end

  end

  def destroy
    @project = Project.find(params[:id])
    @project.skills.clear
    @project.delete
    redirect_to projects_path
  end
  private

    def project_params
      params.require(:project).permit(:title, :description, :creator, :min_budget, :max_budget, :close_date,:assigned_to,:status,:close)
    end

    def skill_params
      params.require(:skill).permit(:id,:name)
    end
end

