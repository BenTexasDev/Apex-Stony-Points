public with sharing class NewInvoice {
    
    public Invoice__c invoice {get;set;}
    public Account account {get;set;}
    private Id aId;
    public Boolean hasAccount {get;set;}
    
    public NewInvoice(ApexPages.StandardController sc)
    {
        hasAccount = false;
        List<String> params = ApexPages.currentPage().getParameters().values();
        for (String p : params) {
            System.debug(p);
            if (p.startswith('001')) {
                //this is the one with the account id
                aid = p;
                system.debug(aid);
            }
        }
        
        if (aId != null) {
              loadAccount();
            invoice = (Invoice__c)sc.getRecord();
            invoice.Account__c = account.Id;
            hasAccount = true;
        }
    }
    
    public List<SelectOption> getContacts() {
        List<SelectOption> options = new List<SelectOption>();
        if (aid != null) {
            for (Contact c : [Select Id, Name from Contact Where AccountId = :aid]) {
                options.add(new SelectOption(c.Id,c.Name));
            }       
        }
        return options;
    }
    
    public PageReference saveNewInvoice() {     
        insert invoice;
        PageReference pr = new PageReference('/' + invoice.Id);
        return pr;
    }
    
    public PageReference cancel2() {        
        PageReference pr;
        pr = new PageReference('/');
        if (aid != null) {
            pr = new PageReference('/' + aid);
        }
        return pr;
    }
    
        
    private void loadAccount() {
        for(Account a : [Select Id, Name from Account Where Id = : aId]) {
            account = a;
        }
    }
    

    }