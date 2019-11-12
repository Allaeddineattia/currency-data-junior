require 'spec_helper'

describe 'Your application' do

  it "should render view when getting / " do
    get '/'
    expect(last_response.status).to eq 200
    expect(last_response.redirect?).to be_falsy
    expect(last_response.body).to include("<div class=\"result\">")
  end


  it "should redirect to / when getting /convert/ without params" do
    get '/convert/'
    expect(last_response.redirect?).to be_truthy
    follow_redirect!
    expect(last_request.path).to eq('/')
  end

  it "should redirect to / when getting /convert/ with invalide from currency " do
    get '/convert/?amount=12&From=TND&To=USD'
    expect(last_response.redirect?).to be_truthy
    follow_redirect!
    expect(last_request.path).to eq('/')
  end

  it "should redirect to / when getting /convert/ with invalide amount" do
    get '/convert/?amount=-12&From=EUR&To=USD'
    expect(last_response.redirect?).to be_truthy
    follow_redirect!
    expect(last_request.path).to eq('/')
  end

  it "should redirect to / when getting /convert/ with invalide to currency" do
    get '/convert/?amount=-12&From=EUR&To=TND'
    expect(last_response.redirect?).to be_truthy
    follow_redirect!
    expect(last_request.path).to eq('/')
  end

  it "should render view when geting /convert/ with valide params" do
    get '/convert/?amount=1&From=EUR&To=USD'
    expect(last_response.redirect?).to be_falsy
    expect(last_response.status).to eq 200
    expect(last_response.body).to include("<div class=\"result\">")
  end

  it "should redirect to /convert/ with valide params when posting /" do 
    @amount = '1'
    @form = 'USD'
    @to = 'EUR'
    params= { amount: @amount, inputcur:@form, outputcur:@to}
    post '/', params
    expect(last_response.redirect?).to be_truthy
    follow_redirect!
    expect(last_request.params["amount"]).to eq(@amount.to_f.to_s)
    expect(last_request.params["From"]).to eq(@form)
    expect(last_request.params["To"]).to eq(@to)
    expect(last_request.path).to eq("/convert/")
  end 

  it 'should redirect to page 1 when we try get page less then 0' do
    get '/result/?page=-4'
    expect(last_response.redirect?).to be_truthy
    follow_redirect!
    expect(last_request.path).to eq('/result/')
    expect(last_request.params["page"]).to eq('1')
  end

  it 'should redirect to page 1 when we try get result without page' do
    get '/result/'
    expect(last_response.redirect?).to be_truthy
    follow_redirect!
    expect(last_request.path).to eq('/result/')
    expect(last_request.params["page"]).to eq('1')
  end

  it 'should return to page 1 when we try to get the first page' do
    get '/result/?page=1'
    expect(last_response.redirect?).to be_falsy
    expect(last_response.status).to eq 200
  end

  it 'should redirect to page 1 when we try get page that will exceeded our avaible pages' do
    get '/result/?page=40000000'
    expect(last_response.redirect?).to be_truthy
    follow_redirect!
    expect(last_request.path).to eq('/result/')
    expect(last_request.params["page"]).to eq('1')
  end

end