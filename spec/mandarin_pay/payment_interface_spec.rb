require "spec_helper"

describe MandarinPay::PaymentInterface do
  let(:payment_interface) do
    MandarinPay::PaymentInterface.new do
      self.invoice_id = 12
      self.total = 1200.00
      self.params = { foo: "bar" }
    end
  end

  before(:each) do
    MandarinPay.configure do |config|
    end
  end

  it "should return correct base_url" do
    expect(payment_interface.base_url).to eq "https://auth.robokassa.ru/Merchant/Index.aspx?IsTest=1&"
  end

  it "should return correct pay_url" do
    expect(payment_interface.pay_url).to eq "https://auth.robokassa.ru/Merchant/Index.aspx?IsTest=1&MerchantLogin=your_login&OutSum=1200.00&InvId=12&SignatureValue=ad504f1527d5c5ea3214eab1ad08f31a&shpfoo=bar"
  end

  it "should return correct pay_url when additional options passed" do
    expect(payment_interface.pay_url(description: "desc", culture: "ru", email: "foo@bar.com", currency: "")).to eq "https://auth.robokassa.ru/Merchant/Index.aspx?IsTest=1&MerchantLogin=your_login&OutSum=1200.00&InvId=12&SignatureValue=ad504f1527d5c5ea3214eab1ad08f31a&shpfoo=bar&IncCurrLabel=&Desc=desc&Email=foo@bar.com&Culture=ru"
  end

  it "should return correct initial_options" do
    expect(payment_interface.initial_options). to eq(login: "your_login",
                                                     total: 1200.00,
                                                     invoice_id: 12,
                                                     signature: "ad504f1527d5c5ea3214eab1ad08f31a",
                                                     shpfoo: "bar")
  end

  it "should return correct test_mode?" do
    expect(payment_interface.test_mode?).to eq true
  end
end
