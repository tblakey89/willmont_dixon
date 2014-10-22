class Api::PreEnrolmentTestsController < ApplicationController
  before_filter :authenticate
  def index
    @users = User.where("pre_enrolment_due < now() and pre_enrolment_due is not null")
    @expired = User.where("cscs_expiry_date < now() and pre_enrolment_due is not null")
  end

  def create
    @pre_enrolment_test = PreEnrolmentTest.new(params[:pre_enrolment_test])
    if @pre_enrolment_test.save
      render :show, id: @pre_enrolment_test.id, status: 201
    else
      render nothing: true, status: 400
    end
  end

  def show
    @pre_enrolment_test = PreEnrolmentTest.find(params[:id])
  end

  def update
    @pre_enrolment_test = PreEnrolmentTest.find(params[:id])
    if @pre_enrolment_test.update_attributes(params[:pre_enrolment_test])
      render :show, id: @pre_enrolment_test.id, status: 200
    else
      render nothing: true, status: 400
    end
  end

  def begin_test
    @pre_enrolment_test = PreEnrolmentTest.find(params[:id])
    @section = @pre_enrolment_test.sections.first(order: "sections.order asc")
    render "api/sections/show", id: @section.id
  end

  def destroy
    PreEnrolmentTest.find(params[:id]).destroy
    render nothing: true, status: 204
  end
end
