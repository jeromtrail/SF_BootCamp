public class myQueueablTotalBdg implements Queueable {
	list<Account> Acnlist = new list<Account>();
    list<Account> Acnreclist = new list<Account>();
    
    public void execute(QueueableContext qc) {
        
       Acnlist = [select Id, Budget__c,(select Id, Budget__c, Total_Budget__c from Accounts__r) from Account where Is_Parent__c = True];
    	
          for (Account pr: Acnlist){
				pr.Total_Budget__c = pr.Budget__c;
              	
               Acnreclist.add(pr);
              
                for (Account ca: pr.Accounts__r) {
              	pr.Total_Budget__c += ca.Budget__c;
                 Acnreclist.add(pr);   
                }
            }
             Update Acnreclist; 
        	FutureCal.FutureCall();
        
    }
}