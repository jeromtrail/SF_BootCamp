({
    doInit : function(component, event, helper) {
        var theDonation = component.get("v.svdonate");
        var action = component.get('c.setDonate');
      	action.setParams({dn : theDonation});
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS') {
                
                // component.set("v.svdonate", theDonation);
                
                alert('Thank you!');
            } 
            else {	
                alert('Failed to get records');
                
            }}
                           
                          );
        
           var top5 = component.get('c.getTop5');
           top5.setCallback(this, function(response){
  		   component.set("v.donList", response.getReturnValue());
                
           });
        
         // var totl = component.get('c.getSummary');
         //  totl.setCallback(this, function(response){
  		 //  component.set("v.TotAmnt", response.getReturnValue());
                
           // });
        
        
 
        
        $A.enqueueAction(action);
        $A.enqueueAction(top5);
       // $A.enqueueAction(totl);     
    }
})