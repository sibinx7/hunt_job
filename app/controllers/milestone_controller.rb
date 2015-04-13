class Milestone < ApplicationController
  private
  def milestone_params
    param.require(:milestone).permit(:milestone,:bid_id,:payment)
  end
end