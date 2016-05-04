# frozen_string_literal: true

require "spec_helper"

describe MandarinPay::PaymentInterface do
  let(:payment_interface) do
    MandarinPay::PaymentInterface.new do
      self.price = 123.00
      self.order_id = 123
      self.customer_email = "user@example.com"
    end
  end

  before(:each) do
    MandarinPay.configure do |config|
      config.merchant_id = "1"
      config.sharedsec = "123"
    end
  end

  it "should return correct base_url" do
    expect(payment_interface.base_url).to eq "https://secure.mandarinpay.com/Pay"
  end

  it "should return correct pay_params" do
    data = { "merchantId" => "1",
             "price" => "123.00",
             "orderId" => 123,
             "sign" => "61d7d36e47e7750591a29eaa770634618de7c1645800bc012ef87998ecba7b7e",
             "customer_email" => "user@example.com" }
    expect(payment_interface.pay_params).to eq data
  end

  it "should return correct initial_options" do
    expect(payment_interface.initial_options). to eq(merchant_id: "1",
                                                     price: 123.00,
                                                     order_id: 123)
  end
end
