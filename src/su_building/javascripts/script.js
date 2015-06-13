var building = angular.module("building", []);

building.controller('main', ["$scope", "$http", function ($scope, $http) {
  $scope.current_model = {};
  $scope.local_skp_names = "";

  $scope.bridge = function (action, color) {
    window.location.href = "skp:" + action + "@" + color;
  }

  $scope.$watch("skp_names", function (newVal, old) {
    $scope.bridge('logger', 'newval' + newVal);
  })


}]);
