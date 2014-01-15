@admin.controller 'DisciplinaryCardCrtl', ['$scope', 'DisciplinaryCard', 'Session', '$routeParams', ($scope, DisciplinaryCard, Session, $routeParams) ->

	$scope.id = $routeParams.id

	$scope.getDisciplinaryCards = ->
		DisciplinaryCard.getDisciplinaryCards().success((disciplinaryCards) ->
	    	$scope.disciplinaryCards = disciplinaryCards
	  	).error (error) ->
	    	$scope.status = "Unable to load disciplinary_card data: " + error.message

	$scope.getDisciplinaryCard = ->
		DisciplinaryCard.getDisciplinaryCard($scope.id).success((disciplinaryCard) ->
	    	$scope.disciplinaryCard = disciplinaryCard.disciplinary_card
	  	).error (error) ->
	    	$scope.status = "Unable to load disciplinary_card data: " + error.message

]
