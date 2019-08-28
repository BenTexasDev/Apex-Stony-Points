@isTest
private class TestconsolidatedOpptyTrigger {

        static testMethod void myUnitTest() {
            
          Account a = new Account();
          a.Name = 'Test';
          insert a;
          
        Contact c = new Contact();
        c.LastName = 'Test';
        c.AccountId = a.Id;
        insert c;
          
            Test.startTest();
        Opportunity o = new Opportunity();
        o.AccountId = a.Id;
        o.StageName = 'Prospecting';
        o.Amount = 10;
        o.CloseDate = Date.Today() + 7;
        o.Name = 'x';
        o.Type = 'Test';
        insert o;
        System.Debug(o.Name);
        
        Opportunity changedOppty = [SELECT Name FROM Opportunity WHERE ID=:o.ID];
        
        System.Debug(changedOppty.Name);
            
        System.assert(changedOppty.Name == 'Test - Test - ' 
      + o.CloseDate.month()  + '/' +o.CloseDate.year() , 'Bad Opp Name');
            
        o.StageName = 'Closed Won';
        update o;
            
        Test.stopTest();
        }
    
}