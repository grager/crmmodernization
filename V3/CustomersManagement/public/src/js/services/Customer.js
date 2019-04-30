angular.module('Customer', [])
	.service('Customer', ['$rootScope','Restangular', function($rootScope, Restangular){
	var Customer	= Restangular.service('customers');
	Restangular.extendModel('customers', function(model){
		model.fullname = function(){
			return this.fname+' '+this.sname;
		};
		model.over18 = function(){
			if(this.age >= 18){
				return 'yes';
			}else{
				return 'no';
			}
			
		};
		return model;
	})

	return Customer;
}]);
