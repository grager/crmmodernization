angular.module('CustomersListCtrl', ['ngGrid']).controller('CustomersListCtrl', ['$scope', 'CustomersService', function($scope, CustomersService){

	$scope.filterOptions = {
		filterText: ''
	};

	$scope.newCustomer = {
		fname: 'new name',
		sname: 'svsd'
	}

	/*$scope.modalShown = false;
	$scope.toggleModal = function(){
		$scope.modalShown = !$scope.modalShown;
	}
	$scope.saveNewCustomer = function(){
		CustomersService.createCustomer('thing');
	}
	*/

	$scope.modalShown = false;
	$scope.addCustomer = function() {
	 	 /*
		CustomersService.setCurrentCustomer({
			age: 0,
			fname: ''
		});
		*/
/*
		var newCustomer = {
			fname: 'Zor',
			age: 99
		}

		Customer.post(newCustomer).then(function(){
			//fetch new list of customers
			CustomersService.getCustomers();
		});
		*/
	 	CustomersService.setCurrentCustomer(null);
	  	$scope.modalShown = !$scope.modalShown;
	};
	$scope.confirmCtrl = function () {
	    alert('confirmed');
	}

	//when customer list changes update this local scope or customers
	$scope.$on('customerList.change', function(event,customerList){
		$scope.customers = customerList;
	})

	$scope.btns = '<button class="btn btn-default btn-xs" ng-click="deleteCustomer($event, row)">Delete</button>';

	$scope.deleteCustomer = function(event, row){
		event.stopPropagation();
		CustomersService.removeCustomer(row.entity);
	}

	$scope.gridOptions = {
		data: 'customers',
		//selectedItem: 
		//afterSelectionChange: function(rowItem, event){
		beforeSelectionChange: function(rowItem, event){
			$scope.focusCustomer(rowItem.entity);
		},
		columnDefs: [
			{
				//field:'fullname()',
				field:'fname',
				displayName:'Name',
				cellClass: 'gridCell',
				headerClass: 'gridHeader'
			},
			/*{
				//fullname() cannot be filtered on
				field: 'fullname()',
				displayName: 'Fullname',
				cellClass: 'gridCell',
				headerClass: 'gridHeader'
			},*/
			{
				field:'age',
				displayName:'Age',
				cellClass: 'gridCell',
				headerClass: 'gridHeader'
			},
			{
				displayName: 'Actions',
				cellTemplate: $scope.btns,
				cellClass: 'gridCell',
				headerClass: 'gridHeader'
			}
		],
		multiSelect: false,
		filterOptions: $scope.filterOptions
	}

	$scope.focusCustomer = function(customer){
		CustomersService.setCurrentCustomer(customer);
		console.log(CustomersService.currentCustomer);
		customer.fullname();
		//customer.over18();
	}

	//fetch all customers
	CustomersService.getCustomers();

}]);