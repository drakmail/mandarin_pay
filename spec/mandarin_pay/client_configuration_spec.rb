require "spec_helper"

describe MandarinPay::Client do
  before(:each) do
    MandarinPay.configure do |config|
      config.login = "name"
      config.first_password = "first_password"
      config.second_password = "second_password"
      config.mode = :production
      config.http_method = :post
      config.xml_http_method = :post
    end
  end

  it "should set configuration information correctly" do
    expect(MandarinPay.login).to eq "name"
    expect(MandarinPay.first_password).to eq "first_password"
    expect(MandarinPay.second_password).to eq "second_password"
    expect(MandarinPay.mode).to eq :production
    expect(MandarinPay.http_method).to eq :post
  end

  it "should set default values" do
    MandarinPay.configure do |config|
    end

    expect(MandarinPay.login).to eq "your_login"
    expect(MandarinPay.first_password).to eq "first_password"
    expect(MandarinPay.second_password).to eq "second_password"
    expect(MandarinPay.mode).to eq :test
    expect(MandarinPay.http_method).to eq :get
    expect(MandarinPay.http_method).to eq :get
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
    expect {
      MandarinPay.configure do |config|
        config.mode = :bullshit
      end
    }.to raise_error(MandarinPay::ConfigurationError, "Available modes are :test or :production")
  end

  it "should raise error when wrong http_method is set" do
    expect {
      MandarinPay.configure do |config|
        config.http_method = :bullshit
      end
    }.to raise_error(MandarinPay::ConfigurationError, "Available http methods are :get or :post")
  end
end
