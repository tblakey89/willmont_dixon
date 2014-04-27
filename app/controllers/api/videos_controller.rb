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
      directory = Rails.root.join("public", "videos")
      extension = params[:file].original_filename[-4..-1]
      if @video.extension_valid? extension
        path = File.join(directory, @video.id.to_s + extension)
        File.open(path, "wb") { |f| f.write(params[:file].read) }
        render :show, pre_enrolment_test: @pre_enrolment_test.id, id: @video.id, status: 201
      else
        @video.destroy
        render nothing: true, status: 400
      end
    else
      render :json => { errors: @video.errors }, status: 400
    end
  end

  def update
    @video = @pre_enrolment_test.videos.find(params[:id])
    if @video.update_attributes(edit_params)
      render :show, pre_enrolment_test_id: @pre_enrolment_test.id, id: @video.id, status: 200
    else
      render :json => { :errors => @video.errors }, status: 400
    end
  end

  def destroy
    @pre_enrolment_test.videos.find(params[:id]).destroy
    if File.exists?("public/videos/" + params[:id] + ".mp4")
      File.delete("public/videos/" + params[:id] + ".mp4")
    end
    render nothing: true, status: 204
  end

  def and_questions
    @video = @pre_enrolment_test.videos.find(params[:id])
  end

private
  def load_test
    @pre_enrolment_test = PreEnrolmentTest.find(params[:pre_enrolment_test_id])
  end

  def safe_params
    params.permit(:order, :name, :section_id, :show_questions) unless params.blank?
  end

  def edit_params
    params.require(:video).permit(:order, :name, :section_id, :show_questions) unless params.blank?
  end
end
