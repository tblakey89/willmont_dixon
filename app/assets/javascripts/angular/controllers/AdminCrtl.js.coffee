@admin.controller 'AdminCrtl', ['$scope', 'Admin', 'Session', '$routeParams', '$location', ($scope, Admin, Session, $routeParams, $location) ->

	$scope.id = $routeParams.id

	$scope.getAdmins = ->
		Admin.getAdmins().success((admins) ->
	    	$scope.admins = admins.admins
	  	).error (error) ->
	    	$scope.status = "Unable to load admin data: " + error.message

	$scope.getAdmin = ->
		Admin.getAdmin($scope.id).success((admin) ->
	    	$scope.admin = admin.admin
	  	).error (error) ->
	    	$scope.status = "Unable to load admin data: " + error.message

	$scope.addAdmin = ->
		Admin.addAdmin($scope.admin).success((data) ->
	    	$location.path('admins/' + data.admin.id)
	  	).error (error) ->
	    	$scope.status = "Unable to load admin data: " + error.message

	$scope.updateAdmin = ->
		Admin.updateAdmin($scope.id, $scope.admin).success((data) ->
	    	$location.path('admins/' + $scope.id)
	  	).error (error) ->
	    	$scope.status = "Unable to load admin data: " + error.message

	$scope.deleteAdminFromTable = (id ,index) ->
		Admin.deleteAdmin(id).success((data) ->
	    	$scope.admins.splice(index, 1)
	  	).error (error) ->
	    	$scope.status = "There was an error deleting this admin: " + error.message

	$scope.deleteAdmin = ->
		Admin.deleteAdmin($scope.id).success((data) ->
	    	$location.path('admins/')
	  	).error (error) ->
	    	$scope.status = "There was an error deleting this admin: " + error.message
]
