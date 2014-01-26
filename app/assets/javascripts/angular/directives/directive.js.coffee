angular.module("Directive", []).directive("menu", ->
  restrict: "E"
  transclude: true
  scope: {
  	active: '@'
  }
  templateUrl: "../../template/menu.html"
).directive("inputmodel", ->
  restrict: "E"
  transclude: true
  scope: {
  	id: '@'
  	model: '='
  	name: '@'
  	type: "@"
  	min: "@"
  	max: "@"
  error: '='
  }
  templateUrl: "../../template/input.html"
).directive("search", ->
  restrict: "E"
  transclude: true
  scope: {
    searchmodel: '='
    currentpage: '='
    models: '='
    lastpage: '='
  }
  controller: ($scope, $filter) ->
    $scope.changeSearch = () ->
      $scope.searchmodel = $scope.search
      $scope.array = $scope.models unless $scope.models is undefined
      $scope.currentpage = 1
      $scope.lastpage =  Math.ceil($filter('filter')($scope.array, $scope.search).length/10) unless $scope.array is undefined

  templateUrl: "../../template/search.html"
).directive("pagination", ->
  restrict: "E"
  transclude: true
  scope: {
    currentpage: '='
    lastpage: '='
    noArrow: '=?'
  }
  controller: ($scope) ->
    $scope.nextPage = ->
      $scope.currentpage++ unless $scope.currentpage is $scope.lastpage

    $scope.prevPage = ->
      $scope.currentpage-- unless $scope.currentpage is 1

    $scope.toLastPage = ->
      $scope.currentpage = $scope.lastpage

    $scope.keys= []
    $scope.keys.push
      code: 37
      action: ->
        $scope.prevPage() unless $scope.noArrow

    $scope.keys.push
      code: 39
      action: ->
        $scope.nextPage() unless $scope.noArrow

    $scope.$on "keydown", (msg, code) ->
      $scope.keys.forEach (o) ->
        return  if o.code isnt code
        o.action()
        $scope.$apply()
  templateUrl: "../../template/pagination.html"
).directive("ngEnter", ->
  (scope, element, attrs) ->
    element.bind "keydown keypress", (event) ->
      if event.which is 13
        scope.$apply ->
          scope.$eval attrs.ngEnter,
            event: event
        event.preventDefault()
).directive("keyTrap", ->
  (scope, elem) ->
    elem.bind "keydown", (event) ->
      scope.$broadcast "keydown", event.keyCode
)