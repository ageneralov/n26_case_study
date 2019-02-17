({
	 handleInit : function(component, event, helper) {
    	var action = component.get("c.getPricing");
	    
         action.setParams({ 
                "caseId" : component.get('v.recordId')
            });
         
         action.setCallback(this, function(response) {
	      if(response.getState() === "SUCCESS") {
	        component.set('v.pricing', response.getReturnValue());
	    }});
         
	    $A.enqueueAction(action); 
	}
})