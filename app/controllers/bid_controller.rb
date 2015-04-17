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
    @bid.update(bid_params)
    @bid.milestones.delete
    params[:bid][:task].each_with_index do |f,index|
      if Milestone.where(:milestone =>f,:bid_id=>@bid.id ,:payment => params[:bid][:milestone][index]).count == 0 && !f.blank?
        @milestone = Milestone.new
        @milestone.milestone = f
        @milestone.bid_id = @bid.id
        @milestone.payment = params[:bid][:milestone][index]
        @milestone.save
      end
    end
    redirect_to :controller => 'dashboard',:action => 'project',:project => params[:bid][:project_id]
  end

  def destroy
    @bid = Bid.find(params[:bid])
    @bid.milestones.delete
    @bid.destroy
    redirect_to :controller => 'dashboard',:action => 'project',:project => params[:project_id]
  end

  # Extra method for accept/reject, grant bids
  def grant
    @project = Project.find(params[:project_id])
    @bid = Bid.find(params[:bid_id])
    # Project creator and current user are same
    if @project.creator.to_i == current_user.id.to_i
      @bid.granted = 1
      if @bid.save
        render json: {"status"=> "success"}
      else
        render json: {"status"=>"failure"}
      end
    end
  end

  # We can find granted bids
  def granted

  end

  private
    def bid_params
      params.require(:bid).permit(:details,:project_id,:user_id,:bid,:duration)
    end
end
