class ProjectsController < InheritedResources::Base
  # before_action :authenticate_user?

  layout "dashboard"

  def index
    @projects = Project.where(:creator => current_user.id).paginate(:page => params[:page],:per_page => 1)
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
      @notification = Notification.new
      @notification.title= "You have been created a Project"
      @notification.content = "<p>A new Project <b>#{project.title}</b> created. For more information check this Project page"
      @notification.user_id = current_user.id
      @notification.not_type = "project"
      @notification.project_id = project.id
      @notification.related_task = project.id
      @notification.link = "#{projects_path}/#{project.id}"
      @notification.save
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
  # When project creator mark as complete or lost
  def project_status
    if current_user.id.to_i == params[:project_owner].to_i
      @project_owner = User.find(params[:project_owner])
      @bid_user = User.find(params[:bid_user])
      @project = Project.find(params[:project_id])
      @project.close = 1
      project_status_flag = ""
      # status 1 means completed and 2 means lost, we close project for both case
      if params[:type] == "project_complete"
        # When user marked as completed
        @project.status = 1
        project_status_flag = "Completed"
      elsif params[:type] == "project_lost"
        # When user marked as lost
        @project.status = 2
        project_status_flag = "Lost"
      end
      if @project.save
        puts "Saved success"
        # Notify bid user
        @notification = Notification.new
        @notification.title = "#{@project_owner.name} Mark Project as #{project_status_flag}"
        @notification.content = "#{@project_owner.name} Marked your latest completed Project as #{project_status_flag}, You can check it
        Project Dashboard"
        @notification.not_type = "project"
        @notification.project_id = @project.id
        @notification.related_task = params[:bid_id]
        @notification.user_id = @bid_user.id
        @notification.link = "#{url_for :controller => 'bid',:action => 'bid_dashboard',:project=>@project.id ,:bid=> params[:bid_id]}"
        @notification.save
        if project_status_flag == "Lost"
          render :json => {"status"=>"success","message"=>"Project Marked as Lost","project_status"=>"lost"}
        elsif project_status_flag  == "Completed"
          render :json =>  {"status"=>"success","message"=>"Project Marked as Completed","project_status"=>"completed"}
        end

      end
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

