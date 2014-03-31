@admin.controller 'HomeCrtl', ['$scope', 'User', 'Session', 'PreEnrolmentTest', ($scope, User, Session, PreEnrolmentTest) ->
	
	$scope.getUsers = ->
		User.getUsers().success((users) ->
	    	$scope.users = users
	  	).error (error) ->
	    	$scope.status = "Unable to load user data: " + error.message

	$scope.getInfo = ->
		PreEnrolmentTest.getInfo().success((data) ->
			$scope.users = data.users
			$scope.red = data.red_cards
			$scope.yellow = data.yellow_cards
			$scope.green = data.green_cards
			$scope.count = data.user_count
		).error (error) ->
			$scope.status = "Unable to load data: " + error.message
]
