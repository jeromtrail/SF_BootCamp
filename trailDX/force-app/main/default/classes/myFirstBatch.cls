global class myFirstBatch Implements Database.Batchable<SObject> {
   Double min;
   double max;
    
    public myFirstBatch (Decimal min, Decimal max){
         this.min = min;
         this.max = max;

    }    
    
        global Database.QueryLocator start(Database.BatchableContext bc) {
       return Database.getQueryLocator ('select Id, Budget__c,(select Id, Budget__c from Accounts__r) from Account where Is_Parent__c = True');
 
       }
        
        
        global void execute(Database.BatchableContext bc, list<Account> result) {
		list<Account> Acnbudlist = new list<Account>();
            
            for (Account pr: result){
			  pr.Budget__c = (Math.random()*(max-min))+min; 
                Acnbudlist.add(pr);
                
                for (Account ca: pr.Accounts__r) {
                    ca.Budget__c = (Math.random()*(max-min))+min;
                    
                 Acnbudlist.add(ca);   
                }
            }
             Update Acnbudlist; 
                
        }
    
        global void finish(Database.BatchableContext bc) {
           
            system.enqueueJob(new myQueueablTotalBdg());
        }
            
        
    }