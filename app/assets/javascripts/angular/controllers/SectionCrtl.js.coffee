@admin.controller 'SectionCrtl', ['$scope', 'Section', 'Session', '$routeParams', ($scope, Section, Session, $routeParams) ->

	$scope.id = $routeParams.id

	$scope.getSections = ->
		Section.getSections().success((sections) ->
	    	$scope.sections = sections
	  	).error (error) ->
	    	$scope.status = "Unable to load section data: " + error.message

	$scope.getSection = ->
		Section.getSection($scope.id).success((section) ->
	    	$scope.section = section.section
	  	).error (error) ->
	    	$scope.status = "Unable to load section data: " + error.message

	$scope.getQuestions = ->
		Section.getQuestions($scope.id).success((questions) ->
	    	$scope.questions = questions
	  	).error (error) ->
	    	$scope.status = "Unable to load section data: " + error.message

]
