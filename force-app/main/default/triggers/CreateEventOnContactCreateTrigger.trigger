trigger CreateEventOnContactCreateTrigger on Contact (after insert) {
    List<Event> eventsToInsert=new List<Event>();
    for (Contact newContact : Trigger.new) {
        Event newEvent = new Event();
        newEvent.Subject = 'New Contact Created';
        newEvent.StartDateTime = System.now(); 
        newEvent.EndDateTime = System.now().addHours(1); 
        newEvent.WhoId = newContact.Id; 
        eventsToInsert.add(newEvent);
    }

    if (!eventsToInsert.isEmpty()) {
        insert eventsToInsert;
    }
}