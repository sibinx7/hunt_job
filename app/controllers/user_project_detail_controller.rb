class UserProjectDetailController < ApplicationController
  private
  def user_project_detail_params
    params.require(:user_project_detail).permit(:user_id,:project_conpleted,:project_ongoing,:project_lost,:user_income)
  end
end