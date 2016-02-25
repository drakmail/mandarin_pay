require "mandarin_pay/action_view_extension"

module MandarinPay
  class Engine < ::Rails::Engine
    initializer "mandarin_pay.action_view_extension" do
      ActionView::Base.send :include, MandarinPay::ActionViewExtension
    end
  end
end
