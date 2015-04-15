class BankAccountsController < InheritedResources::Base
  layout 'dashboard'
  def index
    @bank_accounts = BankAccount.where(:user_id => current_user.id)
    redirect_to :controller => 'user_extras',:action => 'user_info',:id=>current_user.id
  end

  def show
    @user = User.find(current_user.id)
    @bank_account = BankAccount.find(params[:id])
  end
  private


    def bank_account_params
      params.require(:bank_account).permit(:user_id,:name,:address,:place,:account_no,:ifsc_code,:card_no,:card_csc)
    end
end

