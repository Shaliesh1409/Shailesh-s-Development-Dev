({
    createContactRecord: function(component, conName) {
        var action = component.get("c.CreateContact");
        action.setParams({
            "Name": conName
        });

        action.setCallback(this, function(response) {
            var state = response.getState();

            if (state === "SUCCESS") {
                var conId = response.getReturnValue();
                // this.showSuccessToast("contact","Contact Created successfully");

                //  alert("Contact created successfully",+conId);

                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "Contact record created successfully.",
                    "type": "success"
                });
                toastEvent.fire();
            } else {
                alert('Error in creating contact');
            }
        });

        $A.enqueueAction(action);
    },
})