trigger createInvoiceFromOpportunity on Opportunity (after insert, after update) {
    //Need to handle multiple invoices
    List <Invoice__c> invoices = new List <Invoice__c>();
    //Creates an invoice when somthing is closed.
    for(Opportunity o : trigger.new){
        //Just being changed to a ClosedWon status
        if(o.IsWon && (trigger.isInsert || trigger.oldMap.get(o.Id).IsWon == false)) {
            Invoice__c i = new Invoice__c();
            i.Opportunity__c = o.Id;
            if(o.Amount == null)
            {
                i.Amount__c = 0;
            }else
            {
                i.Amount__c = o.Amount;
            }
            i.Amount__c = o.Amount;
            i.Account__c = o.AccountId;
            i.Due_Date__c = o.CloseDate + 30;
            invoices.add(i);
        }

    Database.insert(invoices,false);
    }

}