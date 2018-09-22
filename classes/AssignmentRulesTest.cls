@isTest
private class AssignmentRulesTest {

/*    @isTest static void accountAssignmentRuleCase() {
        Business_Logic_Settings__c BLS = new Business_Logic_Settings__c();
        BLS.Bypass_Account_Assignment_Rule__c = false;
        BLS.Bypass_Contact_Assignment_Rule__c = false;
        BLS.Bypass_Lead_Assignment_Rule__c = false;
        BLS.Bypass_Opportunity_Assignment_Rule__c = false;
        insert BLS;

        Account acc = new Account(Name = 'Test Account',
                                  Type = 'Reseller',
                                  Reseller_Renewal_Discount__c = 0,
                                  Managed_Account_Type__c = 'Maintenance',
                                  Support_Priority__c = 'Low',
                                  Net_Developers__c = 60);

        String assignMentRecordType = [Select Id from RecordType Where sObjectType='Assignment_Rule__c' AND DeveloperName='Assignment_Rule'].Id;
        
        insert rule;
        User u = getUser('6293');
        Test.startTest();
            System.runAs(u){
                insert acc;
            }
        Test.stopTest();
        Account a = [SELECT Id,OwnerId FROM Account Where Id=:acc.Id];
        System.assertNotEquals(u.Id,a.OwnerId,'Assingment rule to change the account owner failed');
    }

    @isTest static void accountAssignmentRuleCaseForUpdate() {
        Business_Logic_Settings__c BLS = new Business_Logic_Settings__c();
        BLS.Bypass_Account_Assignment_Rule__c = false;
        BLS.Bypass_Contact_Assignment_Rule__c = false;
        BLS.Bypass_Lead_Assignment_Rule__c = false;
        BLS.Bypass_Opportunity_Assignment_Rule__c = false;
        insert BLS;

        Account acc = new Account(Name = 'Test Account',
                                  Type = 'Reseller',
                                  Reseller_Renewal_Discount__c = 0,
                                  Managed_Account_Type__c = 'Maintenance',
                                  Support_Priority__c = 'Low',
                                  Net_Developers__c = 60);

        String assignMentRecordType = [Select Id from RecordType Where sObjectType='Assignment_Rule__c' AND DeveloperName='Assignment_Rule'].Id;
        Assignment_Rule__c rule = new Assignment_Rule__c(sObject_Name__c= 'Account',Order__c=1,User__c=UserInfo.getUserId(),RecordTypeId=assignMentRecordType,
                                                            Field_Name_1__c='Type',Operator_1__c=Utils.STR_EQUALS,Value_1__c='Reseller',
                                                            Field_Name_2__c='Managed_Account_Type__c',Operator_2__c=Utils.STR_INCLUDES,Value_2__c='Maintenance',
                                                            Field_Name_3__c='Managed_Account_Type__c',Operator_3__c=Utils.STR_EXCLUDES,Value_3__c='Test,Test2',
                                                            Field_Name_4__c='Support_Priority__c',Operator_4__c=Utils.STR_CONTAINS,Value_4__c='ow',
                                                            Field_Name_5__c='Support_Priority__c',Operator_5__c=Utils.STR_STARTS_WITH,Value_5__c='lo',
                                                            Field_Name_6__c='Managed_Account_Type__c',Operator_6__c=Utils.STR_DOES_NOT_CONTAINS,Value_6__c='lo',
                                                            Field_Name_7__c='Net_Developers__c',Operator_7__c=Utils.STR_INCLUDES,Value_7__c='30,60,70,33',
                                                            Field_Name_8__c='Net_Developers__c',Operator_8__c=Utils.STR_EXCLUDES,Value_8__c='30,70,33',
                                                            Field_Name_9__c='Net_Developers__c',Operator_9__c=Utils.STR_EQUALS,Value_9__c='60',
                                                            Field_Name_10__c='Net_Developers__c',Operator_10__c=Utils.STR_NOT_EQUALS_TO,Value_10__c='30'
                                                        );
        insert rule;
        User u1 = getUser('999'); insert u1;
        Assignment_Rule__c rule2 = new Assignment_Rule__c(sObject_Name__c= 'Account',Order__c=0,User__c=u1.Id,
                                                    Field_Name_1__c='Name',Operator_1__c=Utils.STR_EQUALS,Value_1__c='TestAccountUpdate',RecordTypeId=assignMentRecordType,
                                                    Field_Name_2__c='Managed_Account_Type__c',Operator_2__c=Utils.STR_INCLUDES,Value_2__c='Maintenance',
                                                    Field_Name_3__c='Managed_Account_Type__c',Operator_3__c=Utils.STR_EXCLUDES,Value_3__c='Test,Test2',
                                                    Field_Name_4__c='Support_Priority__c',Operator_4__c=Utils.STR_CONTAINS,Value_4__c='ow',
                                                    Field_Name_5__c='Support_Priority__c',Operator_5__c=Utils.STR_STARTS_WITH,Value_5__c='lo',
                                                    Field_Name_6__c='Managed_Account_Type__c',Operator_6__c=Utils.STR_DOES_NOT_CONTAINS,Value_6__c='lo',
                                                    Field_Name_7__c='Net_Developers__c',Operator_7__c=Utils.STR_INCLUDES,Value_7__c='30,60,70,33',
                                                    Field_Name_8__c='Net_Developers__c',Operator_8__c=Utils.STR_EXCLUDES,Value_8__c='30,70,33',
                                                    Field_Name_9__c='Net_Developers__c',Operator_9__c=Utils.STR_EQUALS,Value_9__c='60',
                                                    Field_Name_10__c='Net_Developers__c',Operator_10__c=Utils.STR_NOT_EQUALS_TO,Value_10__c='30'
                                                );

        insert rule2;
        User u = getUser('6293');
        Test.startTest();
            System.runAs(u){
                insert acc;
                Account a = [SELECT Id,OwnerId FROM Account Where Id=:acc.Id];
                System.assertEquals(u.Id,a.OwnerId,'Assingment rule to change the account owner failed');

                Account forUpdate = new Account(Id=acc.Id);
                forUpdate.Name = 'TestAccountUpdate';
                forUpdate.Run_Assignment_Rule__c = true;
                update forUpdate;
            }
        Test.stopTest();
        Account a2 = [SELECT Id,OwnerId FROM Account Where Id=:acc.Id];
        System.assertEquals(u1.Id,a2.OwnerId,'Assingment rule to change the account owner failed on update');
    }

    @isTest static void byPassAccountRuleCase() {
        //Test case to stop assignment rule runnig through custom settings
        Business_Logic_Settings__c BLS = new Business_Logic_Settings__c();
        BLS.Bypass_Account_Assignment_Rule__c = true;
        BLS.Bypass_Contact_Assignment_Rule__c = false;
        BLS.Bypass_Lead_Assignment_Rule__c = false;
        BLS.Bypass_Opportunity_Assignment_Rule__c = false;
        insert BLS;
        Account acc = new Account(Name = 'Test Account',
                                  Type = 'Reseller',
                                  Reseller_Renewal_Discount__c = 0);

        String assignMentRecordType = [Select Id from RecordType Where sObjectType='Assignment_Rule__c' AND DeveloperName='Assignment_Rule'].Id;
        Assignment_Rule__c rule = new Assignment_Rule__c(sObject_Name__c= 'Account',Order__c=0,User__c=UserInfo.getUserId(),RecordTypeId=assignMentRecordType,
                                                            Field_Name_1__c='Type',Operator_1__c=Utils.STR_EQUALS,Value_1__c='Reseller'
                                                        );
        insert rule;
        User u = getUser('6287');
        Test.startTest();
            System.runAs(u){
                insert acc;
            }
        Test.stopTest();
        Account a = [SELECT Id,OwnerId FROM Account Where Id=:acc.Id];
        System.assertEquals(u.Id,a.OwnerId,'Assignemnt rule bypass failed');
    }

    @isTest static void accountWithMultiRuleCase() {
        Business_Logic_Settings__c BLS = new Business_Logic_Settings__c();
        BLS.Bypass_Account_Assignment_Rule__c = false;
        BLS.Bypass_Contact_Assignment_Rule__c = false;
        BLS.Bypass_Lead_Assignment_Rule__c = false;
        BLS.Bypass_Opportunity_Assignment_Rule__c = false;
        insert BLS;
        Account acc = new Account(Name = 'Test Account',
                                  Type = 'Reseller',
                                  Reseller_Renewal_Discount__c = 0,
                                  Managed_Account_Type__c = 'Maintenance',
                                  Support_Priority__c = 'Low',
                                  Net_Developers__c = 60);

        String assignMentRecordType = [Select Id from RecordType Where sObjectType='Assignment_Rule__c' AND DeveloperName='Assignment_Rule'].Id;
        Assignment_Rule__c rule = new Assignment_Rule__c(sObject_Name__c= 'Account',Order__c=1,User__c=UserInfo.getUserId(),RecordTypeId=assignMentRecordType,
                                                            Field_Name_1__c='Type',Operator_1__c=Utils.STR_EQUALS,Value_1__c='Reseller',
                                                            Field_Name_2__c='Managed_Account_Type__c',Operator_2__c=Utils.STR_INCLUDES,Value_2__c='Maintenance,Growth',
                                                            Field_Name_3__c='Managed_Account_Type__c',Operator_3__c=Utils.STR_EXCLUDES,Value_3__c='Test,Test2',
                                                            Field_Name_4__c='Support_Priority__c',Operator_4__c=Utils.STR_CONTAINS,Value_4__c='ow',
                                                            Field_Name_5__c='Support_Priority__c',Operator_5__c=Utils.STR_STARTS_WITH,Value_5__c='lo',
                                                            Field_Name_6__c='Managed_Account_Type__c',Operator_6__c=Utils.STR_DOES_NOT_CONTAINS,Value_6__c='lo',
                                                            Field_Name_7__c='Net_Developers__c',Operator_7__c=Utils.STR_INCLUDES,Value_7__c='30,60,70,33',
                                                            Field_Name_8__c='Net_Developers__c',Operator_8__c=Utils.STR_EXCLUDES,Value_8__c='30,70,33',
                                                            Field_Name_9__c='Net_Developers__c',Operator_9__c=Utils.STR_EQUALS,Value_9__c='60',
                                                            Field_Name_10__c='Net_Developers__c',Operator_10__c=Utils.STR_NOT_EQUALS_TO,Value_10__c='30'
                                                        );
        insert rule;
        User u2 = getUser('6200');
        insert u2;
        Assignment_Rule__c rule2 = new Assignment_Rule__c(sObject_Name__c= 'Account',Order__c=0,User__c=u2.Id,RecordTypeId=assignMentRecordType,
                                                            Field_Name_1__c='Type',Operator_1__c=Utils.STR_EQUALS,Value_1__c='Reseller',
                                                            Field_Name_2__c='Net_Developers__c',Operator_2__c=Utils.STR_GREATER_THAN,Value_2__c='30'
                                                        );
        insert rule2;
        User u = getUser('6287');
        Test.startTest();
            System.runAs(u){
                insert acc;
            }
        Test.stopTest();
        Account a = [SELECT Id,OwnerId FROM Account Where Id=:acc.Id];
        System.assertEquals(u2.Id,a.OwnerId,'Multi Rule failed');
    }

    @isTest static void accountRuleWithFilters() {
        Business_Logic_Settings__c BLS = new Business_Logic_Settings__c();
        BLS.Bypass_Account_Assignment_Rule__c = false;
        BLS.Bypass_Contact_Assignment_Rule__c = false;
        BLS.Bypass_Lead_Assignment_Rule__c = false;
        BLS.Bypass_Opportunity_Assignment_Rule__c = false;
        insert BLS;
        //Test case with filters
        Account acc = new Account(Name = 'Test Account',
                                  Type = 'Reseller',
                                  Reseller_Renewal_Discount__c = 0,
                                  Managed_Account_Type__c = 'Maintenance',
                                  Support_Priority__c = 'Low',
                                  SQL_Developers_Net_Developers_SQL_S__c = 50,
                                  Net_Developers__c = 60,
                                  Account_Managed__c = true,
                                  SQL_Servers__c = 20);

        String assignMentRecordType = [Select Id from RecordType Where sObjectType='Assignment_Rule__c' AND DeveloperName='Assignment_Rule'].Id;
        Assignment_Rule__c rule = new Assignment_Rule__c(sObject_Name__c= 'Account',Order__c=0,User__c=UserInfo.getUserId(),Filter_Logic__c=' 1 And 2 AND ( ( ( 3 OR 4 ) OR (5 AND 6) ) OR 7 ) AND 8',
                                                            Field_Name_1__c='Type',Operator_1__c=Utils.STR_EQUALS,Value_1__c='Reseller',RecordTypeId=assignMentRecordType,
                                                            Field_Name_2__c='Managed_Account_Type__c',Operator_2__c=Utils.STR_EQUALS,Value_2__c='Maintenance',
                                                            Field_Name_3__c='Support_Priority__c',Operator_3__c=Utils.STR_EQUALS,Value_3__c='High',
                                                            Field_Name_4__c='SQL_Developers_Net_Developers_SQL_S__c',Operator_4__c=Utils.STR_GREATER_OR_EQUAL,Value_4__c='40',
                                                            Field_Name_5__c='Net_Developers__c',Operator_5__c=Utils.STR_LESS_THAN,Value_5__c='50',
                                                            Field_Name_6__c='Account_Managed__c',Operator_6__c=Utils.STR_EQUALS,Value_6__c='false',
                                                            Field_Name_7__c='SQL_Developers_Net_Developers_SQL_S__c',Operator_7__c=Utils.STR_LESS_OR_EQUAL,Value_7__c='100',
                                                            Field_Name_8__c='SQL_Servers__c',Operator_8__c=Utils.STR_STARTS_WITH,Value_8__c='20'
                                                        );
        insert rule;
        User u = getUser('6222');
        Test.startTest();
            System.runAs(u){
                insert acc;
            }
        Test.stopTest();
        Account a = [SELECT Id,OwnerId FROM Account Where Id=:acc.Id];
        System.assertNotEquals(u.Id,a.OwnerId,'Assingment rule to change the account owner failed');
    }

    @isTest static void accountRuleWithFiltersWithBrackets() {
        Business_Logic_Settings__c BLS = new Business_Logic_Settings__c();
        BLS.Bypass_Account_Assignment_Rule__c = false;
        BLS.Bypass_Contact_Assignment_Rule__c = false;
        BLS.Bypass_Lead_Assignment_Rule__c = false;
        BLS.Bypass_Opportunity_Assignment_Rule__c = false;
        insert BLS;
        //Test case with filters
        Account acc = new Account(Name = 'Test Account',
                                  Type = 'Reseller',
                                  Reseller_Renewal_Discount__c = 0,
                                  Managed_Account_Type__c = 'Growth',
                                  Support_Priority__c = 'High');

        String assignMentRecordType = [Select Id from RecordType Where sObjectType='Assignment_Rule__c' AND DeveloperName='Assignment_Rule'].Id;
        Assignment_Rule__c rule = new Assignment_Rule__c(sObject_Name__c= 'Account',Order__c=0,User__c=UserInfo.getUserId(),RecordTypeId=assignMentRecordType,
                                                            Field_Name_1__c='Type',Operator_1__c=Utils.STR_EQUALS,Value_1__c='Reseller',Filter_Logic__c=' 1 And ( 2 OR 3 )',
                                                            Field_Name_2__c='Managed_Account_Type__c',Operator_2__c=Utils.STR_EQUALS,Value_2__c='Maintenance',
                                                            Field_Name_3__c='Support_Priority__c',Operator_3__c=Utils.STR_EQUALS,Value_3__c='High'
                                                        );
        insert rule;
        User u = getUser('6200');
        Test.startTest();
            System.runAs(u){
                insert acc;
            }
        Test.stopTest();
        Account a = [SELECT Id,OwnerId FROM Account Where Id=:acc.Id];
        System.assertNotEquals(u.Id,a.OwnerId,'Assingment rule to change the account owner failed');
    }

    @isTest static void accountRuleWithUserGroups() {
        Business_Logic_Settings__c BLS = new Business_Logic_Settings__c();
        BLS.Bypass_Account_Assignment_Rule__c = false;
        BLS.Bypass_Contact_Assignment_Rule__c = false;
        BLS.Bypass_Lead_Assignment_Rule__c = false;
        BLS.Bypass_Opportunity_Assignment_Rule__c = false;
        insert BLS;
        //Test case with filters
        Account acc = new Account(Name = 'TestAccount',
                                  Type = 'Reseller',
                                  Reseller_Renewal_Discount__c = 0,
                                  Managed_Account_Type__c = 'Growth',
                                  Support_Priority__c = 'High');

        String assignMentRecordType = [Select Id from RecordType Where sObjectType='Assignment_Rule__c' AND DeveloperName='Assignment_Rule'].Id;
        Assignment_Rule__c rule = new Assignment_Rule__c(sObject_Name__c= 'Account',Order__c=0,Filter_Logic__c=' 1 And (2 OR 3)',User_Group__c='TestGroup',
                                                            Field_Name_1__c='Type',Operator_1__c=Utils.STR_EQUALS,Value_1__c='Reseller',RecordTypeId=assignMentRecordType,
                                                            Field_Name_2__c='Managed_Account_Type__c',Operator_2__c=Utils.STR_EQUALS,Value_2__c='Maintenance',
                                                            Field_Name_3__c='Support_Priority__c',Operator_3__c=Utils.STR_EQUALS,Value_3__c='High'
                                                        );
        insert rule;
        User u1 = getUser('6273');
        u1.User_Group__c='TestGroup';
        u1.Round_Robin_Priority__c = 1;
        insert u1;
        User u2 = getUser('6256');
        u2.User_Group__c='TestGroup';
        u2.Round_Robin_Priority__c = 2;
        insert u2;
        User u3 = getUser('6001');
        Test.startTest();
            System.runAs(u3){
                insert acc;
            }
        Test.stopTest();
        Account a = [SELECT Id,OwnerId FROM Account Where Id=:acc.Id];
        System.assertNotEquals(u3.Id,a.OwnerId,'Assingment rule to change the account owner failed for user Group');
        System.assertEquals(u1.Id,a.OwnerId,'Assingment rule to change the account owner failed for user Group');
    }

    @isTest static void accountRuleWithUserGroupsWithRoundRobbin() {
        Business_Logic_Settings__c BLS = new Business_Logic_Settings__c();
        BLS.Bypass_Account_Assignment_Rule__c = false;
        BLS.Bypass_Contact_Assignment_Rule__c = false;
        BLS.Bypass_Lead_Assignment_Rule__c = false;
        BLS.Bypass_Opportunity_Assignment_Rule__c = false;
        insert BLS;
        //Test case with filters
        Account acc1 = new Account(Name = 'Test Account 1',
                                   Type = 'Reseller',
                                   Reseller_Renewal_Discount__c = 0,
                                   Managed_Account_Type__c = 'Growth',
                                   Support_Priority__c = 'High');

        Account acc2 = new Account(Name = 'Test Account 2',
                                   Type = 'Reseller',
                                   Reseller_Renewal_Discount__c = 0,
                                   Managed_Account_Type__c = 'Growth',
                                   Support_Priority__c = 'High');

        String assignMentRecordType = [Select Id from RecordType Where sObjectType='Assignment_Rule__c' AND DeveloperName='Assignment_Rule'].Id;
        Assignment_Rule__c rule = new Assignment_Rule__c(sObject_Name__c= 'Account',Order__c=0,Filter_Logic__c=' 1 And (2 OR 3)',User_Group__c='TestGroup',
                                                            Field_Name_1__c='Type',Operator_1__c=Utils.STR_EQUALS,Value_1__c='Reseller',RecordTypeId=assignMentRecordType,
                                                            Field_Name_2__c='Managed_Account_Type__c',Operator_2__c=Utils.STR_EQUALS,Value_2__c='Maintenance',
                                                            Field_Name_3__c='Support_Priority__c',Operator_3__c=Utils.STR_EQUALS,Value_3__c='High'
                                                        );
        insert rule;
        User u1 = getUser('6273');
        u1.User_Group__c='TestGroup';
        u1.Round_Robin_Priority__c = 1;
        insert u1;
        User u2 = getUser('6256');
        u2.User_Group__c='TestGroup';
        u2.Round_Robin_Priority__c = 2;
        insert u2;
        User u3 = getUser('6001');
        Test.startTest();
            System.runAs(u3){
                insert acc1;
                insert acc2;
            }
        Test.stopTest();
        Account a = [SELECT Id,OwnerId FROM Account Where Id=:acc1.Id];
        System.assertNotEquals(u3.Id,a.OwnerId,'Assingment rule to change the account owner failed for user Group');
        System.assertEquals(u1.Id,a.OwnerId,'Assingment rule to change the account owner failed for user Group');

        a = [SELECT Id,OwnerId FROM Account Where Id=:acc2.Id];
        System.assertNotEquals(u3.Id,a.OwnerId,'Assingment rule to change the account owner failed for user Group');
        System.assertEquals(u2.Id,a.OwnerId,'Assingment rule to change the account owner failed for user Group');

        System.assertEquals(1,[Select Count() From Assignment_Rule__c Where User_Group__c='TestGroup' AND sObject_Name__c='Account' And RecordType.DeveloperName='Round_Robin'],'Creation of round robin record failed');
    }

    @isTest static void opportunityRuleWithContactOwner(){

        User u1 = getUser('user1');
        String assignMentRecordType = [Select Id from RecordType Where sObjectType='Assignment_Rule__c' AND DeveloperName='Assignment_Rule'].Id;
        Assignment_Rule__c rule = new Assignment_Rule__c(sObject_Name__c= 'Opportunity',Order__c=0,Filter_Logic__c=null,User_Group__c=null,
                                                            Field_Name_1__c='Name',Operator_1__c=Utils.STR_NOT_EQUALS_TO,Value_1__c='',RecordTypeId=assignMentRecordType,
                                                            Assign_To_Owner__c=Utils.ASSIGN_TO_CONTACT_OWNER
                                                        );
        insert rule;
        Contact con;
        User u2 = getUser('user2');

            //Account
            Account acc = new Account(Name='TestAccount');
            insert acc;
        System.runAs(u1){
            //Contact
            con = new Contact(LastName='ContactLastName',AccountId=acc.Id,Email='lastname@test.com',Status__c=Utils.CONTACT_STATUS_NOT_ENGAGED);
            insert con;
        }
            System.assertEquals(Utils.CONTACT_STATUS_NOT_ENGAGED,[SELECT Status__c FROM Contact WHERE Id=:con.Id].Status__c,'Contact status is incorrect for the test data');
            System.assertEquals(u1.Id,[SELECT OwnerId FROM Contact WHERE Id=:con.Id].OwnerId,'Contact OwnerId is incorrect for the test data');

        Test.startTest();

        System.runAs(u1) {

            Contact conToUpdate = new Contact(Id=con.Id);
            conToUpdate.Status__c = 'Engaged';
            conToUpdate.Opportunity_Source__c = 'Other';
            ContactTriggerHandler.afterUpdateTriggerExecuted = false;
            update conToUpdate;
        }

        Test.stopTest();
            System.assertEquals(u1.Id,[SELECT OwnerId FROM Contact WHERE Id=:con.Id].OwnerId,'Contact OwnerId is incorrect for the test data after running assignment rule');
            System.assertEquals(u1.Id,[SELECT OwnerId FROM Opportunity WHERE Contact__c=:con.Id].OwnerId,'Opportunity Owner is incorrect after assignment rule ran');
    }

    private static User getUser(String userName){
        User u = new User();
        u.ProfileId = [Select Id From Profile Where Name='Red Gate Generic User' Limit 1].Id;
        u.userName = userName+'@test.com.redgate';
        u.Alias = 'Test'+userName.substring(0,3);
        u.email=userName+'@test.com';
        u.emailencodingkey='UTF-8';
        u.lastname='12'+userName;
        u.languagelocalekey='en_US';
        u.localesidkey='en_US';
        u.timezonesidkey='America/Los_Angeles';
        return u;
    }*/
}