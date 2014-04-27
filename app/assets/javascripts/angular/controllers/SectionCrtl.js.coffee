@admin.controller 'SectionCrtl', ['$scope', 'Section', 'Session', '$routeParams', '$location', ($scope, Section, Session, $routeParams, $location) ->

	$scope.id = $routeParams.id
	$scope.sections = []
	$scope.currentPage = 1
	$scope.lastPage = 1

	$scope.getSections = ->
		Section.getSections().success((sections) ->
	    	$scope.sections = sections
	    	$scope.lastPage = Math.ceil($scope.sections.length/10)
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

	$scope.getVideos = ->
		Section.getVideos($scope.id).success((videos) ->
	    	$scope.videos = videos
	  	).error (error) ->
	    	$scope.status = "Unable to load section data: " + error.message

	$scope.addSection = ->
		Section.addSection($scope.section).success((data) ->
	    	$location.path('/admin/sections/' + data.section.id)
	  	).error (errors) ->
	    	$scope.error = errors.errors

	$scope.updateSection = ->
		Section.updateSection($scope.id, $scope.section).success((data) ->
	    	$location.path('/admin/sections/' + $scope.id)
	  	).error (errors) ->
	    	$scope.error = errors.errors

	$scope.deleteSectionFromTable = (id ,index) ->
		if (confirm("Are you sure you want to delete this section?") is true)
			Section.deleteSection(id).success((data) ->
		    	$scope.sections.splice(index, 1)
		  	).error (error) ->
		    	$scope.status = "There was an error deleting this section: " + error.message

	$scope.deleteSection = ->
		if (confirm("Are you sure you want to delete this section?") is true)
			Section.deleteSection($scope.id).success((data) ->
		    	$location.path('/admin/sections/')
		  	).error (error) ->
		    	$scope.status = "Unable to load section data: " + error.message

	$scope.deleteVideo = (id) ->
		if (confirm("Are you sure you want to delete this video?") is true)
			Section.deleteVideo(id).success((data) ->
		    	$location.path('/admin/sections/' + $scope.id)
		  	).error (error) ->
		    	$scope.status = "Unable to load section data: " + error.message

	$scope.deleteQuestion = (id) ->
		if (confirm("Are you sure you want to delete this question?") is true)
			Section.deleteQuestion(id).success((data) ->
		    	$location.path('/admin/sections/' + $scope.id)
		  	).error (error) ->
		    	$scope.status = "Unable to load section data: " + error.message

	$scope.yesOrNo = (bool) ->
		if bool == true
			"Yes"
		else
			"No"

]
