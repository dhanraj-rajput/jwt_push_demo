require 'rails_helper'
include JwtToken

RSpec.describe "Users", type: :request do
  let(:token) { jwd_encode({user_id: user.id}) }
  let(:user) { FactoryBot.create(:user) }


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
      get '/users', headers: { Authorization: token }
       expect(response).to have_http_status(201)
      users = JSON.parse(response.body)
      expect(users)
      expect(users.all?)
    end
  end

  describe "GET #show" do
    subject do
      get "/users/#{id}", headers: { Authorization: token }
      response
    end

    let(:id) { user.id }

    context "With valid params" do
      it "should returns record" do
        expect(subject).to have_http_status(200)
      end
    end


    context "With invalid params" do
      let(:id) { 'xxx' }
      it "should return not" do
        expect(subject).to have_http_status(404)
      end
    end
  end  

  describe "PUT #update" do
    subject do
      put "/users/#{id}", headers: { Authorization: token }
      response
    end

    context "With valid params" do
      let(:id) { user.id }
      it "should update record" do
        expect(subject).to have_http_status(200)
      end
    end


    context "With invalid params" do
      let(:id) { 'aaa' }
      it "should return not update" do
        expect(subject).to have_http_status(404)
      end
    end
  end

 
  describe "DELETE #destroy" do
    subject do
      delete "/users/#{id}", headers: { Authorization: token }
      response
    end

    context "With valid params" do
      let(:id) { user.id }
      it "should delete record" do
        expect(subject).to have_http_status(200)
      end
    end


    context "With invalid params" do
      let(:id) { 'aaa' }
      it "should record not delete" do
        expect(subject).to have_http_status(404)
      end
    end
  end
end












