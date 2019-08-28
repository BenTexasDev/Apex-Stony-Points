trigger setInvoiceSharing on Invoice__c (after insert, after update) {
    
     List<Invoice__Share> shares = new List<Invoice__Share>();
    
     Set<Id> OpportunityIds = new Set<Id>();
     Map<Id,Id> mapOpportunityOwners = new Map<Id,Id>();
     Id SVP; //to store the ID of the SVP Customer Service role
    
     for (Invoice__c i : trigger.new) {
        OpportunityIds.add(i.Opportunity__c);
  }
    
 //We need to get the opportunity owner for the invoice and put it in a map
     for(Opportunity o : [Select Id, OwnerId From Opportunity Where Id in :OpportunityIds]) {
        mapOpportunityOwners.put(o.Id, o.OwnerId);
  }
 //We need to get the GroupId for the SVP of Customer Service
     for(Group g : [Select g.Id, g.DeveloperName From Group g Where DeveloperName like 'SVPCustomerService%']) {
        SVP = g.Id;
  }
    
     //Now loop through the invoices again and create the sharing records for the owners
     for (Invoice__c i : trigger.new) {
        Invoice__Share is = new Invoice__Share();
        is.ParentId = i.Id;
        is.AccessLevel = 'Edit';
        is.RowCause = Schema.Invoice__Share.RowCause.Opportunity_Owner__c;
        is.UserOrGroupId = mapOpportunityOwners.get(i.Opportunity__c);
        shares.add(is);
  //Add another share for the SVP, Customer Service
        is = new Invoice__Share();
        is.ParentId = i.Id;
        is.AccessLevel = 'Edit';
        is.RowCause = Schema.Invoice__Share.RowCause.Customer_Service__c;
        is.UserOrGroupId = SVP;
        shares.add(is);
 }

  List<Database.Saveresult> srs = Database.insert(shares);
     for(Database.SaveResult sr:srs){
        if(!sr.isSuccess()){
        for(Database.Error e : sr.getErrors()) {
            System.Debug(e.getMessage());
    }
     
 } 
 }
}