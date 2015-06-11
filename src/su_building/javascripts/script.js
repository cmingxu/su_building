var building = angular.module("building", []);

building.controller('main', ["$scope", "$http", function ($scope, $http) {
  $scope.name = "Building";
  $scope.bla = ["Red", "Green", "Blue"];

  $scope.bridge = function (action, color) {
    var img =  new Image();
    img.src = "skp:" + action + "@" + color;
  }

  $scope.skp_names = "";

  $scope.$watch("skp_names", function (newVal, old) {
    alert(newVal);
    $scope.bridge('logger', 'newval' + newVal);
    $scope.bridge('logger', 'old' + old);
  })


}]);
