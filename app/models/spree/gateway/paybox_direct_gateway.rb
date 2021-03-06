module Spree
  class Gateway::PayboxDirectGateway < Gateway
    preference :login, :string
    preference :password, :string
    preference :currency_code, :string

    def provider_class
      ActiveMerchant::Billing::PayboxDirectGateway
    end
  end
end
