
module TransactionService 
    require_relative '../models/model.rb'
    require_relative "./converter.rb"
    Transaction.auto_upgrade!
    def createTransaction (sourceCurrence, sourceValue, destinationCurrence, destinationValue)
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
    
    def convert (sourceValue, sourceCurrence, destinationCurrence)
        source = Money.new(sourceValue * 100, sourceCurrence)
        destination = source.exchange_to(destinationCurrence)
        destinationValue = destination.to_f
        p ("#{source.format} = #{destination.format}")
        createTransaction(sourceCurrence, sourceValue, destinationCurrence, destinationValue)
        return destinationValue
    end

    def getAllTransactions 
        Transaction.all
    end
    def sabouna 
        p("sabouna")
    end

end