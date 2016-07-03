## The MandarinPay gem

by [Drakmail][]

[Drakmail]: http://drakmail.ru

Ruby wrapper for [MandarinPay API][]. Make Mandarin Pay to work with your Rails project without pain. MandarinPay took the best from [rubykassa gem][] and [Active Merchant Robokassa integration] but easier to use and setup.

[MandarinPay API]: http://mandarin_pay.com/sites/default/files/protokol_integracii_v0.5.5_0.pdf
[rubykassa gem]: https://github.com/ZeroOneStudio/rubykassa
[Active Merchant Robokassa integration]: https://github.com/Shopify/active_merchant/tree/master/lib/active_merchant/billing/integrations/robokassa

## Installation

Add to your `Gemfile`:

    gem "mandarin_pay"

## Usage

Run `rails g mandarin_pay:install`, get an initializer with the following code:

```ruby
MandarinPay.configure do |config|
  config.merchant_id = ENV["MANDARINPAY_MERCHANT_ID"]
  config.sharedsec = ENV["MANDARINPAY_SHAREDSEC"]

  # Result callback is called in MandarinPayController#paid action if valid signature
  # was generated. It should always return "OK#{ invoice_id }" string, so implement
  # your custom logic above `render text: notification.success` line

  config.result_callback = ->(notification) { render text: notification.success }

  # Define success or failure callbacks here like:

  # config.success_callback = ->(notification) { render text: 'success' }
  # config.fail_callback = ->(notification) { redirect_to root_path }
end
```

and configure it with your credentials.

Also, you need to specify Result URL, Success URL and Fail URL at the "Technical Settings" (Технические настройки) in your MandarinPay dashboard:

* Result URL: `http://<your_domain>/mandarin_pay/paid`
* Success URL: `http://<your_domain>/mandarin_pay/success`
* Fail URL: `http://<your_domain>/mandarin_pay/fail`

To define custom success/fail callbacks you can also use the initializer:

    MandarinPay.configure do |config|
      ...
      config.success_callback = ->(notification) { render text: 'success' }
      config.fail_callback    = ->(notification) { redirect_to root_path }
      config.result_callback  = ->(notification) { render text: notification.success }
    end

Lambdas are called in MandarinPayController so you can respond with [any kind that is supported by Rails](http://guides.rubyonrails.org/layouts_and_rendering.html#creating-responses).

NOTE: `result_callback` should always return `"OK"` string. So, implement your custom logic above `render text: notification.success` line.

Once you are done, simply use `pay_form` helper in your view:

    <%= pay_form "Pay with Mandarin Pay", "invoice_number", 20.00 %>

Additionally you may want to pass extra options. There is no problem:

    <%= pay_form "Pay with Mandarin Pay", "invoice_number", 20.00, customer_email: "user@example.com", class: "btn btn-succses", form_class: "mp-form" %>

## Supported Rubies and Rails versions

Rubies: 
* 2.0.0
* 2.1.0
* 2.2.0
* 2.3.0

Rails:
* ~> 4.0.0
* ~> 4.1.0
* ~> 4.2.0

## License

This project rocks and uses MIT-LICENSE
Copyright (c) 2016 [Drakmail][]

[Drakmail]: http://drakmail.ru
