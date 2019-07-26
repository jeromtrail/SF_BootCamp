public with sharing class DonataControl {
  
    
 	@AuraEnabled
    public static void setDonate(Donation__c dn) {
      //  List<Donation__c> donList;
      //  donList = [select Id, Donor_Name__c, Donation_Date__c, 	Amount__c, 	Note__c from Donation__c];

         insert dn;
        //return donList;
    }
    
    
    @AuraEnabled
    public static List<Donation__c> getTop5() {
       List<Donation__c> donList = new List<Donation__c>();
   	  return [select Id, Donor_Name__c, Donation_Date__c, Amount__c, Note__c from Donation__c ORDER BY Amount__c DESC Limit 5];

		
    }
    
      @AuraEnabled
    public void getSummary() {
       
   	  AggregateResult[] TotAmnt = [select sum(Amount__c)totalsm from Donation__c];

		
    }
    
 
 
}