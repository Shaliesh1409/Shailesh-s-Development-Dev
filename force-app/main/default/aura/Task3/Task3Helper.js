// ({
//     moveContactBetweenSections: function (component, contactId, sourceSection, destinationSection) {
//     // Determine the source and destination sections
//     var sourceContacts, destinationContacts;
//     var sourceAttribute, destinationAttribute;
//     var contactCountAttribute, destinationCountAttribute;

//     // Determine which section is the source and which is the destination
//     if (sourceSection === component.getElement()) {
//         sourceContacts = component.get("v.contacts1");
//         destinationContacts = component.get("v.contacts2");
//         sourceAttribute = "v.contacts1";
//         destinationAttribute = "v.contacts2";
//         contactCountAttribute = "v.contactCount1";
//         destinationCountAttribute = "v.contactCount2";
//     } else {
//         sourceContacts = component.get("v.contacts2");
//         destinationContacts = component.get("v.contacts1");
//         sourceAttribute = "v.contacts2";
//         destinationAttribute = "v.contacts1";
//         contactCountAttribute = "v.contactCount2";
//         destinationCountAttribute = "v.contactCount1";
//     }

//     // Find the contact to move in the source section
//     var contactToMove = sourceContacts.find(contact => contact.Id === contactId);

//     if (contactToMove) {
//         // Remove the contact from the source section
//         sourceContacts = sourceContacts.filter(contact => contact.Id !== contactId);

//         // Add the contact to the destination section
//         destinationContacts.push(contactToMove);

//         // Update the contact counts for both sections
//         component.set(sourceAttribute, sourceContacts);
//         component.set(destinationAttribute, destinationContacts);
//         component.set(contactCountAttribute, sourceContacts.length);
//         component.set(destinationCountAttribute, destinationContacts.length);

//         // Reset the selectedContact attribute (if needed)
//         component.set("v.selectedContact", null);
//     }
// }
// })

// ({
//     moveContact: function(component, contactId, sourceSection, destinationSection) {
//         // Get the contacts from both source and destination sections
//         var sourceContacts = component.get("v.contacts1"); // Assuming it's the first section
//         var destinationContacts = component.get("v.contacts2"); // Assuming it's the second section

//         // Find the contact to move in the source section
//         var contactToMove = sourceContacts.find(contact => contact.Id === contactId);

//         if (contactToMove) {
//             // Remove the contact from the source section
//             sourceContacts = sourceContacts.filter(contact => contact.Id !== contactId);

//             // Add the contact to the destination section
//             destinationContacts.push(contactToMove);

//             // Update the contact counts for both sections
//             component.set("v.contacts1", sourceContacts);
//             component.set("v.contacts2", destinationContacts);
//             component.set("v.contactCount1", sourceContacts.length);
//             component.set("v.contactCount2", destinationContacts.length);
//         }
//     }
// })

({moveContact: function(component, contactId, sourceSection, destinationSection) {
    // Determine the source and destination attributes and counts based on section
    var sourceContacts, destinationContacts;
    var sourceContactCountAttribute, destinationContactCountAttribute;

    if (sourceSection === "1" && destinationSection === "2") {
        sourceContacts = component.get("v.contacts1");
        destinationContacts = component.get("v.contacts2");
        sourceContactCountAttribute = "v.contactCount1";
        destinationContactCountAttribute = "v.contactCount2";
    } else if (sourceSection === "2" && destinationSection === "1") {
        sourceContacts = component.get("v.contacts2");
        destinationContacts = component.get("v.contacts1");
        sourceContactCountAttribute = "v.contactCount2";
        destinationContactCountAttribute = "v.contactCount1";
    } else {
        // Invalid section combination, do nothing
        return;
    }

    // Find the contact to move in the source section
    var contactToMove = sourceContacts.find(contact => contact.Id === contactId);

    if (contactToMove) {
        // Remove the contact from the source section
        sourceContacts = sourceContacts.filter(contact => contact.Id !== contactId);

        // Add the contact to the destination section
        destinationContacts.push(contactToMove);

        // Update the contact counts for both sections
        component.set(sourceContactCountAttribute, sourceContacts.length);
        component.set(destinationContactCountAttribute, destinationContacts.length);

        // Update the contact lists for both sections
        component.set("v.contacts1", sourceContacts);
        component.set("v.contacts2", destinationContacts);
    }
}
});






// // // accountSearchComponentHelper.js (or Apex class)
// // ({
// //     updateAccountContacts: function(component, contactId, newAccountId) {
// //         // Call an Apex method to update the parent Account accordingly
// //         var action = component.get("c.updateAccountContactRelationship");
// //         action.setParams({
// //             "contactId": contactId,
// //             "newAccountId": newAccountId
// //         });

// //         action.setCallback(this, function(response) {
// //             var state = response.getState();
// //             if (state === "SUCCESS") {
// //                 // Handle the successful update if needed
// //                 // For example, you can refresh the component or display a success message
// //             } else {
// //                 // Handle any errors
// //                 console.error("Error updating Account-Contact relationship: " + response.getError());
// //             }
// //         });

// //         $A.enqueueAction(action);
// //     }
// // })






// // // ({
   
    
// // //     section1: function(component) {
// // //         // Get the account name entered by the user
// // //         var accountName1 = component.get("v.accountName1");
        
// // //         // Call the server-side controller method to search for the account and retrieve its contacts
// // //         var action = component.get("c.getContactsByAcc");
// // //         action.setParams({ accountName: accountName1 });
        
// // //         action.setCallback(this, function(response) {
// // //             var state = response.getState();
// // //             if (state === "SUCCESS") {
// // //                 var contacts = response.getReturnValue();
// // //                 component.set("v.contacts1", contacts);
// // //             } else {
// // //                 console.error("Error searching for account: " + state);
// // //             }
// // //         });
        
// // //         $A.enqueueAction(action);

// // //     },


// // //     section2: function(component) {
// // //         // Get the account name entered by the user
// // //         var accountName2 = component.get("v.accountName2");
        
// // //         // Call the server-side controller method to search for the account and retrieve its contacts
// // //         var action = component.get("c.getContactsByAcc");
// // //         action.setParams({ accountName: accountName2 });
        
// // //         action.setCallback(this, function(response) {
// // //             var state = response.getState();
// // //             if (state === "SUCCESS") {
// // //                 var contacts = response.getReturnValue();
// // //                 component.set("v.contacts2", contacts);
// // //             } else {
// // //                 console.error("Error searching for account: " + state);
// // //             }
// // //         });
        
// // //         $A.enqueueAction(action);

// // //     }



// // // });


// ({
//     updateContactAccount: function(component, contactId, newAccountName) {
//         // Call an Apex method to update the contact's parent account
//         var action = component.get("c.updateContactParentAccount");
//         action.setParams({
//             "contactId": contactId,
//             "newAccountName": newAccountName
//         });

//         action.setCallback(this, function(response) {
//             var state = response.getState();
//             if (state === "SUCCESS") {
//                 // Handle the successful update if needed

//                 // Call a refresh method to update the component data
//                 component.find("refreshData").callMethod("refresh");
//             } else {
//                 // Handle any errors
//                 console.error("Error updating contact's parent account: " + response.getError());
//             }
//         });

//         $A.enqueueAction(action);
//     }
// })