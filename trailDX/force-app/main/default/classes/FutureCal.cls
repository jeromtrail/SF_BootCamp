public class FutureCal { 
 
    @future
	public static void FutureCall() {
    list<Account> Acnlist = new list<Account>();
    
        
        Acnlist = [select Id, Name, Total_Budget__c from Account where Total_Budget__c > 1000000];
    
        String messageBody = '<table border = "1" style="border-collapse:collapse;"border-collapse:collapse;"><tr><th>Account Name</th><th>Total Budget</th></tr>';
    	
        for(Account acc: Acnlist)  {
            
            messageBody+='<tr><td>'+acc.Name+'</td><td>'+acc.Total_Budget__c+'</td></tr>';
        } 
            
    	messagebody+='</table>';
    
    	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {'jgonzaga@deloitte.com'});
    	mail.setSubject ('NOy : Account Budget');
    	mail.setHtmlBody(messageBody);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        }
        
}