
module Converter 
    require 'money/bank/currencylayer_bank'
    mclb = Money::Bank::CurrencylayerBank.new
    mclb.access_key = 'eccdd16ffb8d1ae6a9efa6a3fe8665d2'

    # Update rates (get new rates from remote if expired or access rates from cache)
    mclb.update_rates

    # Set money default bank to Currencylayer bank
    Money.default_bank = mclb
    Money.locale_backend = nil
    
end