@exam.controller 'SignUpCrtl', ['$scope', 'Session', 'User', 'NextOfKin', 'Employer', 'PreEnrolmentTest', '$routeParams', '$location', '$window', 'ExamSections', "$upload", ($scope, Session, User, NextOfKin, Employer, PreEnrolmentTest, $routeParams, $location, $window, ExamSections, $upload) ->

	$scope.sections = ExamSections.sections

	$scope.CSCSCheck = ->
		User.checkCSCS($scope.user).success((user) ->
	    	$window.sessionStorage.user_id = user.user.id
	    	$window.sessionStorage.next_of_kin_id = user.user.next_of_kin_id
	    	$window.sessionStorage.employer_id = user.user.employer_id
	    	$window.sessionStorage.authToken = user.user.authentication_token
	    	$window.sessionStorage["cscs_check"] = true
	    	$location.path "/test/signup"
	  	).error (error) ->
	    	$scope.error = error.errors

	$scope.signUp = ->
		if $scope.selectedFiles is undefined
			$scope.error = {}
			$scope.error.profile = []
			return $scope.error.profile[0] = "Please upload an image"
		$scope.user.photo = true
		$scope.progress = 0
		file = $scope.selectedFiles[0]
		$scope.upload = $upload.upload(
        url: "/api/users/" + $window.sessionStorage.user_id
        method: "PUT"
        data: $scope.user
        file: file
        headers: { 'auth-token': sessionStorage.authToken }
        ).progress((evt) ->

        ).success((data, status, headers, config) ->
        	$window.sessionStorage["signup"] = true
        	$location.path "/test/signup_2"
        ).error (errors) ->
        	$scope.error = errors.errors

	$scope.signUp2 = ->
		User.updateUser($window.sessionStorage.user_id, $scope.user).success((data) ->
			$window.sessionStorage["signup2"] = true
			$location.path "/test/next_of_kin"
		).error (errors) ->
	    	$scope.error = errors.errors

	$scope.addNextOfKin = ->
		NextOfKin.addNextOfKin($window.sessionStorage.user_id, $scope.next_of_kin).success((data) ->
			$window.sessionStorage.next_of_kin_id = data.next_of_kin.id unless data is " "
			$window.sessionStorage["next_of_kin"] = true
			$location.path "/test/employer"
		).error (errors) ->
			$scope.error = errors.errors

	$scope.addEmployer = ->
		Employer.addEmployer($window.sessionStorage.user_id, $scope.employer).success((data) ->
			$window.sessionStorage.employer_id = data.employer.id
			$window.sessionStorage["employer"] = true
			PreEnrolmentTest.beginTest().success((data) ->
				$location.path "/test/section/" + data.section.id
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

	$scope.finishedSignUp = ->
		$window.sessionStorage["cscs_check"] is "true" and $window.sessionStorage["signup"] is "true" and $window.sessionStorage["signup2"] is "true"

	$scope.onFileSelect = ($files) ->
	    $scope.selectedFiles = $files

]
