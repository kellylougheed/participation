require 'rails_helper'

RSpec.describe ClassesController, type: :controller do

  let(:teacher) { FactoryGirl.create(:user) }
  let(:other_teacher) { FactoryGirl.create(:user, email: "teacher2@teachers.com") }
  let(:course) { FactoryGirl.create(:course, user_id: teacher.id) }

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
      get :show, id: course.id
      expect(response).to have_http_status(:success)
    end

    it "should not show the class if the teacher is not the current user" do
      sign_in other_teacher
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

      c = Course.last
      expect(c.name).to eq('Latin III')
      expect(c.user).to eq(teacher)
    end

    it "should not create a class without a name" do
      sign_in teacher
      post :create, course: {
        name: ''
      }
      expect(Course.count).to eq(0)
    end

    it "should not accept point values that are not numbers" do
      sign_in teacher
      post :create, course: {
        starting_points: 'Greek',
        total_points: 'Greek'
      }
      expect(Course.count).to eq(0)
    end
  end

  describe "classes#edit action" do
    it "should let the teacher edit the class" do
      sign_in teacher
      get :edit, id: course.id
      expect(response).to have_http_status(:success)
    end

    it "shouldn't let another teacher edit the class" do
      sign_in other_teacher
      get :edit, id: course.id
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "classes#update action" do
    it "should let the teacher update the class" do
      sign_in teacher
      patch :update, id: course.id, course: { name: 'Sanskrit' }
      expect(response).to redirect_to class_path(course)
      course.reload
      expect(course.name).to eq('Sanskrit')
    end

    it "should not let another teacher update the class" do
      sign_in other_teacher
      patch :update, id: course.id, course: { name: 'Sanskrit' }
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not update a class with invalid input" do
      sign_in teacher
      patch :update, id: course.id, course: { name: '' }
      expect(response).to redirect_to class_path(course)
      course.reload
      expect(course.name).to eq('Latin')
    end
  end

  describe "classes#destroy action" do
    it "should let the teacher delete the class" do
      sign_in teacher
      delete :destroy, id: course.id
      expect(response).to redirect_to classes_path
    end

    it "should not let another teacher delete the class" do
      sign_in other_teacher
      delete :destroy, id: course.id
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "classes#reset_all action" do
    it "should reset everyone's starting points to the default" do
      sign_in teacher
      student = FactoryGirl.create(:student, course: course, points: 70)
      put :reset_all, class_id: course.id
      student.reload
      expect(student.points).to eq(50)
    end

    it "should not let another teacher reset the points" do
      sign_in other_teacher
      put :reset_all, class_id: course.id
      expect(response).to have_http_status(:unauthorized)
    end
  end

end
