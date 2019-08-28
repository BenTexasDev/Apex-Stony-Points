global class UpdateOpportunitiesBatch implements Database.batchable<sObject> {
  
    global Database.QueryLocator start(Database.BatchableContext BC){
       return Database.getQueryLocator('Select Id from Opportunity');
    }

    global void execute(Database.BatchableContext BC, List<Opportunity> scope){
       database.update(scope,false);
    }

    global void finish(Database.BatchableContext BC){
    } 

}