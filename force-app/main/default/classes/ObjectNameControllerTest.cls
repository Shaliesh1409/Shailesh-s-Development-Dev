
@IsTest
public class ObjectNameControllerTest {
    @IsTest
    static void testGetObjectList() {
        List<String> objectList = ObjectNameController.getObjectList();

        System.assertNotEquals(null, objectList, 'Object list should not be null');
        System.assertNotEquals(0, objectList.size(), 'Object list should not be empty');
    }

    @IsTest
    static void testGetObjectRecords() {
        List<String> objectNames = new List<String>{'Account', 'Contact'};
        List<SObject> records = ObjectNameController.getObjectRecords(objectNames);

        System.assertNotEquals(null, records, 'Records should not be null');
    }

    @IsTest
    static void testSearchRecords() {

        List<String> objectNames = new List<String>{'Account', 'Contact'};
        String searchKeyword = 'Test';

        List<SObject> searchResults = ObjectNameController.searchRecords(objectNames, searchKeyword);

        System.assertNotEquals(null, searchResults, 'Search results should not be null');
    }
}

