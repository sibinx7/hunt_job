class MilestoneController < ApplicationController

  # Save bid progress bid_id, bid_progress, milestone_id, milestone_progress, owner_id
  def milestone_progress
    # When current user is bid and milestone owner
    if current_user.id.to_i == params[:m_creator].to_i
      @milestone = Milestone.find(params[:m_id])
      @milestone.percentage = params[:m_progress]
      if @milestone.save
        @bid = Bid.find(params[:bid_id])
        @bid.percentage = Milestone.average(:percentage,:conditions => {:id=>params[:m_id]})
        @bid.save
      end
      render json:{"message"=>"Updated","status"=>"success"}
    else
      render json:{"status"=>"failed","message"=>"Permission denied"}
    end
  end

  # When user complete/ close milestone
  def milestone_complete
    if current_user.id.to_i == params[:m_creator].to_i
      @milestone = Milestone.find(params[:m_id])
      @milestone.status = 1
      if @milestone.save
        render json: {"message"=>"status updated","status"=>"success","milestone"=> @milestone.id}
      end
    else
      render json:{"status"=>"failed","message"=>"Permission denied"}
    end
  end

  # When user request or grant payment
  def milestone_payment
    # When user is milestone/bid creator
    puts params.inspect
    if current_user.id.to_i == params[:m_creator].to_i && params[:m_type]=='request_payment'
      @milestone = Milestone.find(params[:m_id])
      @milestone.request_payment = 1
      if @milestone.save
        @project = Project.find(params[:project_id])
        # For milestone creator
        @notification = Notification.new
        @notification.title = "Milestone payment requested"
        @notification.content = "You have been requested milestone Payment for #{@project.title}"
        @notification.not_type = "payment"
        @notification.user_id = params[:m_creator]
        @notification.related_task = @milestone.bid_id
        @notification.link = "#{url_for :controller => 'bid',:action => 'bid_dashboard',:project=>@project.id,:bid=>@milestone.bid_id}"
        @notification.save
        # Notify project creator
        @notification = Notification.new
        @notification.title = "You have been received a Milestone Payment"
        @notification.content = "You have received a  milestone Payment for #{@project.title}"
        @notification.not_type = "payment"
        @notification.user_id = @project.creator
        @notification.related_task = @milestone.bid_id
        @notification.link = "#{url_for :controller => 'bid',:action => 'bid_dashboard',:project=>@project.id,:bid=>@milestone.bid_id}"
        @notification.save
        render json: {"status"=>"success","message"=>"You have been requested for Payment"}
      end
    # When user is project owner
    elsif current_user.id.to_i == params[:project_owner].to_i && params[:m_type] == 'release_payment'
      puts "I am enterd release payment"
      @milestone = Milestone.find(params[:m_id])
      @milestone.grant_payment = 1
      if @milestone.save
        @project = Project.find(params[:project_id])
        @projectOwner = User.find(@project.creator)
        # Update Payment table
        @payment = Payment.new
        @payment.sender = @project.creator
        @payment.receiver = params[:m_creator].to_i
        @payment.payment = @milestone.payment
        puts "I am stuck"
        puts @project.id
        @payment.project_id = @project.id
        puts "Issues skipped"
        @payment.bid_id = @milestone.bid_id
        @payment.milestone_id = @milestone.id
        @payment.save
        puts "Before updating User Project"
        # Save income table
        if not UserProjectDetail.exists?(:user_id => params[:m_creator])
          @userProjectDetail = UserProjectDetail.new
          @userProjectDetail.user_id = params[:m_creator]
          @userProjectDetail.project_completed = Project.where(:assigned_to => params[:m_creator],:status => 1).count
          @userProjectDetail.project_ongoing   = Project.where(:assigned_to => params[:m_creator],:status => 0).count
          @userProjectDetail.project_lost      = Project.where(:assigned_to => params[:m_creator],:status => 2).count
          @userProjectDetail.user_income       = (@userProjectDetail.user_income.to_i + @payment.payment)
          @userProjectDetail.save
        else
          puts "I am updating exsting record of #{params[:m_creator]}"
          @userProjectDetail = UserProjectDetail.find_by(:user_id => params[:m_creator])
          puts @userProjectDetail.inspect
          @userProjectDetail.project_completed = Project.where(:assigned_to => params[:m_creator],:status => 1).count
          @userProjectDetail.project_ongoing   = Project.where(:assigned_to => params[:m_creator],:status => 0).count
          @userProjectDetail.project_lost      = Project.where(:assigned_to => params[:m_creator],:status => 2).count
          @userProjectDetail.user_income       = (@userProjectDetail.user_income.to_i + @payment.payment)
          @userProjectDetail.save
        end
        # Save notification
        @notification = Notification.new
        @notification.title = "Milestone Payment recieved"
        @notification.content = "<b>#{@projectOwner.name}</b> send Milestone Payment <b>#{@milestone.payment}$</b>or <b>#{@project.title}</b>"
        @notification.not_type = "payment"
        @notification.user_id = params[:m_creator]
        @notification.related_task = @milestone.bid_id
        @notification.link = "#{url_for :controller => 'dashboard',:action => 'payment_details',:project=> @project.id,:bid=>@milestone.bid_id}"
        @notification.save
      end
      render :json => {"status"=>"success","message"=>"payment completed"}
    end
  end
  private
  def milestone_params
    param.require(:milestone).permit(:milestone,:bid_id,:payment,:status,:percentage,:request_payment,:grant_payment)
  end
end