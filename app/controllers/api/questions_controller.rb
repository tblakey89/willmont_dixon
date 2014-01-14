class Api::QuestionsController < ApplicationController
  before_filter :load_test
  before_filter :authenticate

  def index
    @questions = @pre_enrolment_test.questions
  end

  def show
    @question = @pre_enrolment_test.questions.find(params[:id])
  end

  def create
    @question = @pre_enrolment_test.questions.new(params[:question])
    if @question.save
      render :show, pre_enrolment_test: @pre_enrolment_test.id, id: @question.id, status: 201
    else
      render nothing: true, status: 400
    end
  end

  def update
    @question = @pre_enrolment_test.questions.find(params[:id])
    if @question.update_attributes(params[:question])
      render :show, pre_enrolment_test_id: @pre_enrolment_test.id, id: @question.id, status: 200
    else
      render nothing: true, status: 400
    end
  rescue
    render nothing: true, status: 400
  end

  def destroy
    @pre_enrolment_test.questions.find(params[:id]).destroy
    render nothing: true, status: 204
  rescue
    render nothing: true, status: 400
  end

private
  def load_test
    @pre_enrolment_test = PreEnrolmentTest.find(params[:pre_enrolment_test_id])
  end
end
