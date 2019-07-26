({
	doInit : function(component) {
        
        var action = component.get('c.getAccounts');
        action.setCallback(this, function(response){
                           if(response.getState() === 'SUCCESS') {
            					component.set('v.accounts', response.getReturnValue());
        								} 
        					else {	
                                alert('Failed to get accounts');
                                
                           }
		
	});
    
    $A.enqueueAction(action);
    }
 		
 
})