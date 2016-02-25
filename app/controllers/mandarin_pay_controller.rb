class MandarinPayController < ApplicationController
  before_action :create_notification

  def paid
    if @notification.valid_result_signature?
      instance_exec @notification, &MandarinPay.result_callback
    else
      instance_exec @notification, &MandarinPay.fail_callback
    end
  end

  def success
    if @notification.valid_success_signature?
      instance_exec @notification, &MandarinPay.success_callback
    else
      instance_exec @notification, &MandarinPay.fail_callback
    end
  end

  def fail
    instance_exec @notification, &MandarinPay.fail_callback
  end

  private

  def create_notification
    if request.get?
      @notification = MandarinPay::Notification.new request.query_parameters
    elsif request.post?
      @notification = MandarinPay::Notification.new request.request_parameters
    end
  end
end
