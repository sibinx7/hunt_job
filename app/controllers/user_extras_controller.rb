class UserExtrasController < ApplicationController
  layout 'dashboard'

  def user_info
    @user = User.find(params[:id])
  end

  def user_skill_info
    @user = User.find(params[:id])
    @userSkills = @user.skills
  end
  def add_user_info
    @user = User.find(params[:id])
  end

  def save_user_info
    puts "#{current_user.id}=#{params[:id]}"
    if params[:id] == "#{current_user.id}"
      @user = User.find(params[:id])
      @user.name = params[:user][:name]
      @user.username = params[:user][:username]
      @user.country  = params[:user][:country]
      @user.save
    end
    return redirect_to user_extras_add_user_info_url(:id=>params[:id])
  end
  def add_user_image
    @user = User.find(params[:id])
  end

  def save_user_image
    if params[:id] == "#{current_user.id}"
      @user = User.find(params[:id])
      @user.profile_image = params[:user][:profile_image]
      @user.save
      puts @user.errors.full_messages.inspect
      render :json => {
                 :user => @user
             }
    else
      render :json => {
                 :message => "Some error occured"
             }
    end

  end

  private
  def user_params
    params.require(:user).permit(:profile_image)
  end
end
