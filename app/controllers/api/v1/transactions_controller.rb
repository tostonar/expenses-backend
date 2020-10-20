class Api::V1::TransactionsController < ApplicationController

  before_action :set_account

  def index
    @transactions = @account.transactions
    render json: @transactions
  end

  def create
    @transaction = @account.transactions.new(transaction_params)
    if @account.update_balance(@transaction) != 'Balance too low.'
      @transaction.save
      render json: @transaction
    else
      render json: {error: 'Balance too low'}
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
    render json: @transaction
  end

  def destroy

  end

  private

  def set_account
    @account = Account.find(params[:account_id])
  end

  def transaction_params
    params.require(:transaction).permit(:account_id, :amount, :kind, :date, :description)
  end







end
