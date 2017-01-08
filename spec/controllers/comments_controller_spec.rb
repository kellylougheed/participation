require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:teacher) { FactoryGirl.create(:user) }
  let(:other_teacher) { FactoryGirl.create(:user, email: "teacher2@teachers.com") }
  let(:course) { FactoryGirl.create(:course, user_id: teacher.id) }
  let(:student) { FactoryGirl.create(:student, course_id: course.id) }
  let(:comment) { FactoryGirl.create(:comment, student_id: student.id)}

  describe "comments#create action" do
    it "should allow a teacher to create a comment for their own student" do
      sign_in teacher
      post :create, student_id: student.id, comment: {
        message: 'Great student'
      }
      expect(response).to redirect_to student_path(student)

      c = Comment.last
      expect(c.message).to eq('Great student')
    end

    it "should not allow a teacher to comment on another teacher's student" do
      sign_in other_teacher
      post :create, student_id: student.id, comment: {
        message: 'Great student'
      }
      expect(response).to have_http_status(:unauthorized)
      expect(Comment.count).to eq(0)
    end

    it "should not accept a comment without content" do
      sign_in teacher
      post :create, student_id: student.id, comment: {
        message: ''
      }
      expect(response).to redirect_to student_path(student)
      expect(Comment.count).to eq(0)
    end
  end

  describe "comments#destroy action" do
    it "should allow a teacher to delete one of their comments" do
      sign_in teacher
      delete :destroy, student_id: student.id, id: comment.id
      expect(response).to redirect_to student_path(student)
      expect(Comment.count).to eq(0)
    end

    it "should not allow a teacher to delete another teacher's comments" do
      sign_in other_teacher
      delete :destroy, student_id: student.id, id: comment.id
      expect(response).to have_http_status(:unauthorized)
      expect(Student.count).not_to eq(0)
    end
  end

  describe "comments#edit action" do
    it "should let the teacher edit the comment" do
      sign_in teacher
      get :edit, student_id: student.id, comment_id: comment.id
      expect(response).to have_http_status(:success)
    end

    it "shouldn't let another teacher edit the class" do
      sign_in other_teacher
      get :edit, student_id: student.id, comment_id: comment.id
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "comments#update action" do
    it "should let the teacher update the comment" do
      sign_in teacher
      patch :update, student_id: student.id, comment_id: comment.id, comment: { 
        text: 'LOLCAT'
      }
      expect(response).to redirect_to student_path(student)
      comment.reload
      expect(comment.text).to eq('LOLCAT')
    end

    it "should not let another teacher update the class" do
      sign_in other_teacher
      patch :update, student_id: student.id, comment_id: comment.id, comment: { 
        text: 'LOLCAT'
      }
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not update a comment with invalid input" do
      sign_in teacher
      patch :update, student_id: student.id, comment_id: comment.id, comment: { 
        text: ''
      }
      expect(response).to redirect_to student_path(student)
      comment.reload
      expect(comment.text).to eq("Good contribution")
    end
  end

end
