require 'rails_helper'
# before(:each) do
#   # @token = BuilderJsonWebToken::JasonWebToken.encode(@user.id)
# end

RSpec.describe "Users", type: :request do
  describe "POST #create" do

    subject do
      post '/users', params: params
      response
    end

    let(:params) { {
      user_name: "sldkfj",
      email: "slksj@gmail.com",
      password: "pasdfsjfksf"
    } }

    context "With valid params" do
      it "should returns created" do
        expect(subject).to have_http_status(201)
      end
    end


    context "With invalid params" do
      let(:params) { {} }
      it "should return 503" do
        expect(subject).to have_http_status(503)
      end
    end
  end


  describe 'GET #index' do
    it 'shold returns a list of all users' do
      get '/users'
       expect(response).to have_http_status(201)
      users = JSON.parse(response.body)
      expect(users)
      expect(users.all?)
    end
  end

  describe 'GET#show'  do
    byebug
    it 'should returns a user' do 
      get '/users' 
       expect(response).to have_http_status(201)
       users=JSON.parse(response.body)
       expect(users)
       expect(user.find_by?)
     end
   end
end







