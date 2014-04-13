require 'spec_helper'
include Devise::TestHelpers 

describe ReviewsController do
  describe "POST vote_up" do
    before(:each) do
      @user = User.create(:email => "example@email.com", :password => "password", :password_confirmation => "password")
      @student = Student.create(grad_year: 2014, user_id: @user.id)
      @user.student = @student
      @review = Review.create(student_id: 1, professor_rating: 1.0, enjoyability: 1, 
                              difficulty: 1, recommend: 1, course_id: 1, professor_id: 1)
      @user.confirm!
      sign_in @user
    end

    it "should add a vote" do
      post :vote_up, review_id: @review.id
      response.should be_success

      @user.reload
      @review.reload
      @user.votes.count.should be_equal(1)
      @review.votes_for.should be_equal(1)
    end
  end
end
