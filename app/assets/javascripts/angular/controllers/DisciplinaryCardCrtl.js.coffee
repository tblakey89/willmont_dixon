@admin.controller 'DisciplinaryCardCrtl', ['$scope', 'DisciplinaryCard', 'Session', '$routeParams', '$location', ($scope, DisciplinaryCard, Session, $routeParams, $location) ->

	$scope.id = $routeParams.id

	$scope.getDisciplinaryCards = ->
		DisciplinaryCard.getDisciplinaryCards().success((disciplinaryCards) ->
	    	$scope.disciplinaryCards = disciplinaryCards
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
	    	$location.path('disciplinary_cards/')
	  	).error (error) ->
	    	$scope.status = "There was an error deleting this card: " + error.message

]
