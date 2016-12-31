require 'rails_helper'

RSpec.describe StudentsController, type: :controller do

  let(:teacher) { FactoryGirl.create(:user) }
  let(:other_teacher) { FactoryGirl.create(:user, email: "teacher2@teachers.com") }
  let(:course) { FactoryGirl.create(:course, user_id: teacher.id) }
  let(:student) { FactoryGirl.create(:student, course_id: course.id) }

  describe "students#create action" do
    it "should allow a teacher to create a new student" do
      sign_in teacher
      post :create, class_id: course.id, student: {
        first_name: 'Susie',
        last_name: 'Castilleja',
      }
      expect(response).to redirect_to class_path(course)

      s = Student.last
      expect(s.first_name).to eq('Susie')
      expect(s.course).to eq(course)
    end

    it "should not allow a teacher to create a student in another teacher's class" do
      sign_in other_teacher
      post :create, class_id: course.id, student: {
        first_name: 'Susie',
        last_name: 'Castilleja',
      }
      expect(response).to have_http_status(:unauthorized)
      expect(Student.count).to eq(0)
    end
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
    it "should allow a teacher to update a student" do
      sign_in teacher
      patch :update, id: student.id, student: { points: 100 }
      expect(response).to redirect_to class_path(course)

      student.reload
      expect(student.points).to eq(100)
    end

    it "should not allow a teacher to update another teacher's student" do
      sign_in other_teacher
      patch :update, id: student.id, student: { points: 100 }
      expect(response).to have_http_status(:unauthorized)
      student.reload
      expect(student.points).not_to eq(100)
    end
  end

  describe "students#destroy action" do
    it "should allow a teacher to delete a student" do
      sign_in teacher
      delete :destroy, id: student.id
      expect(response).to redirect_to class_path(course)
      expect(Student.count).to eq(0)
    end

    it "should not allow a teacher to delete another teacher's student" do
      sign_in other_teacher
      delete :destroy, id: student.id
      expect(response).to have_http_status(:unauthorized)
      expect(Student.count).not_to eq(0)
    end
  end

end
