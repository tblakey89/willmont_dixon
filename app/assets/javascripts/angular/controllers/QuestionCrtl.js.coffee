@admin.controller 'QuestionCrtl', ['$scope', 'Question', 'Session', '$routeParams', ($scope, Question, Session, $routeParams) ->

	$scope.id = $routeParams.id

	$scope.getQuestions = ->
		Question.getQuestions().success((questions) ->
	    	$scope.questions = questions
	  	).error (error) ->
	    	$scope.status = "Unable to load question data: " + error.message

	$scope.getQuestion = ->
		Question.getQuestion($scope.id).success((question) ->
	    	$scope.question = question.question
	  	).error (error) ->
	    	$scope.status = "Unable to load question data: " + error.message

]
