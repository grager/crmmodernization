angular.module('newCustomerModal',[]).directive('newCustomerModal', function(CustomersService, Customer){
	return {
 		restrict: 'A',
        scope: { //isolates scope from parent
            modalVisible: '=', //2 way binding, both parent and directive can change state causing the modal to hide/show
            confirm: '&' //access to parent scope function
            newCustomer: {}
        },
        //replace: true, 
        //transclude: true, 
        link: function(scope, element, attrs) {
            /*scope.hideModal = function() {
            scope.show = false;
        	};
            */
           //scope.newCustomer.fname = '';
        
            scope.showModal = function(visible){
                if(visible){
                    element.modal('show');
                }else{
                    element.modal('hide');
                }
            }

            //if modalVisible attribute exists
            if(!attrs.modalVisible){
                scope.showModal

            }else{
                //watch changes to modal-visible attr
                scope.$watch("modalVisible", function(newVal, oldVal){
                    scope.showModal(newVal);
                })

                //update modalVisible from Modal actions
                element.bind("hide.bs.modal", function(){
                    scope.modalVisible = false;
                    if(!scope.$$phase && !scope.$root.$$phase)
                        scope.$apply();
                })

            }

           
                      
            scope.save = function(){
                //scope.confirm(); //calls parent function
                //$scope.customer.fname = newCustomer.fname;
                //$scope.customer.sname = newCustomer.sname;
                //$scope.customer.post();      
                CustomersService.createCustomer({fname: 'z',sname:'w'});          
           }
           
     	},
        controller: function(){

        },
		templateUrl: 'views/customers/newCustomerModal.html',
	}
})
