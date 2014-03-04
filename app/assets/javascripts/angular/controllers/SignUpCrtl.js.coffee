@exam.controller 'SignUpCrtl', ['$scope', 'Session', 'User', 'NextOfKin', 'Employer', 'PreEnrolmentTest', '$routeParams', '$location', '$window', 'ExamSections', ($scope, Session, User, NextOfKin, Employer, PreEnrolmentTest, $routeParams, $location, $window, ExamSections) ->

	$scope.sections = ExamSections.sections

	$scope.CSCSCheck = ->
		User.checkCSCS($scope.user).success((user) ->
	    	$window.sessionStorage.user_id = user.user.id
	    	$window.sessionStorage.authToken = user.user.authentication_token
	    	$window.sessionStorage["cscs_check"] = true
	    	$location.path "/signup"
	  	).error (error) ->
	    	$scope.error = error.errors

	$scope.signUp = ->
		User.updateUser($window.sessionStorage.user_id, $scope.user).success((data) ->
			$window.sessionStorage["signup"] = true
			$location.path "/signup_2"
		).error (errors) ->
	    	$scope.error = errors.errors

	$scope.signUp2 = ->
		User.updateUser($window.sessionStorage.user_id, $scope.user).success((data) ->
			$window.sessionStorage["signup2"] = true
			$location.path "/next_of_kin"
		).error (errors) ->
	    	$scope.error = errors.errors

	$scope.addNextOfKin = ->
		NextOfKin.addNextOfKin($window.sessionStorage.user_id, $scope.next_of_kin).success((data) ->
			$window.sessionStorage.next_of_kin_id = data.next_of_kin.id unless data is " "
			$window.sessionStorage["next_of_kin"] = true
			$location.path "/employer"
		).error (errors) ->
			$scope.error = errors.errors

	$scope.addEmployer = ->
		Employer.addEmployer($window.sessionStorage.user_id, $scope.employer).success((data) ->
			$window.sessionStorage.employer_id = data.employer.id
			$window.sessionStorage["employer"] = true
			PreEnrolmentTest.beginTest().success((data) ->
				$location.path "/section/" + data.section.id
			).error(errors) ->
				$scope.error = errors.errors
		).error (errors) ->
			$scope.error = errors.errors

	$scope.getUser = ->
		User.getUser($window.sessionStorage.user_id).success((user) ->
	    	$scope.user = user.user
	  	).error (error) ->
	    	$scope.status = "Unable to load user data: " + error.message

	$scope.getNextOfKin = ->
		if $window.sessionStorage.next_of_kin_id
			NextOfKin.getNextOfKin($window.sessionStorage.user_id, $window.sessionStorage.next_of_kin_id).success((data) ->
		    	$scope.next_of_kin = data.next_of_kin
		  	).error (error) ->
		    	$scope.status = "Unable to load user data: " + error.message

	$scope.getEmployer = ->
		if $window.sessionStorage.employer_id
			Employer.getEmployer($window.sessionStorage.user_id, $window.sessionStorage.employer_id).success((data) ->
		    	$scope.employer = data.employer
		  	).error (error) ->
		    	$scope.status = "Unable to load user data: " + error.message

]