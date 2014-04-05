@admin.controller 'DisciplinaryCardCrtl', ['$scope', 'DisciplinaryCard', 'Session', '$routeParams', '$location', ($scope, DisciplinaryCard, Session, $routeParams, $location) ->

	$scope.id = $routeParams.id
	$scope.disciplinaryCards = []
	$scope.currentPage = 1
	$scope.lastPage = 1

	$scope.getDisciplinaryCards = ->
		DisciplinaryCard.getDisciplinaryCards().success((disciplinaryCards) ->
	    	$scope.disciplinaryCards = disciplinaryCards
	    	$scope.lastPage = Math.ceil($scope.disciplinaryCards.length/10)
		).error (error) ->
	    	$scope.status = "Unable to load disciplinary card data: " + error.message

	$scope.getDisciplinaryCard = ->
		DisciplinaryCard.getDisciplinaryCard($scope.id).success((disciplinaryCard) ->
	    	$scope.disciplinaryCard = disciplinaryCard.disciplinary_card
	  	).error (error) ->
	    	$scope.status = "Unable to load disciplinary card data: " + error.message

	$scope.deleteDisciplinaryCardFromTable = (id ,index) ->
		DisciplinaryCard.deleteDisciplinaryCard(id).success((data) ->
	    	$scope.disciplinaryCards.splice(index, 1)
	  	).error (error) ->
	    	$scope.status = "There was an error deleting this card: " + error.message

	$scope.deleteDisciplinaryCard = ->
		DisciplinaryCard.deleteDisciplinaryCard($scope.id).success((data) ->
	    	$location.path('/admin/disciplinary_cards/')
	  	).error (error) ->
	    	$scope.status = "There was an error deleting this card: " + error.message

	$scope.allowed = (role) ->
		if window.sessionStorage.role >= role && window.sessionStorage.role != undefined
			true
		else
			false

]
