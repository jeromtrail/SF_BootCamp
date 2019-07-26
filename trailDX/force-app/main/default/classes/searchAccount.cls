public class searchAccount {

    public List<Account> accountList { get; set; }
    public String name { get; set; }
   

    public searchAccount() {
		
       	name='';
        accountList = new List<Account>();
    }

    public PageReference searchAccount(){
		String AccountName = '%' + name + '%';
        accountList = [select Id, Name, Description from Account where name like :AccountName];
		
        
        return null;

    }

}