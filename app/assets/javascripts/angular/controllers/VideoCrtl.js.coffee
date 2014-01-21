@admin.controller 'VideoCrtl', ['$scope', 'Video', 'Section', 'Session', '$routeParams', '$location', ($scope, Video, Section, Session, $routeParams, $location) ->

	$scope.id = $routeParams.id

	$scope.getVideos = ->
		Video.getVideos().success((videos) ->
	    	$scope.videos = videos
	  	).error (error) ->
	    	$scope.status = "Unable to load video data: " + error.message

	$scope.getVideo = ->
		Video.getVideo($scope.id).success((video) ->
	    	$scope.video = video.video
	  	).error (error) ->
	    	$scope.status = "Unable to load video data: " + error.message

	$scope.addVideo = ->
		Video.addVideo($scope.video).success((data) ->
	    	$location.path('videos/' + data.video.id)
	  	).error (errors) ->
	    	$scope.error = errors.errors

	$scope.getSections = ->
		Section.getSections().success((sections) ->
	    	$scope.sections = sections
	  	).error (error) ->
	    	$scope.status = "Unable to load section data: " + error.message

	$scope.updateVideo = ->
		Video.updateVideo($scope.id, $scope.video).success((data) ->
	    	$location.path('videos/' + $scope.id)
	  	).error (errors) ->
	    	$scope.error = errors.errors

	$scope.deleteVideoFromTable = (id ,index) ->
		Video.deleteVideo(id).success((data) ->
	    	$scope.videos.splice(index, 1)
	  	).error (error) ->
	    	$scope.status = "There was an error deleting this section: " + error.message

	$scope.deleteVideo = ->
		Video.deleteVideo($scope.id).success((data) ->
	    	$location.path('videos/')
	  	).error (error) ->
	    	$scope.status = "Unable to load section data: " + error.message
]
