class Api::VideosController < ApplicationController
  before_filter :load_test
  before_filter :authenticate

  def index
    @videos = @pre_enrolment_test.videos
  end

  def show
    @video = @pre_enrolment_test.videos.find(params[:id])
  end

  def create
    @video = @pre_enrolment_test.videos.new(safe_params)
    if @video.save
      render :show, pre_enrolment_test: @pre_enrolment_test.id, id: @video.id, status: 201
    else
      render :json => { :errors => @video.errors }, status: 400
    end
  end

  def update
    @video = @pre_enrolment_test.videos.find(params[:id])
    if @video.update_attributes(safe_params)
      render :show, pre_enrolment_test_id: @pre_enrolment_test.id, id: @video.id, status: 200
    else
      render :json => { :errors => @video.errors }, status: 400
    end
  rescue
    render nothing: true, status: 400
  end

  def destroy
    @pre_enrolment_test.videos.find(params[:id]).destroy
    render nothing: true, status: 204
  rescue
    render nothing: true, status: 400
  end

private
  def load_test
    @pre_enrolment_test = PreEnrolmentTest.find(params[:pre_enrolment_test_id])
  end

  def safe_params
    params.require(:video).permit(:order, :name, :section_id) unless params[:video].blank?
  end
end
