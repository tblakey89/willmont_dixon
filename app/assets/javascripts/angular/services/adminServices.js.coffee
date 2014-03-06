angular.module("adminService", []).factory("User", ["$http", ($http, $window) ->
  urlBase = "/api/users/"
  dataFactory = {}

  dataFactory.getUsers = () ->
    $http.get(urlBase, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.getUser = (id) ->
    $http.get(urlBase + id, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.getDisciplinaryCards = (id) ->
    $http.get(urlBase + id + "/disciplinary_cards", { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.updateUser = (id, user) ->
    $http.put urlBase + id, { user: user }, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory.deleteUser = (id) ->
    $http.delete urlBase + id, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory.checkCSCS = (user) ->
    $http.post urlBase + "cscs_check", { user: user }

  dataFactory
]).factory("Admin", ["$http", ($http, $window) ->
  urlBase = "/api/admins/"
  dataFactory = {}

  dataFactory.getAdmins = () ->
    $http.get(urlBase, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.getAdmin = (id) ->
    $http.get(urlBase + id, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.addAdmin = (admin) ->
    $http.post urlBase, { admin: admin }, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory.updateAdmin = (id, admin) ->
    $http.put urlBase + id, { admin: admin }, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory.deleteAdmin = (id) ->
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
]).factory("Employer", ["$http", ($http, $window) ->
  dataFactory = {}

  urlBase = (userId) ->
    "/api/users/" + userId + "/employers/"

  dataFactory.getEmployers = (userId) ->
    $http.get(urlBase(userId), { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.getEmployer = (userId, id) ->
    $http.get(urlBase(userId) + "/" + id, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.addEmployer = (userId, employer) ->
    $http.post urlBase(userId), { employer: employer }, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory.updateEmployer = (userId, id, employer) ->
    $http.put urlBase(userId) + id, { employer: employer }, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory.deleteEmployer = (userId, id) ->
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

  dataFactory.getVideos = (id) ->
    $http.get(urlBase + id + "/videos", { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.addSection = (section) ->
    $http.post urlBase, { section: section }, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory.updateSection = (id, section) ->
    $http.put urlBase + id, { section: section }, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory.deleteSection = (id) ->
    $http.delete urlBase + id, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory.checkAnswers = (id, answers) ->
    $http.post urlBase + id + "/check_answers", { answers: answers }, { headers: { 'auth-token': sessionStorage.authToken } }

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
]).factory("Video", ["$http", ($http, $window) ->
  dataFactory = {}
  urlBase = "/api/pre_enrolment_tests/1/videos/"

  dataFactory.getVideos = ->
    $http.get(urlBase, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.getVideo = (id) ->
    $http.get(urlBase + id, { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.getVideoAndQuestions = (id) ->
    $http.get(urlBase + id + "/and_questions", { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory.addVideo = (video) ->
    $http.post urlBase, { video: video }, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory.deleteVideo = (id) ->
    $http.delete urlBase + id, { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory
]).factory("PreEnrolmentTest", ["$http", ($http, $window) ->
  dataFactory = {}
  urlBase = "/api/pre_enrolment_tests/1/"

  dataFactory.beginTest = ->
    $http.get(urlBase + "begin_test", { headers: { 'auth-token': sessionStorage.authToken } })

  dataFactory
]).factory("ExamSections", ["$http", ($http, $window) ->
  dataFactory = {}
  dataFactory.sections = ""

  dataFactory.getSections = ->
    if dataFactory.sections is ""
      $http.get("/api/pre_enrolment_tests/1/sections/all", { headers: { 'auth-token': sessionStorage.authToken } })
    else
      dataFactory.sections

  dataFactory
]).factory("CurrentUser", ["$http", ($http, $window) ->
  dataFactory = {}
  dataFactory.user = ""

  dataFactory.getUser = ->
    if dataFactory.user is ""
      $http.post("/api/users/find_by_auth_token", { auth_token: sessionStorage.authToken }, { headers: { 'auth-token': sessionStorage.authToken } })
    else
      dataFactory.user

  dataFactory.submitResults = ->
    $http.get "/api/users/submit_results", { headers: { 'auth-token': sessionStorage.authToken } }

  dataFactory
])