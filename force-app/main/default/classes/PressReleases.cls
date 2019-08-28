public with sharing class PressReleases {

	public List<Press_Release__c> Releases {
		get {
			if (Releases == null) {
				getReleases();
			}
			return Releases;
		}
		set;
	}
	
	private void getReleases() {
		
		Releases = new List<Press_Release__c>();
		for (Press_Release__c pr : [Select p.Publish__c, p.Publish_Date__c, p.Name, p.Id 
			From Press_Release__c p 
			where publish__c = true and publish_date__c <= today
			order by Publish_Date__c desc]) {
			releases.add(pr);	
		}
	}
}