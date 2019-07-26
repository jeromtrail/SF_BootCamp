global class CreateAcc Implements Schedulable {
    
    global void execute(SchedulableContext sc) {
       list<Account> Acnlist = new list<Account>();
           
        for (Account act: [Select Id, Name, Is_Parent__c from Account where Is_Parent__c = true]) {
            
            for(Integer acnn=1; acnn<=5; acnn++ ) {
                Account lst = new Account();
                
                lst.Name = act.Name + '- Child' + acnn;
				lst.Parent_Account__c  = act.Id;
                
              	Acnlist.add(lst);
            }
            
        }
        Insert Acnlist;
        system.enqueueJob(new myFirstBatch(100000,300000));
    }
    
}