({
    handleImageSelected: function (component, event, helper) {
        var imageData = event.getParam("message");
        console.log(imageData);
        component.set("v.imageData",imageData);
        console.log('sdsds'+component.get("v.imageData"));
    }
})