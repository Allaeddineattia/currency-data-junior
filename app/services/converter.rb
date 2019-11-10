
module Converter 
    require 'money/bank/currencylayer_bank'
    mclb = Money::Bank::CurrencylayerBank.new
    mclb.access_key = '90a4a503d334f109956b8e22f14adbd5'

    # Update rates (get new rates from remote if expired or access rates from cache)
    #mclb.update_rates

    # Set money default bank to Currencylayer bank
    Money.default_bank = mclb
    Money.locale_backend = nil
    
end