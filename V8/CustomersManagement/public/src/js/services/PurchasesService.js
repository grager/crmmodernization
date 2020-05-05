angular.module('PurchasesService', []).service('PurchasesService', ['$rootScope','Restangular', 'Purchase', function($rootScope, Restangular, Purchase){
	var service = {
		currentPurchase: [],
		setCurrentPurchase: function(purchase){
			this.currentPurchase = purchase;
			$rootScope.$broadcast('currentPurchase.change', customer);
		},
		getUncheckedPurchases: function(){
				Purchase.one().then(function(purchases){
				$rootScope.$broadcast('customerList.change', customers);
			})
		},
		removePurchase: function(purchase){
			purchase.remove().then(function(){
				//refresh list
				this.getList();
			});
		},
		createPurchase: function(newPurchase){
			purchase.log(newPurchase);
		}
	};

	return service;
}]);
