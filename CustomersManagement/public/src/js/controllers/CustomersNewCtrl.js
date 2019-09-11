angular.module('CustomersNewCtrl', []).controller('CustomersNewCtrl', ['$scope', 'CustomerService', 'Customer', function($scope, CustomerService, Customer){

	$scope.newCustomer = {
		fname: 'new name',
		sname: 'svsd'
	};

	$scope.save = function(){
		$scope.customer.fname = newCustomer.fname;
		$scope.customer.sname = newCustomer.sname;
		$scope.customer.post();
	};

}]);