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
   		erb :index
	end

	get '/heh/:name' do |n|
		p "hello #{n.upcase}"
	end
	
	get '/mar9a/' do 
		p "mar9a/"
	end

	get '/result' do 
		erb :result
	end

	get '/test' do
		@newTransaction = create("EUR",5 ,'USD', 4)
		p(@newTransaction.sourceValue.to_s)
	end

end
