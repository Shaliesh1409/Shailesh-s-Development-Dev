({
    init: function (component, event, helper) {
        var action = component.get("c.getAccountsWithOpportunitiesAndContacts");
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.accountData", response.getReturnValue());
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    // Handle error
                }
            }
        });
        $A.enqueueAction(action);
    }
})