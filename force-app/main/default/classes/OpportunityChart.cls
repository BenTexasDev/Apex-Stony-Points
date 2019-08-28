public with sharing class OpportunityChart {
	
	private Date beginDate,endDate;
	
	public String year {
		get {
			if (year == null) {
				year = Date.today().year() + '';
			}
			return year;
		}
		set {
			year = value;
			beginDate = Date.valueOf(year + '-01-01');
			endDate = Date.valueOf(year + '-12-31');
			
		}
	}
	
	public OpportunityChart() {
		year = Date.today().year() + '';
		getListData();
	}
	
	public PageReference reload() {
		getListData();
		return null;
	}
	
	private void getListData() {
		System.Debug('getting list data: year = ' + year);
		ChartData cd;
		List<ChartData> cds = new List<ChartData>();
		for (AggregateResult ar : [SELECT StageName, SUM(Amount) total 
			FROM Opportunity 
			Where CloseDate >= :beginDate AND CloseDate <= :endDate
			GROUP BY StageName]) {
			cd = new ChartData();
			cd.name = (String)ar.get('StageName');
			if ((Decimal)ar.get('total') == null) {
    			cd.value = 0;
			} else {
				cd.value = (Decimal)ar.get('total');
			}
    		System.debug(cd);
    		cds.add(cd);
		}
		chartValues = cds;
	}
	
	public List<ChartData> chartValues {get;set;}
	
	public List<SelectOption> getYears() {
 	 	Date high,low;
 	 	List<SelectOption> options = new List<SelectOption>();
 	 	for (AggregateResult ar : [Select max(closedate) Max, min(closeDate) Min from Opportunity]) {
	 		low = (Date)ar.get('Min');
	 		high = (Date)ar.get('Max');
 	 	} 	 	
 	 	for (integer i = low.year(); i <= high.year();i++) {
 	 		options.add(new SelectOption(i + '',i + ''));
 	 	}
 	 	return options;
  	}
  	
  	// Wrapper class
    public class ChartData {
        public String name { get; set; }
        public Decimal value { get; set; }
    }
  	
}