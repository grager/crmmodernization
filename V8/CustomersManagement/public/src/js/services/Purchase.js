angular.module('Purchase', [])
	.service('Purchase', ['$rootScope','Restangular', function($rootScope, Restangular){
	var Purchase	= Restangular.service('purchases');
	Restangular.extendModel('purchases', function(model){
		return model;
	})

	return Purchase;
}]);
