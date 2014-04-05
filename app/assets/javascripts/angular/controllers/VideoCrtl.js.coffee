@admin.controller 'VideoCrtl', ['$scope', 'Video', 'Section', 'Session', '$routeParams', '$location', "$upload", ($scope, Video, Section, Session, $routeParams, $location, $upload) ->

	$scope.id = $routeParams.id
	$scope.videos = []
	$scope.currentPage = 1
	$scope.lastPage = 1

	$scope.getVideos = ->
		Video.getVideos().success((videos) ->
	    	$scope.videos = videos
	    	$scope.lastPage = Math.ceil($scope.videos.length/10)
	  	).error (error) ->
	    	$scope.status = "Unable to load video data: " + error.message

	$scope.getVideo = ->
		Video.getVideo($scope.id).success((video) ->
	    	$scope.video = video.video
	    	$scope.setUpVideo()
	  	).error (error) ->
	    	$scope.status = "Unable to load video data: " + error.message

	$scope.addVideo = ->
      $scope.progress = 0
      file = $scope.selectedFiles[0]
      $scope.upload = $upload.upload(
        url: "/api/pre_enrolment_tests/1/videos/"
        method: "POST"
        data: { section_id: $scope.video.section_id, order: $scope.video.order, name: $scope.video.name, show_questions: $scope.video.show_questions }
        file: file
        headers: { 'auth-token': sessionStorage.authToken }
      ).progress((evt) ->
         $scope.progress = parseInt(100.0 * evt.loaded / evt.total)
      ).success((data, status, headers, config) ->
        $location.path('videos/' + data.video.id)
      )

	$scope.getSections = ->
		Section.getSections().success((sections) ->
	    	$scope.sections = sections
	  	).error (error) ->
	    	$scope.status = "Unable to load section data: " + error.message

	$scope.updateVideo = ->
		Video.updateVideo($scope.id, $scope.video).success((data) ->
	    	$location.path('/admin/videos/' + $scope.id)
	  	).error (errors) ->
	    	$scope.error = errors.errors

	$scope.deleteVideoFromTable = (id ,index) ->
		Video.deleteVideo(id).success((data) ->
	    	$scope.videos.splice(index, 1)
	  	).error (error) ->
	    	$scope.status = "There was an error deleting this section: " + error.message

	$scope.deleteVideo = ->
		Video.deleteVideo($scope.id).success((data) ->
	    	$location.path('/admin/videos/')
	  	).error (error) ->
	    	$scope.status = "Unable to load section data: " + error.message

	$scope.onFileSelect = ($files) ->
	    $scope.selectedFiles = $files

	$scope.setUpVideo = ->
	    jwplayer("video").setup
	    	width: "100%"
	    	aspectratio: "12:5"
	    	icons: false
	    	file: "/videos/" + $scope.video.id + ".mp4"
	    	events:
	    		onComplete: ->
	    			$scope.$apply ->
	    				$scope.video = true
	    				$scope.begin = $scope.begin + 1

]
