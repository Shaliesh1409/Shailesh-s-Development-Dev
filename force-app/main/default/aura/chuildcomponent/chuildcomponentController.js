({
    handleFileChange: function (component, event, helper) {
        var fileInput = component.find("fileInput").getElement();
        var file = fileInput.files[0];
        var reader = new FileReader();

        reader.onload = function () {
            var fileData = reader.result;
            var parentEvent = component.getEvent("compEvent");
            parentEvent.setParams({ "message" : fileData });
            parentEvent.fire();
        };

        if (file) {
            reader.readAsDataURL(file);
        }
    }
})