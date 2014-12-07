@admin.controller 'HomeCrtl', ['$scope', 'User', 'Session', 'PreEnrolmentTest', ($scope, User, Session, PreEnrolmentTest) ->

	$scope.users = []
	$scope.expireds = []
	$scope.currentPage = 1
	$scope.lastPage = 1
	$scope.expiredCurrentPage = 1
	$scope.expiredLastPage = 1
	
	$scope.getUsers = ->
		User.getUsers().success((users) ->
	    	$scope.users = users
	  	).error (error) ->
	    	$scope.status = "Unable to load user data: " + error.message

	$scope.getInfo = ->
		PreEnrolmentTest.getInfo().success((data) ->
			$scope.users = data.users
			$scope.expireds = data.expireds
			$scope.lastPage = Math.ceil($scope.users.length/10)
			$scope.expiredlastPage = Math.ceil($scope.expireds.length/10)
			$scope.red = data.red_cards
			$scope.yellow = data.yellow_cards
			$scope.green = data.green_cards
			$scope.count = data.user_count
		).error (error) ->
			$scope.status = "Unable to load data: " + error.message
]
