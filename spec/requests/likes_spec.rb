require 'rails_helper'
include JwtToken

RSpec.describe "Comments", type: :request do
  let(:token) { jwd_encode({user_id: user.id}) }
  let(:user) { FactoryBot.create(:user) }

  describe "LIKE #create" do
      subject do
      post '/likes', params: params, headers: {Authorization: token }
      response
    end

    let(:params) { {
      text: "hello",
      post_id: '2',
      comment_id: '4'    
    } }

    context "With valid params" do
      it "should returns created" do
      expect(subject).to have_http_status(201)
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
  #    let(:comment) { FactoryBot.create(:comment, user_id: user.id) }
  #    let(:post) { FactoryBot.create(:post, user_id: user.id, post_id: post.id) }
  #   subject do
  #     get "/likes/#{id}", headers: { Authorization: token }
  #     response
  #   end
  #   let(:id) { like.id }
  #   let(:like) { FactoryBot.create(:like, comment_id: comment.id, user_id: user.id, post_id: post.id)}


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
