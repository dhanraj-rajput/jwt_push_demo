require 'rails_helper'
include JwtToken

RSpec.describe "Posts", type: :request do
  let(:token) { jwd_encode({user_id: user.id}) }
  let(:user) { FactoryBot.create(:user) }
  
  
  describe "POST #create" do
    subject do
      post '/posts', params: params, headers: {Authorization: token }
      response
    end

    let(:params) { {
      description: "hello",
      total_likes: "5"
   
    } }

    context "With valid params" do
      it "should returns created" do
        expect(subject).to have_http_status(200)
      end
    end

    context "With invalid params" do
      let(:token) { "dfh" }  
      it "should return not" do
        expect(subject).to have_http_status(401)
      end
    end
  end 

  describe 'GET #index' do
    it 'shold returns a list of all posts' do
      get '/posts', headers: { Authorization: token }
       expect(response).to have_http_status(200)
        users= JSON.parse(response.body)
       expect(users)
       expect(users.all?)
    end
  end

  describe "GET #show" do
    subject do
      get "/posts/#{id}", headers: { Authorization: token }
      response
    end

    let(:id) { post.id }
    let(:post) { FactoryBot.create(:post, user_id: user.id) }

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
      put "/posts/#{id}", headers: { Authorization: token }
      response
    end

    context "With valid params" do
      let(:id) { post.id }
      let(:post) { FactoryBot.create(:post, user_id: user.id) }
      it "should update posts" do
        expect(subject).to have_http_status(200)
      end
    end


    context "With invalid params" do
      let(:id) {'aed' }
      it "should return not update" do
        expect(subject).to have_http_status(404)
      end
    end
  end

    describe "DELETE #destroy" do
    subject do
      delete "/posts/#{id}", headers: { Authorization: token }
      response
    end

    context "With valid params" do
      let(:id) { post.id }
      let(:post) { FactoryBot.create(:post, user_id: user.id) }
      it "should delete record" do
        expect(subject).to have_http_status(200)
      end
    end


    context "With invalid params" do
      let(:id) { 'frr' }
      it "should record not delete" do
        expect(subject).to have_http_status(404)
      end
    end
  end
end