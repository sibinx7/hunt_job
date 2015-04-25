class MilestoneController < ApplicationController

  # Save bid progress bid_id, bid_progress, milestone_id, milestone_progress, owner_id
  def milestone_progress
    # When current user is bid and milestone owner
    if current_user.id.to_i == params[:m_creator].to_i
      @milestone = Milestone.find(params[:m_id])
      @milestone.percentage = params[:m_progress]
      if @milestone.save
        @bid = Bid.find(params[:bid_id])
        @bid.percentage = params[:bid_progress]
        @bid.save
      end
      render json:{"message"=>"Updated","status"=>"success"}
    else
      render json:{"status"=>"failed","message"=>"Permission denied"}
    end
  end
  private
  def milestone_params
    param.require(:milestone).permit(:milestone,:bid_id,:payment)
  end
end