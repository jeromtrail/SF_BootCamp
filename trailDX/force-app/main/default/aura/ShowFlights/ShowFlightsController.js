({
    getFlight : function (component, event){
        var Flyfrom = event.getParam("origin");
        var FlyTo = event.getParam("destination");
        var DepDate = event.getParam("desti");
        console.log(Flyfrom + ' ' + FlyTo + ' ' + DepDate);
        var act = component.get("c.searchFlight");
        
        act.setParams ({
            origin:Flyfrom, 
            destination:FlyTo, 
            desti:DepDate
        });
        act.setCallback(this, function(response){
            console.log('result '+ response.getReturnValue());
            var flightLst = response.getReturnValue();
            component.set("v.flightList", response.getReturnValue());
            
            var myObj = [];
            for(var i=0; i<flightLst.length; i++) {
                
                myObj.push({"key": flightLst[i].Id, "value":flightLst[i]});
                /*
                    var myRecord = flightLst[i];
                    var myKey = myRecord.Flight__c;
                    myRecord.isAdded = false;
                    var found = false;
                    for(var x=0; x<myObjectMap.length; x++) {
                        if("key" in myObjectMap[x] && myObjectMap[x]["key"] == myKey) {
                            myObjectMap[x]["selectedList"].push(myRecord);
                            found = true;
                            
                            break;
                        }
                        
                    } 
                    
                    if(!found) {
                        var tempBol = false;
                        var temp = { "key": myKey, "selectedList": [myRecord]};
                        myObjectMap.push(temp);
                    }*/
            }
            component.set('v.selectedList', myObj);
            
        });
        
        $A.enqueueAction(act);
        
    },
    
    newPopup : function(component, event, helper){
        var cmpTarget = component.find('Modalbox1');
        var cmpBack = component.find('Modalbackdrop');
        $A.util.addClass(cmpTarget, 'slds-fade-in-open');
        $A.util.addClass(cmpBack, 'slds-backdrop--open');
    },
    
    
    saveModal : function(component, event, helper){
        var fname = component.get("v.fname");
        var lname = component.get("v.lname");
        var em = component.get("v.em");
        var flightId = component.get("v.flightId");
        
        var action = component.get("c.searchContact");
        action.setParams({
            "fName"  : fname,
            "lName"  : lname,
            "email"	 : em,
            "flightId" : flightId
        });
        
        
        action.setCallback(this, function(response) {
            var state = response.getState();          
            if (state === "SUCCESS") {
                var id = response.getReturnValue();
                var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": id,
                    "slideDevName": "Detail"
                });
                navEvt.fire();
                
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title: "Success!",
                    message: "Booking successfully.",
                    duration:" 5000",
                    type: "success"
                });
                toastEvent.fire();
                
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                    errors[0].message);
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title: "Error!",
                            message: errors[0].message,
                            duration:" 5000",
                            type: "error"
                        });
                        toastEvent.fire();
                    }
                } 
                else {
                    console.log(response.getReturnValue());
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    closeNewModal : function(component, event, helper){
        var cmpTarget = component.find('Modalbox1');
        var cmpBack = component.find('Modalbackdrop');
        $A.util.removeClass(cmpBack,'slds-backdrop--open');
        $A.util.removeClass(cmpTarget, 'slds-fade-in-open');
    },
    
 //   getVal: function(component, event) {
        
    //    var selected = event.getSource().get("v.text");
    //    var flyid = event.getParam("selectid");
    //    var bksec = component.get("c.showSelected");
        
    //    component.set("v.flightId", selected.Id);
     //   component.set("v.nme", selected.Name);
     //   component.set("v.selectedFlight" ,selected);
        
        /*bksec.setParams ({
            selectid:selected,
            
        });
        
        
        
        /*bksec.setCallback(this, function(response){
            console.log('result '+ response.getReturnValue());
            component.set("v.selectedflight", response.getReturnValue());
            
        });
        
        $A.enqueueAction(bksec);
        //alert(selected);
        */
  //  },
    
    getValue: function(component, event) {
        
        var selected = event.getSource().get("v.text");
       
        component.set("v.flightId", selected.Id);
        component.set("v.nme", selected.Name);
        component.set("v.dpDate", selected.Departure_Date__c);
        component.set("v.org", selected.Depart_From__c);
        component.set("v.destin", selected.Depart_Arrive__c);
        component.set("v.selectedFlight" ,selected);
        
        /*bksec.setParams ({
            selectid:selected,
            
        });
        
        
        
        /*bksec.setCallback(this, function(response){
            console.log('result '+ response.getReturnValue());
            component.set("v.selectedflight", response.getReturnValue());
            
        });
        
        $A.enqueueAction(bksec);
        //alert(selected);
        */
    }
    
    
})