
module TransactionService 
    require_relative '../models/model.rb'
    require_relative "./converter.rb"
    Transaction.auto_upgrade!
    def createTransaction (sourceCurrence, sourceValue, destinationCurrence, destinationValue)
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
        createTransaction(sourceCurrence, sourceValue, destinationCurrence, destinationValue)
        return destinationValue
    end

    def getAllTransactions 
        @transactions =  Transaction.all
        return @transactions
    end

    def getTransactionsByPage page
        @limit = 12
        @offset = (page.to_i - 1) * @limit
        @transactions = Transaction.all(:offset => @offset, :limit => @limit, :order => [ :date.desc ])
        return @transactions
    end    
    
    def getAvaibleCurrencies 
        return ["EUR","USD","CHF"]
    end


end