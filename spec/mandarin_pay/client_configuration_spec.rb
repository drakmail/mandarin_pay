# frozen_string_literal: true

require "spec_helper"

describe MandarinPay::Client do
  before(:each) do
    MandarinPay.configure do |config|
      config.merchant_id = "your_custom_merchant_id"
      config.sharedsec = "custom_sharedsec"
      config.mode = :production
    end
  end

  it "should set configuration information correctly" do
    expect(MandarinPay.merchant_id).to eq "your_custom_merchant_id"
    expect(MandarinPay.sharedsec).to eq "custom_sharedsec"
    expect(MandarinPay.mode).to eq :production
  end

  it "should set default values" do
    MandarinPay.configure do |config|
    end

    expect(MandarinPay.merchant_id).to eq "your_merchant_id"
    expect(MandarinPay.sharedsec).to eq "sharedsec"
    expect(MandarinPay.mode).to eq :test
    expect(MandarinPay.success_callback).to be_instance_of(Proc)
    expect(MandarinPay.fail_callback).to be_instance_of(Proc)
  end

  it "should set success_callback" do
    MandarinPay.configure do |config|
      config.success_callback = -> { 2 + 5 }
    end

    expect(MandarinPay.success_callback.call).to eq(7)
  end

  it "should raise error when wrong mode is set" do
    expect do
      MandarinPay.configure do |config|
        config.mode = :bullshit
      end
    end.to raise_error(MandarinPay::ConfigurationError, "Available modes are :test or :production")
  end
end
