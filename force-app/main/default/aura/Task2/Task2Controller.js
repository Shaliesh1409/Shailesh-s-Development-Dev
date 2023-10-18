({
    init: function(component, event, helper) {
        helper.loadContacts(component);
    },
    
    searchAccount: function(component, event, helper) {
        // var accountName = component.get("v.accountName");
        
        // var action = component.get("c.getContactsByAccountName");
        // action.setParams({ accountName: accountName });
        
        // action.setCallback(this, function(response) {
        //     var state = response.getState();
        //     if (state === "SUCCESS") {
        //         var contacts = response.getReturnValue();
        //         component.set("v.contacts", contacts);
        //     } else {
        //         console.error("Error searching for account: " + state);
        //     }
        // });
        // $A.enqueueAction(action);

console.log('search acc');
        component.set("v.currentPage", 1);
        helper.fetchContacts(component);
        

    },


    previousPage: function (component, event, helper) {
        var currentPage = component.get("v.currentPage");
        if (currentPage > 1) {
            component.set("v.currentPage", currentPage - 1);
            helper.fetchContacts(component);
        }
    },

    nextPage: function (component, event, helper) {
        var currentPage = component.get("v.currentPage");
        var totalPages = component.get("v.totalPages");
        if (currentPage < totalPages) {
            component.set("v.currentPage", currentPage + 1);
            helper.fetchContacts(component);
        }
    },


    changePageSize: function(component, event, helper) {
        // Get the selected page size from the dropdown
        var selectedPageSize = component.find("pageSizeSelect").get("v.value");
        
        // Update the page size attribute and re-fetch contacts
        component.set("v.pageSize", parseInt(selectedPageSize));
        component.set("v.currentPage", 1); // Reset to the first page when page size changes
        helper.fetchContacts(component);
    },
})