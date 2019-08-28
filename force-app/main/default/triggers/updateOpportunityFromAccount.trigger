trigger updateOpportunityFromAccount on Account (after update) 
{
    //loop through the accounts and see if the name changed
    Set<Id> aIds = new Set<Id>();
    for (Account a : trigger.new) {
        Account oldAccount = trigger.oldMap.get(a.Id);
        if (a.Name != oldAccount.Name) {
            //the name changed so put the account id in a set
            aIds.add(a.Id);
        }
    }
    
        if(!aIds.isEmpty()) {
        List<Opportunity> opps = new List<Opportunity>();
        //we have name changes, so go get the related opportunities
        for (Opportunity o : [Select Id from Opportunity where AccountId 
     in :aIds]) {
          opps.add(o);  
        }
        Database.update(opps,false);
    }

}