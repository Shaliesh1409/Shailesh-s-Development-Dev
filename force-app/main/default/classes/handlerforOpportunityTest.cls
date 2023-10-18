@isTest
public class handlerforOpportunityTest {

    @TestSetup static void set(){
        List<Opportunity> opportunitiestoInsert = new List<Opportunity>();
        for(Integer i=0; i<2 ; i++){
            String opname = 'shailesh'+i;
            String opstage = 'Prospecting';
            Date close = Date.today().addDays(15);
            String OwnId = '0055j000009UwtMAAS';
            Opportunity opp = new Opportunity(Name=opname, StageName=opstage,CloseDate=close,OwnerId=OwnId);

            opportunitiestoInsert.add(opp);
        } 
        Test.startTest();
        insert opportunitiestoInsert;
        Test.stopTest();

    }

      
    static testMethod void stagetest(){

        Test.startTest();
      
        List<Opportunity> testOpportunities = [SELECT Id,StageName,CloseDate,Type FROM Opportunity LIMIT 2];
    //     handlerforopportunity myhandler = new handlerforopportunity(testOpportunities);
    //     myhandler.stage();
    //    handlerforopportunity myhandler = new handlerforopportunity();
    //     List<Opportunity> updatedOpportunities= myhandler.stage( testOpportunities);
    //     myhandler.stage(testOpportunities); 
        for(Opportunity opps : testOpportunities){
            System.assertEquals('New Customer',opps.Type,'type sahould be new customer');
            System.assertEquals('Prospecting',opps.StageName ,'stage should be prospecting');
            System.assertEquals(Date.today().addDays(15),opps.CloseDate,'close date sahould be 5 days');

        }
        Test.stopTest();
    }
    
    static testMethod void Typetest(){
        Test.startTest();
      
        List<Opportunity> testOpportunities = [SELECT Id,StageName,CloseDate,Type FROM Opportunity LIMIT 2];
        for(Opportunity opps : testOpportunities){
            System.assertEquals('New Customer',opps.Type,'type sahould be new customer');
        }
        Test.stopTest();
    }
    
    static testMethod void Tasktest(){
        Test.startTest();
        List<Opportunity> testOpportunitiestoupdate = [SELECT Id,Name FROM Opportunity WHERE Name LIKE 'shailesh%' LIMIT 2];
        for( Opportunity opps : testOpportunitiestoupdate ){
            opps.name = 'updated' + opps.name;
        }
        update testOpportunitiestoupdate;
        List <Task> createdtasks = [SELECT Subject,Description,Status,Priority,OwnerId,WhatId FROM Task];
        System.assertEquals(2,createdtasks.size());
        for(Task task : createdtasks){
        System.assertEquals('Opportunity Name Update',task.Subject);
        System.assertEquals('The name of the Opportunity has been modified.', task.Description);
        System.assertEquals('Not Started', task.Status);
        System.assertEquals('Normal', task.Priority);
        System.assertEquals('0055j000009UwtMAAS', task.OwnerId);
        }
    }

    }