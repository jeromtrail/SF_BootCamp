({
    doInit : function(component, event) {
        var action = component.get("c.getPickListValuesIntoList");
        action.setParams({
            objectType: component.get("v.sObjectName"),
            selectedField: component.get("v.fieldName"),
            
        });
        action.setCallback(this, function(response) {
            var list = response.getReturnValue();
            var lstOrigin = [];
            for (var key in list){
                lstOrigin.push(list[key]);
            }
            component.set("v.picklistValues", lstOrigin);
            console.log("Asd" + component.get("v.origin"));
        });
        
        
         var action2 = component.get("c.getPickListValuesIntoList2");
        action2.setParams({
            objectType2: component.get("v.sObjectName2"),
            selectedField2: component.get("v.fieldName2"),
            
        });
        action2.setCallback(this, function(response2) {
            var list2 = response2.getReturnValue();
            //console.log (list2[0]);
            component.set("v.picklistValues2", list2);
        });
        
      
        $A.enqueueAction(action);
        $A.enqueueAction(action2);
      
    },
    
    searchFlight: function (component, event){
        var searchEve = $A.get("e.c:searchFlightEvent");
        console.log("origin" + component.get("v.origin"));
        
        searchEve.setParams ({
            "origin": component.get("v.origin"),
            "destination": component.get("v.desti"),
            "desti": component.get("v.depart")
        }),
	
        searchEve.fire();
        
    }
    
    
    
})