public with sharing class MyComponentController {

    @AuraEnabled
    public static List<Account> getAccounts() {
        return [select Name from Account];
    }
}