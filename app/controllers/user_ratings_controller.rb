class UserRatingsController < InheritedResources::Base
  layout "dashboard"
  def index
    @user_ratings = UserRating.where(:rated_by => current_user.id.to_i).paginate(:page => params[:page],:per_page => 10)
  end

  def  new
    if params[:project_id]
      @project = Project.find(params[:project_id])
      if @project.creator.to_i == current_user.id.to_i
        @user_rating = UserRating.new
        @rate_for = User.find(@project.assigned_to)
        @all_ratings = UserRating.where(:user_id => @user_rating.user_id ).order('created_at DESC').limit(12)
        # For safety, check project id, owner = current_user_id, rate_for user should related to project.assigned_to
      else
        redirect_to projects_url
      end
    else
      redirect_to projects_url
    end
  end
  def create
    @user_rating = UserRating.new(user_rating_params)
    if @user_rating.valid?
      if @user_rating.save
        update_user_rating(@user_rating.user_id)
        redirect_to user_rating_url(@user_rating.id)
      else
        redirect_to :controller => 'user_ratings',:action => 'new', :project_id => @user_rating.project_id
      end
    else
      redirect_to :controller => 'user_ratings',:action => 'new', :project_id => @user_rating.project_id
    end
  end
  def show
    @user_rating = UserRating.find(params[:id])
    @all_ratings = UserRating.where(:user_id => @user_rating.user_id ).order('created_at DESC').limit(12)
  end
  def edit
    @user_rating = UserRating.find(params[:id])
    @project = Project.find(@user_rating.project_id)
    @rate_for = User.find(@project.assigned_to)
    @all_ratings = UserRating.where(:user_id => @user_rating.user_id ).order('created_at DESC').limit(12)
  end
  def update
    @user_rating = UserRating.find(params[:id])
    if @user_rating.valid?
      @user_rating.update(user_rating_params)
      update_user_rating(@user_rating.user_id)
      redirect_to user_rating_url(@user_rating.id)
    else
      redirect_to :controller => 'user_ratings',:action => 'edit', :id => @user_rating.id
    end
  end
  def rating_for_user
    @user_rating = UserRating.where(:user_id => params[:user_id]).paginate(:page => params[:page],:per_page => 10)
  end
  private
    def update_user_rating(user_id)
      @get_user = UserRating.where(:user_id => user_id)
      @get_sum = @get_user.sum(:rating)
      @get_count = @get_user.count
      average = @get_sum/@get_count
      @updateUser = User.find(user_id)
      @updateUser.user_rating = average
      @updateUser.save
    end
    def user_rating_params
      params.require(:user_rating).permit(:user_id, :description, :rating, :rated_by, :project_id)
    end
end

