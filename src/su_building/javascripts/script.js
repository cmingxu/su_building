var building = angular.module("building", []);

building.controller('main', ["$scope", "$http", "$interval", function ($scope, $http, $interval) {
  $scope.current_model = {};
  $scope.local_skp_names = "";

  $scope.bridge = function (action, param) {
    window.location.href = "skp:" + action + "@" + param;
  }

  $scope.$watch("skp_names", function (newVal, old) {
    $scope.bridge('logger', 'newval' + newVal);
  })

  $scope.$watch("current_model", function (newVal, old) {
    $scope.bridge('logger', 'newval' + newVal.icon);
  })

}]);
