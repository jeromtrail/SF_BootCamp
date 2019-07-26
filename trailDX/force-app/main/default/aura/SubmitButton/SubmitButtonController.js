({
	sayHello : function(component, event, helper) {
		var message = component.get('v.message');
        helper.pleaseSayHello(component, message);
	}
})