@exam.controller 'ExamCrtl', ['$scope', 'Session', 'Video', 'Question', 'Section', '$routeParams', '$location', ($scope, Session, Video, Question, Section, $routeParams, $location) ->

	$scope.id = $routeParams.id

	$scope.getSection = ->
		Section.getSection($scope.id).success((section) ->
	    	$scope.section = section.section
	    	$scope.getVideo($scope.section.videos[0].video.id)
	  	).error (error) ->
	    	$scope.status = "Unable to load section data: " + error.message

	$scope.getVideo = (video_id) ->
		Video.getVideo(video_id).success((video) ->
	    	$scope.video = video.video
	    	$scope.setUpVideo()
	  	).error (error) ->
	    	$scope.status = "Unable to load video data: " + error.message

	$scope.getQuestion = ->
		Question.getQuestion($scope.id).success((question) ->
	    	$scope.question = question.question
	  	).error (error) ->
	    	$scope.status = "Unable to load question data: " + error.message

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
