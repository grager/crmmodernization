var app = angular.module('app', [
//routing
	'ui.router',
	'appRoutes',

//Restangular
	'restangular',
	'RestangularConfig',

//Customers
'Customer',
	'CustomersListCtrl',
	'CustomersDetailsCtrl',
	'CustomersNewCtrl',
	'CustomersService',
	'CustomersPurchasesCtrl',
	
//ng-grid
	'ngGrid',
	'xeditable',

//Directives
	'newCustomerModal'
]);