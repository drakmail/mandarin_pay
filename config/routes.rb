# frozen_string_literal: true

Rails.application.routes.draw do
  if MandarinPay::Client.configuration
    scope "/mandarin_pay" do
      %w(paid success fail).map do |route|
        post "/#{route}" => "mandarin_pay##{route}", as: "mandarin_pay_#{route}"
      end
    end
  end
end
