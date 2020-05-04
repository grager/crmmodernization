angular.module('CustomersService', []).service('CustomersService', ['$rootScope','Restangular', 'Customer', function($rootScope, Restangular, Customer){
	var service = {
		currentCustomer: [],
		setCurrentCustomer: function(customer){
			this.currentCustomer = customer;
			$rootScope.$broadcast('currentCustomer.change', customer);
		},
		getCustomers: function(){
				Customer.getList().then(function(customers){
				$rootScope.$broadcast('customerList.change', customers);
			})
		},
		removeCustomer: function(customer){
			customer.remove().then(function(){
				//refresh list
				this.getList();
			});
		},
		createCustomer: function(newCustomer){
			console.log(newCustomer);
		}
	};

	return service;
}]);
