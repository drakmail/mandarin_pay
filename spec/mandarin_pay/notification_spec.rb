# frozen_string_literal: true
require "spec_helper"

describe MandarinPay::Notification do
  before(:each) do
    MandarinPay.configure do |config|
    end
  end

  it "should return correct valid_card_binding_signature?" do
    data = {
      "orderId" => "12",
      "price" => "1200",
      "sign" => "e3daf8ea5021343c455853a27901a2355a5db5d3c29b9c3f0ce9869a040ce593"
    }
    notification = MandarinPay::Notification.new(data)
    expect(notification.valid_card_binding_signature?).to eq true
  end

  it "should return correct valid_payment_signature?" do
    data = {
      "orderId" => "12",
      "price" => "1200",
      "sign" => "dd00e1d8e77ae1b62e5c05a9023ebda218d94955202ad323563046fc10f19a98"
    }
    notification = MandarinPay::Notification.new(data)
    expect(notification.valid_payment_signature?).to eq true
  end

  it "should return correct valid_transaction_signature?" do
    data = {
      "orderId" => "12",
      "price" => "1200",
      "sign" => "e3daf8ea5021343c455853a27901a2355a5db5d3c29b9c3f0ce9869a040ce593"
    }
    notification = MandarinPay::Notification.new(data)
    expect(notification.valid_transaction_signature?).to eq true
  end

  it "should return correct success" do
    notification = MandarinPay::Notification.new(Hash["InvId", "12"])
    expect(notification.success).to eq "OK"
  end

  it "should raise error when wrong kind argument is passed to signature generator" do
    expect do
      notification = MandarinPay::Notification.new({})
      notification.generate_signature_for(:bullshit)
    end.to raise_error(ArgumentError, "Available kinds are only :payment, :card_binding or :transaction")
  end
end
