angular.module('CustomersDetailsCtrl',[]).controller('CustomersDetailsCtrl', ['$scope','CustomersService', 'Customer', function($scope, CustomersService, Customer){
	
	$scope.$on('currentCustomer.change', function(event, currentCustomer){
		$scope.form.$cancel();
		$scope.customer = currentCustomer;
	})

	//reserved for the form
	$scope.form;
	//on form load it will call this function setting the form so we can use form.$cancel() etc.. from the controller
	$scope.setForm = function(name){
		$scope.form = name;
	}

	$scope.checkName = function(data) {
		console.log($scope.customer);
	    if (data == '') {
	      return "Firstname cannot be empty";
	    }
  	};

  	$scope.saveCustomer = function(data){
  		console.log('saved customer');
  		console.log(data)
  		$scope.customer.fname = data.fname;
  		$scope.customer.sname = data.sname;
  		$scope.customer.put();
  	}

}])