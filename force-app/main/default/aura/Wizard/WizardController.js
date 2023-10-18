({
    nextTab : function(component, event, helper) {
        component.set("v.setMessage", '');           
        var showAccount = component.get("v.showAccount");
        var showContact = component.get("v.showContact");
        var showData = component.get("v.showEvent");
        
        if(showAccount == true){
            var accountName = component.find("Name").get("v.value");
            console.log('accountName:::'+accountName);
            if(accountName =='' || accountName == null){
                component.set("v.setMessage",'error');           
            }
            if(component.get("v.setMessage")=='error')
            { 
                component.set("v.showContact",false);
                component.set("v.showError", true);
                component.set("v.showEvent", false);
            }
            else
            { 
                component.set("v.showAccount", false);
                component.set("v.showContact", true);
                component.set("v.showError", false);
                component.set("v.showEvent", false);
            }
        }    
        if(showContact == true){
            var lastName = component.find("LastName").get("v.value");
            console.log('lastName:::'+lastName);
            if(lastName =='' || lastName == null){
                component.set("v.setMessage",'error');           
            }
            if(component.get("v.setMessage")=='error')
            { 
                component.set("v.showAccount", false);
                component.set("v.showError", true);
                component.set("v.showEvent", false);
            }
            else
            { 
                component.set("v.showAccount", false);
                component.set("v.showContact", false);
                component.set("v.showError", false);
                component.set("v.showEvent", true);
            }
        } 

    },
    prevTab : function(component, event, helper) {
        var showAccount = component.get("v.showAccount");
        var showContact = component.get("v.showContact");
        var showData = component.get("v.showEvent");
        
        if(showContact == true){
            component.set("v.showAccount", true);
            component.set("v.showContact", false);
            component.set("v.showError", false);
            component.set("v.showEvent", false);
        }    
        if(showData == true){
            component.set("v.showAccount", false);
            component.set("v.showContact", true);
            component.set("v.showError", false);
            component.set("v.showEvent", false);
        } 


        
    },
    
    
    // saveRecord : function(component, event, helper) {
    //     helper.saveData(component, event, helper); // You can keep this as it is for handling the save functionality.           
    // }


    saveRecord: function (component, event, helper) {
        try {
            
            var action = component.get("c.save");
            console.log('action', action );

            console.log(component.get("v.accountData"));
            console.log(component.get("v.contactData"));
            console.log('event',component.get("v.eventData"));
            action.setParams({
                accountData: component.get("v.accountData"),
                contactData: component.get("v.contactData"),
                eventData: component.get("v.eventData"),

                // eventSubject: component.get("v.eventData.Subject"),
                // eventlocation: component.get("v.eventData.Location"),
                // eventStartDateTime: component.get("v.eventData.StartDateTime"),
                // eventendDateTime: component.get("v.eventData.EndDateTime")
            });
            // console.log(v.eventData.Subject);
            action.setCallback(this, function (response) {
                console.log({response});
                var state = response.getState();
                var message = response.getReturnValue();
                console.log("message>>>>>>>>" + JSON.stringify(message));
                component.set("v.message", message);
                if (message == 'record successfully insert') {
                    document.getElementById("showErrorrTractConfig").style.display = "none";
                    document.getElementById("showMessageTractConfig").style.display = "block";
                } else {
                    document.getElementById("showMessageTractConfig").style.display = "none";
                    document.getElementById("showErrorrTractConfig").style.display = "block";
                }
            });
            $A.enqueueAction(action);
        } catch (error) {
            console.log(error);
        }
        },
    });