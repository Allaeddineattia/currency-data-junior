class ApplicationController < Sinatra::Base
	# This configuration part will inform the app where to search for the views and from where it will serve the static files
	require_relative '../services/transaction.rb'
	include TransactionService
	configure do
    	set :views, "app/views"
    	set :public_dir, "public"
	end

	def checkConversionParams (amount, form, to) 
		if(amount <= 0)
			return false 
		end
		@currencies = getAvaibleCurrencies
		if (! @currencies.include?(form)) then return false end
		if (! @currencies.include?(to)) then return false end
		return true
	end

	get '/' do
		@currencies = getAvaibleCurrencies
		@amount = 1
		@from = "EUR"
		@to = "EUR"
		@result = 1
		@output = @amount and @from and @result and @to
   		erb :index
	end

	get '/convert/' do 
		@currencies = getAvaibleCurrencies
		@amount = params["amount"].to_f
		@from = params["From"]
		@to = params["To"]
		if (! checkConversionParams(@amount, @from, @to)) 
			then redirect '/' end
		begin
			@result = convert(@amount, @from, @to)
			@output = @amount and @from and @result and @to
			erb :index
		rescue
			@amount = 1
			@from = "EUR"
			@to = "EUR"
			@result = 1
			@output = false
			erb :index
		end 

		
	end

	post '/' do
		@amount = params['amount'].to_f
		if(@amount == 0)
			@amount = 1
		end
		@inputCur = params['inputcur']
		@outputCur = params['outputcur'] 
		redirect "/convert/?amount=#{@amount}&From=#{@inputCur}&To=#{@outputCur}"
	end

	get '/result/' do
		@page = params['page'].to_i
		if(@page <= 0)
			redirect 'result/?page=1'
		end
		@transactions = getTransactionsByPage(@page)
		if (@transactions.empty?)
			if (@page==1)
				return erb :result
			end
			redirect 'result/?page=1'
		end
		erb :result
	end

	

end
