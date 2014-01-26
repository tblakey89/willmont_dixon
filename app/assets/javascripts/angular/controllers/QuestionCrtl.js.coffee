@admin.controller 'QuestionCrtl', ['$scope', 'Question', 'Section', 'Session', '$routeParams', '$location', ($scope, Question, Section, Session, $routeParams, $location) ->

	$scope.id = $routeParams.id
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
	    	$location.path('questions/' + data.question.id)
	  	).error (errors) ->
	    	$scope.error = errors.errors

	$scope.getSections = ->
		Section.getSections().success((sections) ->
	    	$scope.sections = sections
	  	).error (error) ->
	    	$scope.status = "Unable to load section data: " + error.message

	$scope.updateQuestion = ->
		Question.updateQuestion($scope.id, $scope.question).success((data) ->
	    	$location.path('questions/' + $scope.id)
	  	).error (errors) ->
	    	$scope.error = errors.errors

	$scope.deleteQuestionFromTable = (id ,index) ->
		Question.deleteQuestion(id).success((data) ->
	    	$scope.questions.splice(index, 1)
	  	).error (error) ->
	    	$scope.status = "There was an error deleting this section: " + error.message

	$scope.deleteQuestion = ->
		Question.deleteQuestion($scope.id).success((data) ->
	    	$location.path('questions/')
	  	).error (error) ->
	    	$scope.status = "Unable to load section data: " + error.message
]
