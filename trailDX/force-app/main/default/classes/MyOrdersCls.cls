public class MyOrdersCls {
    public String OrderNum { get; set; }
    Public Integer size{get;set;} 
    Public Integer noOfRecords{get; set;} 
    public List<SelectOption> paginationSizeOptions{get;set;}
    
    public List<Order> orderList;
   
    public MyOrdersCls() {
        orderList = [select Id, OrderNumber, Account.Name, CreatedDate, Status from Order LIMIT 200];
        setOrd = new ApexPages.StandardSetController(orderList);
    }
    
    public void OrderPaginationController(){
        size=7;
        paginationSizeOptions = new List<SelectOption>();
        paginationSizeOptions.add(new SelectOption('5','5'));
        paginationSizeOptions.add(new SelectOption('10','10'));
        paginationSizeOptions.add(new SelectOption('20','20'));
        paginationSizeOptions.add(new SelectOption('50','50'));
        paginationSizeOptions.add(new SelectOption('100','100'));
    }
    
    public ApexPages.StandardSetController setOrd {
        get {
            if(setOrd == null) {                
                setOrd = new ApexPages.StandardSetController(orderList);
            }            
            setOrd.setPageSize(7);
            return setOrd;
        }
        set;
    }
	    
    public List<Order> getOrderList () {
         return (List<Order>) setOrd.getRecords();
    }
    
        
    public PageReference refreshPageSize() {
         setOrd.setPageSize(size);
         return null;
    }
    
    public PageReference searchOrders(){
		String 	OrderSearch = '%' + OrderNum + '%';
		
        orderList = [select Id, OrderNumber, Account.Name, CreatedDate, Status from Order where OrderNumber like :OrderSearch];
		setOrd = new ApexPages.StandardSetController(orderList);
        
        return null;
    }

   
    
}