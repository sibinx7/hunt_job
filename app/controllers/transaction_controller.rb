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
    @available_money = available_money_to_withdraw
    @transaction = Transaction.new
    @bank_accounts = BankAccount.where(:user_id => current_user.id.to_i)
    render 'dashboard/withdraw_money_new'
  end
  def withdraw_money


    availableMoney = available_money_to_withdraw
    if params[:transaction][:amount].to_i < availableMoney.to_i
      @widthdraw = Transaction.create(transaction_params)
      if @widthdraw.save
        redirect_to :controller => 'transaction',:action => 'withdraw_receipt',:transaction_id => @widthdraw.id
      else
        redirect_to transaction_withdraw_money_new_url
      end
    else
      redirect_to transaction_withdraw_money_new_url
    end
  end

  def withdraw_receipt
    @receipt = Transaction.find(params[:transaction_id])
    render 'dashboard/add_fund_receipt'
  end
  private
  def available_money_to_withdraw
    available_money = 0
    credited_money = 0
    debited_Money = 0
    @project_income = UserProjectDetail.find_by_user_id(current_user.id.to_i)
    unless @project_income.nil?
      @user_add_money = Transaction.where(:user_id => current_user.id.to_i,:transaction_type => "credit").sum(:amount)
      credited_money = @user_add_money.present? ? @user_add_money : 0
      @user_withdraw_money = Transaction.where(:user_id => current_user.id.to_i,:transaction_type => "debit").sum(:amount)
      debited_Money = @user_withdraw_money.present? ? @user_withdraw_money : 0
      available_money = ((@project_income.user_income.present? ? @project_income.user_income.to_i : 0) - (@project_income.user_lost_money.present? ? @project_income.user_lost_money.to_i : 0)) + (credited_money.to_i - debited_Money.to_i) - 5
    end
    return available_money
  end

  def transaction_params
    params.require(:transaction).permit(:user_id,:amount,:transaction_id,:transaction_type,:bank_account_id,:created_at,:updated_at)
  end
end