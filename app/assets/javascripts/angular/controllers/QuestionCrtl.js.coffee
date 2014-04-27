@admin.controller 'QuestionCrtl', ['$scope', 'Question', 'Section', 'Video', 'Session', '$routeParams', '$location', ($scope, Question, Section, Video, Session, $routeParams, $location) ->

	$scope.id = $routeParams.id
	$scope.questions = []
	$scope.currentPage = 1
	$scope.lastPage = 1

	$scope.getQuestions = ->
		Question.getQuestions().success((questions) ->
	    	$scope.questions = questions
	    	$scope.lastPage = Math.ceil($scope.questions.length/10)
	  	).error (error) ->
	    	$scope.status = "Unable to load question data: " + error.message

	$scope.getQuestion = ->
		Question.getQuestion($scope.id).success((question) ->
	    	$scope.question = question.question
	  	).error (error) ->
	    	$scope.status = "Unable to load question data: " + error.message

	$scope.addQuestion = ->
		Question.addQuestion($scope.question).success((data) ->
	    	$location.path('/admin/questions/' + data.question.id)
	  	).error (errors) ->
	    	$scope.error = errors.errors

	$scope.getSections = ->
		Section.getSections().success((sections) ->
	    	$scope.sections = sections
	  	).error (error) ->
	    	$scope.status = "Unable to load section data: " + error.message

	$scope.getVideos = ->
		Video.getVideos().success((videos) ->
	    	$scope.videos = videos
	  	).error (error) ->
	    	$scope.status = "Unable to load video data: " + error.message

	$scope.updateQuestion = ->
		Question.updateQuestion($scope.id, $scope.question).success((data) ->
	    	$location.path('/admin/questions/' + $scope.id)
	  	).error (errors) ->
	    	$scope.error = errors.errors

	$scope.deleteQuestionFromTable = (id ,index) ->
		if (confirm("Are you sure you want to delete this question?") is true)
			Question.deleteQuestion(id).success((data) ->
		    	$scope.questions.splice(index, 1)
		  	).error (error) ->
		    	$scope.status = "There was an error deleting this section: " + error.message

	$scope.deleteQuestion = ->
		if (confirm("Are you sure you want to delete this question?") is true)
			Question.deleteQuestion($scope.id).success((data) ->
		    	$location.path('/admin/questions/')
		  	).error (error) ->
		    	$scope.status = "Unable to load section data: " + error.message
]
