global with sharing class SOAP_Invoices {

	webservice static List<Invoice__c> GetInvoices(Id AccountId) {
        //Return a list of invoices based on the account ID
        List<Invoice__c> invoices = new List<Invoice__c>();
        for(Invoice__c i : [SELECT Id, Name, Amount__c, Due_Date__c, Balance__c, Status__c 
        	FROM Invoice__c WHERE Account__c = :AccountId]) {
        		invoices.add(i);
        	}
        return invoices;//return invoices
        //Need to generate the WSDL for the class since its SOAP
    }  
}