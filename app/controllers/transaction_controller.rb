class TransactionController < ApplicationController
  layout 'dashboard'
  def add_money_new
    @transaction = Transaction.new
    @bank_accounts = BankAccount.where(:user_id => current_user.id.to_i)

    puts @bank_accounts.inspect
    render 'dashboard/add_money_new'
  end
  def add_money
    @add_credit = Transaction.create(transaction_params)
    if @add_credit.save

    else

    end
  end
  def add_money_receipt

  end
  private
  def transaction_params
    params.require(:transaction).permit(:user_id,:amount,:transaction_id,:transaction_type,:bank_account_id,:created_at,:updated_at)
  end
end