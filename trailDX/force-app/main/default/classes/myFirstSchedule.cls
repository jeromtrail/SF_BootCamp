global class myFirstSchedule Implements Schedulable {
    
    global void execute(SchedulableContext sc) {
        System.Debug(UserInfo.getUserName());
    }
    
}