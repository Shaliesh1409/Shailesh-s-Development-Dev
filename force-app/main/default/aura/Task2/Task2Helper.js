({
    fetchContacts: function (component) {

        try {
            console.log('helper rrr');
            var accountName = component.get("v.accountName");
            var pageSize = component.get("v.pageSize");
            var currentPage = component.get("v.currentPage");
    
            var action = component.get("c.getContactsByAccountName");
            action.setParams({
                accountName: accountName,
                pageNumber: currentPage,
                pageSize: pageSize
            });
        
            action.setCallback(this, function (response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var result = response.getReturnValue();
                    component.set("v.contacts", result.contacts);
                    component.set("v.totalPages", result.totalPages);
                    component.set("v.totalContacts", result.totalContacts);
                    console.log('helper 1');
                    
    				console.log('currentPage--->',currentPage);
                    console.log('pageSize--->',pageSize);
                    var startRecord = (currentPage - 1) * pageSize + 1;
                    console.log('startRecord--',startRecord);
                    var endRecord = startRecord + pageSize -1;
                    console.log('page number ::'+currentPage);
    
                    console.log('start-->'+startRecord);
                    console.log('end-->'+endRecord);
                    console.log('total-->'+"v.totalContacts");
    
    				
                    component.set("v.startRecord", startRecord);
                    component.set("v.endRecord", endRecord);
                    component.set("v.totalContacts", totalContacts);
    
                } else {
                    console.error("Error fetching contacts: " + state);
                }
            });
        
            $A.enqueueAction(action);
        } catch (error) {
            console.log(error.message);
        }
    }
    });