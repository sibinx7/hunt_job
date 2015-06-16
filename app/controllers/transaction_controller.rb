class TransactionController < ApplicationController
  layout 'dashboard'
  def add_money_new
    @transaction = Transaction.new
    @bank_accounts = BankAccount.where(:user_id => current_user.id.to_i)
    render 'dashboard/add_money_new'
  end
  def add_money
    @add_credit = Transaction.create(transaction_params)
    if @add_credit.save
      redirect_to :controller => 'transaction',:action => 'add_money_receipt',:transaction_id=>@add_credit.id
    else
      redirect_to transaction_add_money_new_url
    end
  end
  def add_money_receipt
    @receipt = Transaction.find(params[:transaction_id])
    render 'dashboard/add_fund_receipt'
  end


  def withdraw_money_new
    @transaction = Transaction.new
    @bank_accounts = BankAccount.where(:user_id => current_user.id.to_i)
    render 'dashboard/withdraw_money_new'
  end
  def withdraw_money
    @widthdraw = Transaction.create(transaction_params)
    if @widthdraw.save
      redirect_to :controller => 'transaction',:action => 'withdraw_receipt',:transaction_id => @widthdraw.id
    else
      redirect_to transaction
    end
  end

  def withdraw_receipt
    @receipt = Transaction.find(params[:transaction_id])
    render 'dashboard/add_fund_receipt'
  end
  private
  def transaction_params
    params.require(:transaction).permit(:user_id,:amount,:transaction_id,:transaction_type,:bank_account_id,:created_at,:updated_at)
  end
end