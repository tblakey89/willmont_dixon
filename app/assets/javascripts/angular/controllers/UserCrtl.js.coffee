@admin.controller 'UserCrtl', ['$scope', 'User', 'NextOfKin', 'DisciplinaryCard', 'Session', '$routeParams', '$location', ($scope, User, NextOfKin, DisciplinaryCard, Session, $routeParams, $location) ->

	$scope.id = $routeParams.userId

	$scope.getUsers = ->
		User.getUsers().success((users) ->
	    	$scope.users = users
	  	).error (error) ->
	    	$scope.status = "Unable to load user data: " + error.message

	$scope.getUser = ->
		User.getUser($scope.id).success((user) ->
	    	$scope.user = user.user
	  	).error (error) ->
	    	$scope.status = "Unable to load user data: " + error.message

	$scope.updateUser = ->
		User.updateUser($scope.id, $scope.user).success((data) ->
	    	$location.path('users/' + $scope.id)
	  	).error (error) ->
	    	$scope.status = "Unable to load user data: " + error.message

	$scope.deleteUserFromTable = (id ,index) ->
		User.deleteUser(id).success((data) ->
	    	$scope.users.splice(index, 1)
	  	).error (error) ->
	    	$scope.status = "There was an error deleting this user: " + error.message

	$scope.deleteUser = ->
		User.deleteUser($scope.id).success((data) ->
	    	$location.path('users/')
	  	).error (error) ->
	    	$scope.status = "There was an error deleting this user: " + error.message

	$scope.getNextOfKins = ->
		NextOfKin.getNextOfKins($scope.id).success((data) ->
	    	$scope.nextOfKins = data
	  	).error (error) ->
	    	$scope.status = "Unable to load user data: " + error.message

	$scope.deleteNextOfKin = (id, index) ->
		NextOfKin.deleteNextOfKin($scope.id, id).success((data) ->
			$scope.nextOfKins.splice(index, 1)
		).error (error) ->
			$scope.status = "There was an error deleting your data " + error.message

	$scope.getDisciplinaryCards = ->
		User.getDisciplinaryCards($scope.id).success((data) ->
	    	$scope.disciplinaryCards = data
	  	).error (error) ->
	    	$scope.status = "Unable to load user data: " + error.message

	$scope.addDisciplinaryCard = ->
		DisciplinaryCard.addDisciplinaryCard($scope.id, $scope.disciplinaryCard).success((data) ->
	    	$location.path('users/' + $scope.id)
	  	).error (error) ->
	    	$scope.status = "Unable to load user data: " + error.message

	$scope.deleteDisciplinaryCard = (id, index) ->
		DisciplinaryCard.deleteDisciplinaryCard(id).success((data) ->
			$scope.disciplinaryCards.splice(index, 1)
		).error (error) ->
	    	$scope.status = "Unable to load user data: " + error.message
]
