# For the documentation check http://sinatrarb.com/intro.html
class ApplicationController < Sinatra::Base
	# This configuration part will inform the app where to search for the views and from where it will serve the static files
	require_relative '../services/transaction.rb'
	include TransactionService
	configure do
    	set :views, "app/views"
    	set :public_dir, "public"
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

	get '/test' do
		@currencies = getAvaibleCurrencies
		@amount = "1"
		@from = "EUR"
		@to = "USD"
		@result = 0.9
		@output = @amount and @from and @result and @to
		erb :index
	end

	get '/convert/' do 
		@currencies = getAvaibleCurrencies
		@amount = params["amount"]
		@from = params["From"]
		@to = params["To"]
		begin
			@result = convert(@amount.to_f, @from, @to)
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
		if(@page == 0)
			@page = 1
		end
		@transactions = getTransactionsByPage(@page)
		if (@transactions.empty?)
			p 'dkhal'
			if (@page==1)
				return erb :result
			end
			redirect 'result/?page=1'
		end
		erb :result
	end

	

end
