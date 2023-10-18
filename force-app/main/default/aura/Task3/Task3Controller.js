({
    init: function(component, event, helper) {
        helper.loadContacts(component);
    },
    
    search1: function(component, event, helper) {
        var accountName1 = component.get("v.accountName1");
        
        var action = component.get("c.getContactsByAcc");
        action.setParams({ accountName: accountName1 });

        var action2 = component.get("c.getContactcount");
        action2.setParams({ accountName: accountName1 });
      
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var contacts = response.getReturnValue();
                component.set("v.contacts1", contacts);
                
                // component.set("v.contactCount1", contactcount);
                $A.enqueueAction(action2);                
            } else {
                console.error("Error searching for account: " + state);
            }
        });

        action2.setCallback(this, function(response2) {
            var state2 = response2.getState();
            if (state2 === "SUCCESS") {
                var contactcount = response2.getReturnValue();
                component.set("v.contactCount1", contactcount);
                console.log(contactcount);
            } else {
                console.error("Error searching for account: " + state2);
            }
        });
        $A.enqueueAction(action);

    },
    search2: function(component, event, helper) {
        var accountName2 = component.get("v.accountName2");
        
        var action = component.get("c.getContactsByAcc");
        action.setParams({ accountName: accountName2 });

        var action2 = component.get("c.getContactcount");
        action2.setParams({ accountName: accountName2 });
        
        
        // action.setCallback(this, function(response) {
        //     var state = response.getState();
        //     if (state === "SUCCESS") {
        //         var contacts = response.getReturnValue();
        //         component.set("v.contacts2", contacts);
        //         // component.set("v.contactCount2",contactcount );

        //     } else {
        //         console.error("Error searching for account: " + state);
        //     }
        // });
        
        // $A.enqueueAction(action);
             
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var contacts = response.getReturnValue();
                component.set("v.contacts2", contacts);
                
                // component.set("v.contactCount1", contactcount);
                $A.enqueueAction(action2);                
            } else {
                console.error("Error searching for account: " + state);
            }
        });

        action2.setCallback(this, function(response2) {
            var state2 = response2.getState();
            if (state2 === "SUCCESS") {
                var contactcount = response2.getReturnValue();
                component.set("v.contactCount2", contactcount);
                console.log(contactcount);
            } else {
                console.error("Error searching for account: " + state2);
            }
        });
        $A.enqueueAction(action);
    },

    onDragStart: function(component, event, helper) {
        var contactId = event.target.dataset.contactId;
        console.log(contactId);
        // var sourceSection = event.target.dataset.section;
        event.dataTransfer.setData("text", contactId);
        // event.dataTransfer.setData("text", JSON.stringify({ contactId: contactId, sourceSection: sourceSection }));
    },

    allowDrop: function(component, event, helper) {
        event.preventDefault();
    },
    // onDrop: function(component, event, helper) {
    //     event.preventDefault();
    //     var contactId = event.dataTransfer.getData("text");

    //     // Determine the source and destination sections
    //     var sourceSection = event.target.parentElement.parentElement.parentElement;
    //     var destinationSection = event.currentTarget.parentElement.parentElement.parentElement;

    //     if (sourceSection !== destinationSection) {
    //         // Move the contact to the new section
    //         // helper.moveContact(component, contactId,sourceSection, destinationSection);
    //         var accountName = (sourceSection === component.getElement())
    //             ? component.get("v.accountName2") // Move from section 1 to section 2
    //             : component.get("v.accountName1"); // Move from section 2 to section 1

    //             helper.updateContactAccount(component, contactId, accountName);

    //     }
    // },

    onDrop: function (component, event, helper) {
        event.preventDefault();
        var contactId = event.dataTransfer.getData("text");
        var sourceSection = event.currentTarget.dataset.sourceSection; // Get the source section from the current element
        console.log('source', sourceSection);
    
        // Determine the destination section based on the section where the drop event occurred
        var destinationSection = (sourceSection === "1") ? "2" : "1";
        console.log('destination', destinationSection);
        // Call the helper method to handle the contact movement between sections
        helper.moveContact(component, contactId, sourceSection, destinationSection);
    }
    




















    // onDrop: function(component, event, helper) {
    //     event.preventDefault();
    //     var contactId = event.dataTransfer.getData("text");

    //     // Determine the source and destination sections
    //     var sourceSection = event.target.parentElement.parentElement.parentElement;
    //     var destinationSection = event.currentTarget.parentElement.parentElement.parentElement;

    //     // Check if the source and destination sections are different
    //     if (sourceSection !== destinationSection) {
    //         // Move the contact to the new section and remove it from the previous section
    //         helper.moveContact(component, contactId, sourceSection, destinationSection);
    //     }
    // },












    // onDrop: function (component, event, helper) {
    //     event.preventDefault();
    //     var contactId = event.dataTransfer.getData("text");
    
    //     // Determine the source and destination sections
    //     var sourceSection = event.target.parentElement.parentElement.parentElement;
    //     var destinationSection = event.currentTarget.parentElement.parentElement.parentElement;
    
    //     // Call the helper method to handle the contact movement
    //     helper.moveContactBetweenSections(component, contactId, sourceSection, destinationSection);
    // },
    // onDrop: function(component, event, helper) {
    //     event.preventDefault();
    //     var data = JSON.parse(event.dataTransfer.getData("text"));
    //     var contactId = data.contactId;
    //     var sourceSection = data.sourceSection;
    //     var destinationSection = event.currentTarget.dataset.section;
    
    //     if (sourceSection !== destinationSection) {
    //         // Call the helper method to move the contact
    //         helper.moveContactBetweenSections(component, contactId, sourceSection, destinationSection);
    //     }
    // },
    

 

    
})