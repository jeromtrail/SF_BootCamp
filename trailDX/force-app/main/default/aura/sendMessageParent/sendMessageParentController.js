({
	//handleSend : function(component, event) {
		//var params = event.getParams();
       // var messages = params.message;
       // alert('Received message: '+ messages);
      
    doGreet : function(component, event, helper) {
        component.find('greeter').sayHello();
    }	
    
	}
)