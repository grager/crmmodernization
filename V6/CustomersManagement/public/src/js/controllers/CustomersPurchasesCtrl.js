angular.module('CustomersPurchasesCtrl', ['ngGrid']).controller('CustomersPurchasesCtrl', ['$scope', 'CustomersService', 'Customer', function($scope, CustomersService, Customer){

	$scope.purchases = [];

	$scope.$on('currentCustomer.change', function(event, currentCustomer){
		//get purchases
		if(currentCustomer != null){
			currentCustomer.getList('purchases').then(function(purchases){
				console.log(purchases);
				$scope.purchases = purchases;
			})
		}else{
			$scope.purchases = [];
		}
		
		
	})

	$scope.gridOptions = {
		data: 'purchases',
		//selectedItem: 
		//afterSelectionChange: function(rowItem, event){
		beforeSelectionChange: function(rowItem, event){
			$scope.focusPurchase(rowItem.entity);
		},
		columnDefs: [
			{
				field:'type',
				displayName:'Type',
				cellClass: 'gridCell',
				headerClass: 'gridHeader'
			}
		],
		multiSelect: false
	}

	$scope.focusPurchase = function(purchase){
		
	}

}])