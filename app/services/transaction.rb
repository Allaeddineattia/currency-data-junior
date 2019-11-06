
module TransactionService 
    require_relative '../models/model.rb'
    Transaction.auto_upgrade!
    def create (sourceCurrence, sourceValue, destinationCurrence, destinationValue)
        p ('dkhal') 
        p (sourceCurrence)
        p Transaction
        @newTransaction = Transaction.new()
        @newTransaction.date = Time.now
        @newTransaction.sourceCurrence = sourceCurrence
        @newTransaction.sourceValue = sourceValue
        @newTransaction.destinationCurrence = destinationCurrence
        @newTransaction.destinationValue = destinationValue
        @newTransaction.save 
        return @newTransaction
        
    end
    def sabouna 
        p("sabouna")
    end

end