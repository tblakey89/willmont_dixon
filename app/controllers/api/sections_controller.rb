class Api::SectionsController < ApplicationController
  before_filter :load_test
  before_filter :authenticate

  def index
    @sections = @pre_enrolment_test.sections
  end

  def all
    @sections = @pre_enrolment_test.sections.select { |section| !section.videos.blank? }
    render :index, pre_enrolment_test: @pre_enrolment_test.id, status: 200
  end

  def create
    @section = @pre_enrolment_test.sections.new(safe_params)
    if @section.save
      render :show, pre_enrolment_test_id: @pre_enrolment_test.id, id: @section.id, status: 201
    else
      render :json => { :errors => @section.errors }, status: 400
    end
  end

  def update
    @section = @pre_enrolment_test.sections.find(params[:id])
    if @section.update_attributes(safe_params)
      render :show, pre_enrolment_test_id: @pre_enrolment_test.id, id: @section.id, status: 200
    else
      render :json => { :errors => @section.errors }, status: 400
    end
  end

  def show
    @section = @pre_enrolment_test.sections.find(params[:id])
  end

  def destroy
    @pre_enrolment_test.sections.find(params[:id]).destroy
    render nothing: true, status: 204
  end

  def questions
    @section = @pre_enrolment_test.sections.find(params[:id])
    @questions = @section.questions
  end

  def videos
    @section = @pre_enrolment_test.sections.find(params[:id])
    @videos = @section.videos
  end

  def check_answers
    section = Section.find(params[:id])
    answers = params[:answers]
    if section.correct? answers
      render status: 200, json: { data: params[:answers] }
    else
      render status: 422, json: { data: section.correct_answers(answers) }
    end
  end

private
  def load_test
    @pre_enrolment_test = PreEnrolmentTest.find(params[:pre_enrolment_test_id])
  end

  def safe_params
    params.require(:section).permit(:order, :name, :work_at_height, :scaffolder, :ground_worker, :operate_machinery, :lift_loads, :young, :supervisor) unless params[:section].blank?
  end
end
