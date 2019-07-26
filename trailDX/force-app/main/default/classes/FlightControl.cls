public with sharing class FlightControl {
    
    @AuraEnabled        
	public static List<String> getPickListValuesIntoList(String objectType, String selectedField){
            List<String> pickListValuesList = new List<String>();
            Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get(objectType);
            Schema.DescribeSObjectResult res = convertToObj.getDescribe();
            Schema.DescribeFieldResult fieldResult = res.fields.getMap().get(selectedField).getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            for( Schema.PicklistEntry pickListVal : ple){
                pickListValuesList.add(pickListVal.getLabel());
            }
        	system.debug('pickListValuesList ' + pickListValuesList.size());
            return pickListValuesList;
	}
    
    @AuraEnabled        
	public static List<String> getPickListValuesIntoList2(String objectType2, String selectedField2){
            List<String> pickListValuesList2 = new List<String>();
            Schema.SObjectType convertToObj2 = Schema.getGlobalDescribe().get(objectType2);
            Schema.DescribeSObjectResult res2 = convertToObj2.getDescribe();
            Schema.DescribeFieldResult fieldResult2 = res2.fields.getMap().get(selectedField2).getDescribe();
            List<Schema.PicklistEntry> ple2 = fieldResult2.getPicklistValues();
            for( Schema.PicklistEntry pickListVal2 : ple2){
                pickListValuesList2.add(pickListVal2.getLabel());
            }
        	system.debug('pickListValuesList2 ' + pickListValuesList2.size());
            return pickListValuesList2;
	}
    
     @AuraEnabled
   	public static List<Flight__c> showSelected(string selectid) {
    List<Flight__c> donList = new List<Flight__c>();
   	return [select Id, Name, Depart_From__c, Depart_Arrive__c, Departure_Date__c from Flight__c where Id=: selectid];

		
    }
    
    @AuraEnabled
   	public static List<Flight__c> searchFlight(String origin, String destination, Date desti) {
    
   	return [select Id, Name, Departure_TIme__c, Depart_Arrive__c, Depart_From__c, Arrival_Time__c, Available_Seats__c, Departure_Date__c, Fly_Baggage__c, Fly_Baggage_Meal__c, Fly_Only__c from Flight__c where Depart_To__c=: destination AND Depart_From__c=: origin AND Departure_Date__c=: desti];

		
    }
    
    @AuraEnabled
    public static String searchContact(String fName, String lName, String email, Id flightId){
      
     //   List<Booking__c> bkList = [SELECT Id FROM Booking__c WHERE Flight__c =: flightId AND Contact__c =: cn[0].Id];
      //  Booking__c bk = new Booking__c();
     //   if(cn.isEmpty()){
      //      Contact newCont = new Contact();
      //      newCont.FirstName = fName;
      //      newCont.LastName = lName;
//            newCont.Email = email;
            
       //     insert newCont;
       //     
      //      bk.Contact__c = newCont.Id;
      //      bk.Flight__c = flightId;
      //      bk.Email__c = email;
            //bk.Package__c = Flight__r.Package__c;
            
            
      //  }else{
            
        
     //       bk.Contact__c = cn[0].Id;
     //       bk.Flight__c = flightId;
     //       bk.Email__c = email;
            //bk.Package__c = Flight__r.Package__c;
            
     //   }
        
//        if(bkList.isEmpty()){
      //      insert bk;
      //      bookingId = bk.Id;
     //   }else{
      //      throw new AuraHandledException('You already booked a flight!');
     //   }
        //test
    	String bookingId = '';
 		
        List<Contact> cn = [select id, Name, Email from Contact where Email =: email];
        Booking__c bookingObj = new Booking__c();
           if (cn.isEmpty()){
            Contact newCont = new Contact();
            newCont.FirstName = fName;
            newCont.LastName = lName;
            newCont.Email = email;
            cn.add(newCont);
            insert cn;
            
            Flight__c flightObj = [SELECT Id, Name FROM Flight__c WHERE Id =: flightId];
            
            bookingObj.Flight__c = flightObj.Id;
            bookingObj.Contact__c = newCont.Id;
            try{
                insert bookingObj;
                bookingId = bookingObj.Id;
            	bookingObj.Email__c = email;
            }
            catch(Exception exc){
                throw new AuraHandledException(exc.getMessage());
            }
          return bookingId;
        }
        else{
            Contact contact = [SELECT Id, Name, FirstName, LastName, Email FROM Contact WHERE Email =: email];
            if (contact.FirstName != fName || contact.LastName != lName){
                contact.FirstName = fName;
                contact.LastName = lName;
                update contact;
            }           
            Flight__c flightObj = [SELECT Id, Name FROM Flight__c WHERE Id =: flightId];
          //  Booking__c bookingObj = new Booking__c();
            bookingObj.Flight__c = flightObj.Id;
            bookingObj.Contact__c = contact.Id;         
            try{
                insert bookingObj;
                bookingId = bookingObj.Id;
                 bookingObj.Email__c = email;
               sendEmail(bookingId, bookingObj.Email__c);
            }
            catch(Exception exc){
                throw new AuraHandledException(exc.getMessage());
            }
            return bookingId;
        }        
        
        
        
       // sendEmail(bk.Id, bk.Email__c);
        
      //  return bookingId;
    }
    
    @future(callout=true)
    public static void sendEmail(String bkId, String bkEmail){
        Messaging.SingleEmailMessage emailSend = new Messaging.SingleEmailMessage();
        string[] to = new string[] {bkEmail};
        
        emailSend.setToAddresses(to);
        emailSend.setSubject('Booking Reference');
        
        emailSend.setHtmlBody('Hello, <br/><br/>This is to inform you about your booking with Deloitte Airline. <br/><br/>Regards<br/> Admin');
        PageReference pdf = Page.Booking;
        pdf.getParameters().put('id', bkId);

        Attachment attach = new Attachment();
        attach.ParentId = bkId;
        attach.name = 'Booking.pdf';
        attach.body = pdf.getContent();
        insert attach;
        
        Messaging.EmailFileAttachment emailAtt = new Messaging.EmailFileAttachment();
        emailAtt.setFileName(attach.Name);
      	emailAtt.setBody(attach.Body);
        emailSend.setFileAttachments( new List<Messaging.EmailFileAttachment> {emailAtt});
        
        try{
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { emailSend });
        }catch(exception e){
            apexpages.addmessage(new apexpages.message(apexpages.severity.error,e.getMessage()));
        }
    }
    
}