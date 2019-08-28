global class CreateInvoiceFromEmail implements Messaging.InboundEmailHandler {
	global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
		  
		  Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();		  
		  List<String> values = email.plainTextBody.split(';');
		  Invoice__c i = new Invoice__c();
		  i.Account__c = values[0];
		  i.Opportunity__c = values[1];
		  i.Amount__c = Double.valueOf(values[2]);
		  insert i;		  
	      return result;
	}
}