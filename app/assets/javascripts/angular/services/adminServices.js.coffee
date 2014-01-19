angular.module("adminService", []).factory("User", ["$http", ($http, $window) ->
  urlBase = "/api/users/"
  dataFactory = {}

  dataFactory.getUsers = () ->
    $http.get(urlBase, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.getUser = (id) ->
    $http.get(urlBase + "/" + id, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.getDisciplinaryCards = (id) ->
    $http.get(urlBase + "/" + id + "/disciplinary_cards", { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.updateUser = (id, user) ->
    $http.put urlBase + id, { user: user }, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory.deleteUser = (id) ->
    $http.delete urlBase + id, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory
]).factory("NextOfKin", ["$http", ($http, $window) ->
  dataFactory = {}

  urlBase = (userId) ->
  	"/api/users/" + userId + "/next_of_kins/"

  dataFactory.getNextOfKins = (userId) ->
    $http.get(urlBase(userId), { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.getNextOfKin = (userId, id) ->
    $http.get(urlBase(userId) + "/" + id, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.addNextOfKin = (userId, nextOfKin) ->
    $http.post urlBase(userId), { next_of_kin: nextOfKin }, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory.updateNextOfKin = (userId, id, nextOfKin) ->
    $http.put urlBase(userId) + id, { next_of_kin: nextOfKin }, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory.deleteNextOfKin = (userId, id) ->
    $http.delete urlBase(userId) + id, { headers: { 'auth-token': sessionStorage.authToken } }

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

  dataFactory.addSection = (section) ->
    $http.post urlBase, { section: section }, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory.updateSection = (id, section) ->
    $http.put urlBase + id, { section: section }, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory.deleteSection = (id) ->
    $http.delete urlBase + id, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory
]).factory("Question", ["$http", ($http, $window) ->
  dataFactory = {}
  urlBase = "/api/pre_enrolment_tests/1/questions/"

  dataFactory.getQuestions = ->
    $http.get(urlBase, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.getQuestion = (id) ->
    $http.get(urlBase + id, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.addQuestion = (question) ->
    $http.post urlBase, { question: question }, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory.updateQuestion = (id, question) ->
    $http.put urlBase + id, { question: question }, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory.deleteQuestion = (id) ->
    $http.delete urlBase + id, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory
]).factory("DisciplinaryCard", ["$http", ($http, $window) ->
  dataFactory = {}
  urlBase = "/api/disciplinary_cards/"

  dataFactory.getDisciplinaryCards = ->
    $http.get(urlBase, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.getDisciplinaryCard = (id) ->
    $http.get(urlBase + id, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.addDisciplinaryCard = (userId, disciplinaryCard) ->
    disciplinaryCard.user_id = userId
    $http.post urlBase, { disciplinary_card: disciplinaryCard }, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory.deleteDisciplinaryCard = (id) ->
    $http.delete urlBase + id, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory
])