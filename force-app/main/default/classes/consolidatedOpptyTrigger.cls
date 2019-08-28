public  without sharing class consolidatedOpptyTrigger {
    @invocableMethod
    public static void updateOpportunityName(List<Opportunity> opptys){
     
        Set<ID> aID = new Set<ID>();
 
        for (Opportunity o : opptys){
          aID.add(o.AccountID); 
         }

  Map<ID,String> accName = new Map<ID,String>();    
     for (Account a : [SELECT Name FROM Account WHERE ID IN :aID]){
         accName.put(a.ID,a.Name);
     }    
for (Opportunity o : opptys){   
  o.Name = accName.get(o.AccountId) + ' - ' + o.Type + ' - ' + o.CloseDate.year()
            + '/' + o.CloseDate.month();
    } 
    }
    
   public static void createInvoiceFromOpportunity(List<Opportunity> opptys){ 
  
       List<Invoice__c> invoices = new List<Invoice__c>();

       for (Opportunity o:opptys) {
            Invoice__c i = new Invoice__c();
   i.Opportunity__c = o.Id;
            if (o.Amount == null){ i.Amount__c = 0;}
            else {
                i.Amount__c = o.Amount;
            }
   i.Account__c = o.AccountId;
   i.Due_Date__c = o.CloseDate + 30;
   invoices.add(i);
        }
  
    Database.insert(invoices,false);
    }

}