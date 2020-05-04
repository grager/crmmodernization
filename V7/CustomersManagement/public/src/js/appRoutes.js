angular.module('appRoutes',[]).config(['$stateProvider','$urlRouterProvider', function($stateProvider, $urlRouterProvider){

	$urlRouterProvider.otherwise('/home');

	$stateProvider
		.state('home', {
			url:'/home',
			templateUrl: 'views/home.html'
		})

		.state('customers', {
			url: '/customers',
			views: {
				'': {
					templateUrl: 'views/customers/index.html'
				},
				'main@customers': {
					templateUrl: 'views/customers/list.html',
					controller: 'CustomersListCtrl'
				},
				'side@customers': {
					templateUrl: 'views/customers/details.html',
					controller: 'CustomersDetailsCtrl'
				},
				'bottom@customers': {
					templateUrl: 'views/customers/purchases.html',
					controller: 'CustomersPurchasesCtrl'
				}
			}
		})
}]);