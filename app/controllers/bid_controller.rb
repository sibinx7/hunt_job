class BidController < ApplicationController
  layout 'dashboard'
  def show
    @project = Project.find(params[:project])
    @bids = @project.bids.find(params[:bid])
    @project_owner = User.find(@project.creator)
    @bid_user = User.find(@bids.user_id)
  end

  def create
    if Bid.where(:user_id => params[:bid][:user_id],:project_id=> params[:bid][:project_id]).count == 0
      @bid = Bid.create(bid_params)
      params[:bid][:task].each_with_index do |f,index|
        if Milestone.where(:milestone =>f,:bid_id=>@bid.id ,:payment => params[:bid][:milestone][index]).count == 0 && !f.blank?
          @milestone = Milestone.new
          @milestone.milestone = f
          @milestone.bid_id = @bid.id
          @milestone.payment = params[:bid][:milestone][index]
          @milestone.save
        end
      end
      # When user create Bid, User Project details page will update
      if UserProjectDetail.where(:user_id => params[:bid][:user_id]).count == 0
        @userProjectDetails = UserProjectDetail.new
        @userProjectDetails.user_id = params[:bid][:user_id]
        @userProjectDetails.save
      end
      # Update notification table of project creator and bidder
      @project = Project.find(params[:bid][:project_id])
      @creator_not = Notification.new
      @creator_not.title = "You have received a new Bid"
      @creator_not.content = "<p>#{current_user.name} placed a new Bid on your Project <b>#{@project.title}</b>.Quoted Budget is around
      $ #{params[:bid][:bid]}.</p><p>Estimated Project duration is #{params[:bid][:duration]}</p></p>You can see more details on
      Project Bid page</p>"
      @creator_not.user_id = @project.creator
      @creator_not.not_type = "bid"
      @creator_not.project_id = @project.id
      @creator_not.related_task = @bid.id
      @creator_not.link = "#{url_for :controller => 'dashboard',:action => 'project',:project=> @project.id}"
      @creator_not.save

      # For Bid user

      @bid_not = Notification.new
      @bid_not.title = "You have been placed a new Bid"
      @bid_not.content = "<p>You create a new Bid on Project #{@project.title}.
       You have been quote $#{params[:bid][:bid]} for #{params[:bid][:duration]} days work.</p>
      <p>More information available on project page</p>"
      @bid_not.user_id = current_user.id
      @bid_not.not_type = "bid"
      @bid_not.project_id = @project.id
      @bid_not.related_task = @bid.id
      @bid_not.link = "#{url_for :controller => 'dashboard',:action => 'project',:project=> @project.id}"
      @bid_not.save
    end
    redirect_to :controller => 'dashboard',:action => 'project',:project => params[:bid][:project_id]
  end

  def update
    @bid = Bid.find(params[:id])
    @milestones = Milestone.where(:bid_id => params[:id])
    @milestones.each do |milestone|
      @bid.milestones.destroy(milestone)
    end
    @bid.update(bid_params)

    params[:bid][:task].each_with_index do |f,index|
      if Milestone.where(:milestone =>f,:bid_id=>@bid.id ,:payment => params[:bid][:milestone][index]).count == 0 && !f.blank?
        @milestone = Milestone.new
        @milestone.milestone = f
        @milestone.payment = params[:bid][:milestone][index]
        @milestone.bid_id = @bid.id
        @milestone.save
      end
    end
    redirect_to :controller => 'dashboard',:action => 'project',:project => params[:bid][:project_id]
  end

  def destroy_bid
    @bid = Bid.find(params[:bid])
    @milestones = Milestone.where(bid_id:params[:bid])
    @milestones.each do |milestone|
      @bid.milestones.destroy(milestone)
    end
    @bid.destroy
    redirect_to :controller => 'dashboard',:action => 'project',:project => params[:project]
  end

  # Extra method for accept/reject, grant bids
  def grant
    @project = Project.find(params[:project_id])
    @project_owner = User.find(@project.creator)
    @bid = Bid.find(params[:bid_id])
    # Project creator and current user are same
    if @project.creator.to_i == current_user.id.to_i
      @bid.granted = 1
      if @bid.save
        @notification = Notification.new
        @notification.title = "You have been awarded a new Project"
        @notification.content = "#{@project_owner.name} awarded #{@project.title}, You can Accept/Reject this project. Please see
        Project page to know more about your bid"
        @notification.not_type = "bid"
        @notification.user_id = @bid.user_id
        @notification.related_task = @bid.id
        @notification.link = "#{url_for :controller => 'bid',:action => 'show',:project=> @project.id,:bid => @bid.id}"
        @notification.save
        render json: {"status"=> "success"}
      else
        render json: {"status"=>"failure"}
      end
    end
  end

  def user_reaction
    @project = Project.find(params[:project_id])
    @bid = Bid.find(params[:bid_id])
    @bid_user = User.find(params[:bid_user])
    if @bid.user_id.to_i == current_user.id.to_i
      if params[:user_action]
        if params[:user_action].to_s == "reject"
          @bid.accepted = 0
        elsif params[:user_action].to_s == "accept"
          @bid.accepted = 1
          @bid.accepted_date = Time.now
        end
        if @bid.save
          @notification = Notification.new
          if @bid.accepted
            # Save On Project table , update assigned to status
            @project.assigned_to = @bid_user.id
            @project.status = 0
            @project.save
            # Update UserProject table
            @userProjectDetail = UserProjectDetail.find_by_user_id(@bid_user.id)
            @userProjectDetail.project_ongoing = @userProjectDetail.project_ongoing.to_i + 1;
            @userProjectDetail.save
            @notification.title = "Your Project has been accepted"
            @notification.content = "#{@bid_user.name} accepted #{@project.title}, You can watch your Project process. Please see
            Project page to know more about your bid"
          else
            @notification.title = "You Project has been rejected"
            @notification.content = "#{@bid_user.name} rejected  #{@project.title}. Please see
            Project page to know more about your bid"
          end
          @notification.not_type = "bid"
          @notification.user_id = @project.creator
          @notification.project_id = @project.id
          @notification.related_task = @bid.id
          @notification.link = "#{url_for :controller => 'bid',:action => 'show',:project=> @project.id,:bid => @bid.id}"
          @notification.save

          # Pass info to bidder
          @notification = Notification.new
          if @bid.accepted
            @notification.title = "Your have been accept new Project"
            @notification.content = "You accepted #{@project.title}, You can watch your Project process. Please see
            Project page to know more about your bid"
          else
            @notification.title = "You have been reject new Project"
            @notification.content = "You rejected  #{@project.title}. Please see
            Project page to know more about your bid"
          end
          @notification.not_type = "bid"
          @notification.user_id = @bid.user_id
          @notification.project_id = @project.id
          @notification.related_task = @bid.id
          @notification.link = "#{url_for :controller => 'bid',:action => 'show',:project=> @project.id,:bid => @bid.id}"
          @notification.save
        end
      end
    end
    if @bid.accepted
      render json: {"status"=>"accepted"}
    else
      render json: {"status"=>"rejected"}
    end
  end

  def bid_dashboard
    @project = Project.find(params[:project])
    @bids = Bid.find(params[:bid])
    @project_owner = User.find(@project.creator)
    @bid_user = User.find(@bids.user_id)
  end

  # Bid creator can mark bid as complete
  def bid_completed
    if current_user.id.to_i == params[:bid_owner].to_i
      @bids = Bid.find(params[:bid_id])
      @bids.status = 1
      if @bids.save
        # When Bid save, Update project owner that bid is completed
        @project = Project.find(params[:project_id])
        @user = User.find(params[:bid_owner])
        @notification         = Notification.new
        @notification.title   = "#{@user.name} marked #{@project.title} as Completed"
        @notification.content = "<b>#{@project.title}</b> marked as Completed, Please Update your Project as Completed, If it not ok contact
        Developer. If you feel it as Lost one, You can ,mark it as <b> Lost Project</b>"
        @notification.user_id = @project.creator
        @notification.not_type = "bid"
        @notification.project_id = @project.id
        @notification.related_task = @bids.id
        @notification.link = "#{url_for :controller => 'bid',:action => 'bid_dashboard',:project=>@project.id,:bid=>@bids.id}"
        @notification.save
        render :json => {"status"=>"success","message"=>"Your feedback has been send"}
      end
    end
  end
  # When Project owner mark Project as Lost either he didn't like or time expired
  def project_lost_request
    @project = Project.find(params[:project])
    @bid = Bid.find(params[:bid])
    @project_owner = User.find(@project.creator.to_i)
    @bid_user = User.find(@bid.user_id)
  end

  def project_lost_request_post
    bid_id = params[:bid][:bid_id]
    @project = Project.find(params[:bid][:project_id])
    @project_owner = User.find(@project.creator)
    @bid = Bid.find(bid_id)
    @bid.client_feedback = params[:bid][:client_feedback]
    @bid.status = 0
    @bid.save
    puts "----------Bid status changed-------skip error"
    # Milestone update at 0
    @milestones = Milestone.where(:bid_id => @bid.id,:status => nil)
    @milestones.each do |milestone|
      milestone.status = 0
      milestone.save
    end
    puts "-------------Milestone status changed-----------skip error"
    # Once we save mark project as lost one
    @project.status = 2
    @project.close = 1
    @project.combination = Time.now
    @project.save
    puts "-------------------Project saved ------- skip error"
    # Update Project User table that Project lost
    @user_project_details = UserProjectDetail.find_by_user_id(@bid.user_id)
    @user_project_details.project_ongoing = @user_project_details.project_ongoing.to_i  - 1
    @user_project_details.project_lost = @user_project_details.project_lost.to_i  + 1
    # Find sum of payment where milestone is not completed
    @lostmilestones = Milestone.where(:bid_id => @bid.id,:status => 0).sum(:payment)
    @user_project_details.user_lost_money = @user_project_details.user_lost_money.to_i + @lostmilestones.to_i
    @user_project_details.save
    puts "-----------------User project details updated ------------skip"
    # Update notification
    @notification = Notification.new
    @notification.title = "#{@project_owner.name} mark #{@project.title} as a Lost Project"
    @notification.content = "#{@project_owner.name} made #{@project.title} as Lost Project. Itmay either due to Project expire or due to some
    other reasons, you can contact using Email ID. We have been move Unfinished milestone payment as Lost money. This will be shown in your dashboard"
    @notification.not_type = "bid"
    @notification.user_id = @bid.user_id
    @notification.project_id = @project.id
    @notification.related_task = @bid.id
    @notification.link = "#{url_for :controller => 'bid',:action => 'lost_project_report',:project=>@project.id,:bid=>@bid.id}"
    @notification.save
    redirect_to :controller => 'bid',:action => 'bid_dashboard',:project=>@project.id,:bid=>@bid.id
  end

  def lost_project_report
    @project = Project.find(params[:project])
    @project_owner = User.find(@project.creator)
    @bid = Bid.find(params[:bid])
    @bid_owner = User.find(@bid.user_id)
  end
  private
    def bid_params
      params.require(:bid).permit(:details,:project_id,:user_id,:bid,:duration,:client_feedback)
    end
end
