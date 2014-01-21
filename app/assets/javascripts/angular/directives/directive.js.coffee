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
)