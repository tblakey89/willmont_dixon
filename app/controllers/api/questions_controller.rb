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
    @question = @pre_enrolment_test.questions.new(safe_params)
    if @question.save
      render :show, pre_enrolment_test: @pre_enrolment_test.id, id: @question.id, status: 201
    else
      render :json => { :errors => @question.errors }, status: 400
    end
  end

  def update
    @question = @pre_enrolment_test.questions.find(params[:id])
    if @question.update_attributes(safe_params)
      render :show, pre_enrolment_test_id: @pre_enrolment_test.id, id: @question.id, status: 200
    else
      render :json => { :errors => @question.errors }, status: 400
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

  def safe_params
    params.require(:question).permit(:order, :name, :answer1, :answer2, :answer3, :answer4, :answer, :section_id, :video_id) unless params[:question].blank?
  end
end
