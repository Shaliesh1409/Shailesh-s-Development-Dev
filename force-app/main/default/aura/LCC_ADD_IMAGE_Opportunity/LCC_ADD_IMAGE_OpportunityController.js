({
	apexExecute : function(component, event, helper) {
		//Call Your Apex Controller Method.
		var action = component.get("c.attachRandomImageToOpportunity");

		action.setParams({
			'opportunityId': ''+component.get('v.sObjectInfo.Id')+''
		});

		action.setCallback(this, function(response) {
			var state = response.getState();
			console.log(state);
			
			if (state === "SUCCESS") {
				//after code
				var result = response.getReturnValue();
window.location.reload();

			} else {
				
			}

			
		});

		$A.enqueueAction(action);
	},

	accept : function(component, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
	}
})