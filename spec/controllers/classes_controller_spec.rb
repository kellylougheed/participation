require 'rails_helper'

RSpec.describe ClassesController, type: :controller do

  describe "classes#index action" do
    it "should successfully show classes to a logged-in teacher" do
      u = FactoryGirl.create(:user)
      sign_in u
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "classes#show action" do
    it "should successfully show the class if the teacher is the current user" do
      u = FactoryGirl.create(:user)
      sign_in u
      course = FactoryGirl.create(:course, user_id: u.id)
      get :show, id: course.id
      expect(response).to have_http_status(:success)
    end

    it "should not show the class if the teacher is not the current user" do
    end

  end

end
