public without sharing class LeadController {

	public String Request {get;set;}
	
	public PageReference saveLead() {
		Lead l = new Lead();
		l.FirstName = ApexPages.currentPage().getParameters().get('FName');
		l.LastName = ApexPages.currentPage().getParameters().get('LName');
		l.Email = ApexPages.currentPage().getParameters().get('Email');
		l.Company = ApexPages.currentPage().getParameters().get('Company');
		insert l;
		Request = ApexPages.currentPage().getParameters() + '';
		return null;
	}
	
}