angular.module("Directive", []).directive "menu", ->
  restrict: "E"
  transclude: true
  scope: {
  	active: '@'
  }
  templateUrl: "../../template/menu.html"
