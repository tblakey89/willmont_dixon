angular.module("adminService", []).factory("User", ["$http", ($http, $window) ->
  urlBase = "/api/users"
  dataFactory = {}

  dataFactory.getUsers = () ->
    $http.get(urlBase, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.getUser = (id) ->
    $http.get(urlBase + "/" + id, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.getDisciplinaryCards = (id) ->
    $http.get(urlBase + "/" + id + "/disciplinary_cards", { headers: { 'auth-token': sessionStorage.authToken } })

  #dataFactory.insertCustomer = (cust) ->
    #$http.post urlBase, cust

  #dataFactory.updateCustomer = (cust) ->
    #$http.put urlBase + "/" + cust.ID, cust

  #dataFactory.deleteCustomer = (id) ->
    #$http.delete urlBase + "/" + id

  dataFactory
]).factory("NextOfKin", ["$http", ($http, $window) ->
  dataFactory = {}

  urlBase = (userId) ->
  	"/api/users/" + userId + "/next_of_kins"

  dataFactory.getNextOfKins = (userId) ->
    $http.get(urlBase(userId), { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.getNextOfKin = (userId, id) ->
    $http.get(urlBase(userId) + "/" + id, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory
]).factory("Section", ["$http", ($http, $window) ->
  dataFactory = {}
  urlBase = "/api/pre_enrolment_tests/1/sections/"

  dataFactory.getSections = ->
    $http.get(urlBase, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.getSection = (id) ->
    $http.get(urlBase + id, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.getQuestions = (id) ->
    $http.get(urlBase + id + "/questions", { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory
]).factory("Question", ["$http", ($http, $window) ->
  dataFactory = {}
  urlBase = "/api/pre_enrolment_tests/1/questions/"

  dataFactory.getQuestions = ->
    $http.get(urlBase, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.getQuestion = (id) ->
    $http.get(urlBase + id, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory
]).factory("DisciplinaryCard", ["$http", ($http, $window) ->
  dataFactory = {}
  urlBase = "/api/disciplinary_cards/"

  dataFactory.getDisciplinaryCards = ->
    $http.get(urlBase, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.getDisciplinaryCard = (id) ->
    $http.get(urlBase + id, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory
])