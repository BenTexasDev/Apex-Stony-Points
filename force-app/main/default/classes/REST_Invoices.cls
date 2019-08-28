@RestResource(urlMapping='/Invoices/*')	
global with sharing class REST_Invoices {

    @HttpGet
    global static List<Invoice__c> doGet() {
        RestRequest req = RestContext.request;
        String AccountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        List<Invoice__c> invoices = new List<Invoice__c>();
        for(Invoice__c i : [SELECT Id, Name, Amount__c, Account__r.Name, Opportunity__r.Name 
        	FROM Invoice__c WHERE Account__c = :AccountId]) {
        		invoices.add(i);
        	}
        return invoices;
    }  
}