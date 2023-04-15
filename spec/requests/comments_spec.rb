require 'rails_helper'
include JwtToken

RSpec.describe "Comments", type: :request do
  let(:token) { jwd_encode({user_id: user.id}) }
  let(:user) { FactoryBot.create(:user) }

  
  describe "COMMENT #create" do
      subject do
      post '/comments', params: params, headers: {Authorization: token }
      response
    end

    let(:params) { {
      text: "hello"   
      
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

  describe "GET #index" do
        let(:post) { FactoryBot.create(:post, user_id: user.id) }
    subject do
      get "/comments/#{id}", headers: { Authorization: token }
      response
    end
    let(:id) { comment.id }
    let(:comment) { FactoryBot.create(:comment, post_id: post.id, user_id: user.id) }


    context "With valid params" do
      it "should returns  all record" do
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

  describe "GET #show" do
        let(:post) { FactoryBot.create(:post, user_id: user.id) }
    subject do
      get "/comments/#{id}", headers: { Authorization: token }
      response
    end
    let(:id) { comment.id }
    let(:comment) { FactoryBot.create(:comment, post_id: post.id, user_id: user.id) }


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
        let(:post) { FactoryBot.create(:post, user_id: user.id) }
    subject do
      put "/comments/#{id}", headers: { Authorization: token }
      response
    end
    let(:id) { comment.id }
    let(:comment) { FactoryBot.create(:comment, post_id: post.id, user_id: user.id) }


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

   describe "DELETE #destroy" do
        let(:post) { FactoryBot.create(:post, user_id: user.id) }
    subject do
      delete "/comments/#{id}", headers: { Authorization: token }
      response
    end
    let(:id) { comment.id }
    let(:comment) { FactoryBot.create(:comment, post_id: post.id, user_id: user.id) }


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
  
  
  describe "POST #create_reply" do 
    subject do
      post '/comments', params: params, headers: {Authorization: token }
      response
    end
    let(:id) { comment.id }
    let(:comment) { FactoryBot.create(:comment, post_id: post.id, user_id: user.id) }
     #let(:post) { FactoryBot.create(:post, comment_id: comment.id, user_id: user.id) }
     
    let(:params) { {
      text: "hello",
      comment_id: 4
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

  # describe "GET #show" do
  #       let(:post) { FactoryBot.create(:post, user_id: user.id) }
  #       let(:replies) { FactoryBot.create(:replies, comment_id: comment.id) }
  #   subject do
  #     get "/comments/#{id}", headers: { Authorization: token }
  #     response
  #   end
  #   let(:id) { comment.id }
  #   let(:comment) { FactoryBot.create(:comment, post_id: post.id, user_id: user.id) }


  #   context "With valid params" do
  #     it "should returns record" do
  #       expect(subject).to have_http_status(200)
  #     end
  #   end

  #   context "With invalid params" do
  #     let(:id) { 'xxx' }
  #     it "should return not" do
  #       expect(subject).to have_http_status(404)
  #     end
  #   end
  # end
end