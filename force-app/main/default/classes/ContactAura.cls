public class ContactAura {
    @AuraEnabled
    public static String CreateContact(String Name) {
        Contact con = new Contact();
        con.LastName=Name;

        insert con;

        return con.id;

    }
}