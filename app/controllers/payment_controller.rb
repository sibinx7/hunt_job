class PaymentController < ApplicationController
  private
  def payment_params
    params.require(:payment).permit(:sender,:receiver,:project,:bid,:milestone,:payment)
  end
end