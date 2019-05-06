@isTest

public Class GenerateConAccJunctionTriggerHelperTest{

    @testSetup static void setupCommonData(){
     //Fetch System Admin Profile Id
        string profileId = [SELECT Id,Name FROM Profile WHERE Name =: 'System Administrator' limit 1].id;
        system.assertNotEquals(profileId, null);
        
        //Inserting User
        User userObj = TestDataFactory.InsertUser(profileId);
        insert userObj;
        system.assertEquals(userObj.id, [select id,Name from User where LastName =: 'User Last Name'].Id);
        
        // inserting Account with Record Type Person Account
        Account accObj = TestDataFactory.InsertAccount();
        insert accObj;
        system.assertEquals(accObj.Name, [select id,Name from Account where id =: accObj.Id].Name);
        
        //Inserting Contact
        Contact contObj = TestDataFactory.InsertTalent(accObj);
        insert contObj;
        
        //Inserting ContactAccount
        ContactAccount__c contAcct = TestDataFactory.insertContactAccount(accObj,contObj);
            
            insert contAcct;  
    }
      static testMethod void createAccountContactTest()
      {

      list<Contact > cont=[ Select id, AccountId,Name,RecordTypeId from Contact where Name=:'Test Talent' Limit 1];
         Test.startTest();
              GenerateNewConAccJunctionTriggerHelper.createAccountContact(cont);
          Test.stopTest();
          
      }

}