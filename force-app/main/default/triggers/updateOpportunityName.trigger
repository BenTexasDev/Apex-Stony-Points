trigger updateOpportunityName on Opportunity (before insert, before update) {

    Set<ID> aID = new Set<ID>();
    for (Opportunity o : trigger.new){
        aID.add(o.AccountID);
    }
    //key, value
    Map<ID,String> accName = new Map <ID, String>();
        for (Account a : [SELECT Name FROM Account WHERE ID IN :aID]){
            accName.put(a.ID,a.Name);
        }

    for (Opportunity o : trigger.new){
        o.Name = accName.get(o.AccountId) + ' - ' + o.Type + ' - ' + o.CloseDate.year() + ' / ' + o.CloseDate.month();
    }

}