public class InvoicesController {

    private Id oid;
    private Opportunity o;
    
    
    public InvoicesController(ApexPages.StandardSetController ssc) {
        List<Invoice__c> invoices = (List<Invoice__c>)ssc.getRecords();
        oid = ApexPages.currentPage().getParameters().get('id');
        loadOpportunity();

    }

  private void loadOpportunity() {
        o = [Select AccountId from Opportunity where Id = :oid];
    }
     public List<Invoice__c> newinvoices {
        get{
            if (newinvoices == null) {
                newinvoices = new List<Invoice__c>();
                for(integer i = 0;i<12; i++) {
                    Invoice__c inv = new Invoice__c();
                    inv.Opportunity__c = oid;
                    inv.Account__c = o.AccountId;
                    newinvoices.add(inv);
                }
            }
            return newinvoices;
        }
        set{}
    }

    

    public PageReference save() {
    //loop through the list of invoices and only save the invoices that have an amount
    List<Invoice__c> invoicesToCreate = new List<Invoice__c>();
        if (newinvoices != null && newinvoices.isempty() == false) { 
            for (Invoice__c inv : newinvoices) {
                if (inv.Amount__c > 0) {
                    invoicesToCreate.add(inv);
                }
            }
            insert invoicesToCreate;        
        }
        if (existinginvoices != null && existinginvoices.isempty() == false) {
            update existinginvoices;        
        }      
        PageReference pr = new PageReference('/' + oid);
        return pr;
    }
    public List<Invoice__c> existinginvoices {
        get{
            if (existinginvoices == null) {
                existinginvoices = o.Invoices__r;
            }
            return existinginvoices;
        }
        set{}
    }

    public PageReference cancel() {
        PageReference pr = new PageReference('/' + oid);
        return pr;
    }
}