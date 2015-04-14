class BidController < ApplicationController
  def show
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
  private
    def bid_params
      params.require(:bid).permit(:details,:project_id,:user_id,:bid,:duration)
    end
end
