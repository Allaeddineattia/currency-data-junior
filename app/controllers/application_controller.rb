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
		@source = 1
   		erb :index
	end

	get '/convert/' do 
		@amount = params["amount"]
		@from = params["From"]
		@to = params["To"]
		begin
			@result = convert(@amount.to_f, @from, @to)
			@output = @amount and @from and @result and @to
			erb :index
		rescue
			@source = 1
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
		@output = convert(@amount, @inputCur, @outputCur)
		redirect "/convert/?amount=#{@amount}&From=#{@inputCur}&To=#{@outputCur}"
	end
	get '/result' do 
		@transactions = getAllTransactions
		p @transactions
		erb :result
	end

	

end
