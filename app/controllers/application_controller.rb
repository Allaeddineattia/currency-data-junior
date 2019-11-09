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
		@source = params["source"]

   		erb :index
	end

	get 'convert' do 
	end

	post '/' do
		@amount = params['amount'].to_f
		if(@amount == 0)
			redirect "/?value=please give a valide float"
		end
		@inputCur = params['inputcur']
		@outputCur = params['outputcur'] 
		@output = convert(@amount, @inputCur, @outputCur)
		redirect "/?source=#{@amount}&sourcecur#{@inputCur}&destination=#{@output}&outputcur=#{@outputCur}"
	end
	get '/result' do 
		erb :result
	end

	get '/test' do
		@newTransaction = create("EUR",5 ,'USD', 4)
		p(@newTransaction.sourceValue.to_s)
	end

	

end
