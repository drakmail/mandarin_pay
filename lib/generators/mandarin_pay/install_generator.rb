require "rails/generators"

module MandarinPay
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    def create_initializer_file
      template "mandarin_pay.rb", File.join("config", "initializers", "mandarin_pay.rb")
    end
  end
end
