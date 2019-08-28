trigger consolidatedOpptyTigger on Opportunity (before insert,before update, after insert, after update) 
{
       if (trigger.isAfter){
        //Create new invoices
        List<Opportunity> workOpp = new List<Opportunity>();
        for (Opportunity o : trigger.new) {
            if(o.IsWon && (trigger.isInsert || trigger.oldMap.get(o.Id).IsWon == false)){
                workOpp.add(o);
            }
            if (!workOpp.isEmpty()){
                consolidatedOpptyTrigger.createInvoiceFromOpportunity(workOpp);
            }
        }
    }
    
      if (trigger.isBefore){
          //Update opportunity name
           consolidatedOpptyTrigger.updateOpportunityName(trigger.new);
      }
    
    
        
}