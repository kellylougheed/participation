require 'rails_helper'

RSpec.describe ClassesController, type: :controller do

  let(:teacher) { FactoryGirl.create(:user) }

  describe "classes#index action" do
    it "should successfully show classes to a logged-in teacher" do
      sign_in teacher
      get :index
      expect(response).to have_http_status(:success)
    end

    it "should require the teacher to be logged in" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "classes#show action" do
    it "should successfully show the class if the teacher is the current user" do
      sign_in teacher
      course = FactoryGirl.create(:course, user_id: teacher.id)
      get :show, id: course.id
      expect(response).to have_http_status(:success)
    end

    it "should not show the class if the teacher is not the current user" do
      other_teacher = FactoryGirl.create(:user, email: "teacher2@teachers.com")
      sign_in other_teacher
      course = FactoryGirl.create(:course, user_id: teacher.id)
      get :show, id: course.id
      expect(response).to have_http_status(:unauthorized)
    end

  end

  describe "classes#create action" do
    it "should successfully create a class" do
      sign_in teacher
      post :create, course: {
        name: 'Latin III',
        starting_points: 0,
        total_points: 10
      }
      expect(response).to redirect_to classes_path

      course = Course.last
      expect(course.name).to eq('Latin III')
      expect(course.user).to eq(teacher)
    end

    it "should not create an invalid class" do
      sign_in teacher
      post :create, course: {
        name: ''
      }
      expect(Course.count).to eq(0)
    end
  end

end
