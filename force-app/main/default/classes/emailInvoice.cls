public class emailInvoice {

    public Invoice__c invoice {get;set;}
 
 public emailInvoice(ApexPages.StandardController stdController) {
        invoice = (Invoice__c)stdController.getRecord(); 
       loadInvoice();
 }
 
 private void loadInvoice() {
  invoice = [Select Id, Account__c, Opportunity__c, Billing_Contact__c, Name from Invoice__c Where Id = :invoice.id];
 }

 public PageReference EmailInvoice() {
  Email__c e = new Email__c();
  e.Invoice__c = invoice.id;
  e.Account__c = invoice.Account__c;
  e.Contact__c = invoice.Billing_Contact__c;
  e.Opportunity__c = invoice.Opportunity__c;
  insert e;
     PageReference pr = new PageReference('/' + invoice.Id);
     return pr;
 }
}