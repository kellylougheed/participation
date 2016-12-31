require 'rails_helper'

RSpec.describe StudentsController, type: :controller do

  let(:teacher) { FactoryGirl.create(:user) }
  let(:other_teacher) { FactoryGirl.create(:user, email: "teacher2@teachers.com") }
  let(:course) { FactoryGirl.create(:course, user_id: teacher.id) }
  let(:student) { FactoryGirl.create(:student, course_id: course.id) }

  describe "students#create action" do
  end

  describe "students#show action" do
    it "should successfully show a student to their teacher" do
      sign_in teacher
      get :show, id: student.id
      expect(response).to have_http_status(:success)
    end

    it "should not show a student to another teacher" do
      sign_in other_teacher
      get :show, id: student.id
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "students#update action" do
  end

  describe "students#destroy action" do
  end

end
