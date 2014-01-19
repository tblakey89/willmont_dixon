class Api::SectionsController < ApplicationController
  before_filter :load_test
  before_filter :authenticate

  def index
    @sections = @pre_enrolment_test.sections
  end

  def create
    @section = @pre_enrolment_test.sections.new(safe_params)
    if @section.save
      render :show, pre_enrolment_test_id: @pre_enrolment_test.id, id: @section.id, status: 201
    else
      render nothing: true, status: 400
    end
  end

  def update
    @section = @pre_enrolment_test.sections.find(params[:id])
    if @section.update_attributes(safe_params)
      render :show, pre_enrolment_test_id: @pre_enrolment_test.id, id: @section.id, status: 200
    else
      render nothing: true, status: 400
    end
  rescue
    render nothing: true, status: 400
  end

  def show
    @section = @pre_enrolment_test.sections.find(params[:id])
  end

  def destroy
    @pre_enrolment_test.sections.find(params[:id]).destroy
    render nothing: true, status: 204
  rescue
    render nothing: true, status: 400
  end

  def questions
    @section = @pre_enrolment_test.sections.find(params[:id])
    @questions = @section.questions
  end

private
  def load_test
    @pre_enrolment_test = PreEnrolmentTest.find(params[:pre_enrolment_test_id])
  end

  def safe_params
    params.require(:section).permit(:order, :name)
  end
end
