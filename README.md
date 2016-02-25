## The MandarinPay gem

by [Drakmail][]

[Drakmail]: http://drakmail.ru

Ruby wrapper for [Mandarin Pay API][]. Make Mandarin Pay to work with your Rails project without pain. MandarinPay took the best from [rubykassa gem][] and [Active Merchant Robokassa integration] but easier to use and setup.

[MandarinPay API]: http://mandarin_pay.com/sites/default/files/protokol_integracii_v0.5.5_0.pdf
[rubykassa gem]: https://github.com/ZeroOneStudio/rubykassa
[Active Merchant Robokassa integration]: https://github.com/Shopify/active_merchant/tree/master/lib/active_merchant/billing/integrations/robokassa

## Installation

Add to your `Gemfile`:

    gem "mandarin_pay"

## Usage

Run `rails g mandarin_pay:install`, get an initializer with the following code:

    MandarinPay.configure do |config|
      config.login = ENV["MANDARINPAY_LOGIN"]
      config.first_password = ENV["MANDARINPAY_FIRST_PASSWORD"]
      config.second_password = ENV["MANDARINPAY_SECOND_PASSWORD"]
      config.mode = :test # or :production
      config.http_method = :get # or :post
      config.xml_http_method = :get # or :post
    end

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

NOTE: `result_callback` should always return `"OK#{ invoice_id }"` string. So, implement your custom logic above `render text: notification.success` line.

Mode is `:test` by default. For production you have to use `:production`.
`http_method` and `xml_http_method` are `:get` by default but can be configured as `:post`

Once you are done, simply use `pay_url` helper in your view:

    <%= pay_url "Pay with Mandarin Pay", ivoice_id, total_sum %>

Additionally you may want to pass extra options. There is no problem:

    <%= pay_url "Pay with Mandarin Pay", ivoice_id, total_sum, { description: "Invoice description", email: "foo@bar.com", currency: "WMZM", culture: :ru } %>

Or if you would like to pass some custom params use `custom` key in options hash:

    <%= pay_url "Pay with Mandarin Pay", ivoice_id, total_sum, { description: "Invoice description", email: "foo@bar.com", currency: "WMZM", culture: :ru, custom: { param1: "value1", param2: "value2" }} %>      

You can also pass some HTML options with `html` key in options hash (Bootstrap 3 example):

    <%= pay_url "Pay with Mandarin Pay", ivoice_id, total_sum, { html: { class: 'btn btn-primary btn-bg' }}

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
