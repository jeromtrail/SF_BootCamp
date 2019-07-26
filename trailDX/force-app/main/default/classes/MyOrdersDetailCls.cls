public class MyOrdersDetailCls {
public Order orderList {get; set;}    
public List<OrderItem> orderProdList {get; set;}
public Product2 ProductList {get; set;}
    public string ProductId {get; set;}
    
    public MyOrdersDetailCls(ApexPages.StandardController stdController) {
    	Id orderId = stdController.getId();
        orderList = [select Id, OrderNumber, Account.Name, TotalAmount, Status from Order where Id = :orderId];
        orderProdList = [select Id,UnitPrice,Product2.Name, Product2.Description from OrderItem where OrderId = :orderList.Id];

    }
    
    public MyOrdersDetailCls getProdDetails(){
        ProductList = [select Id, Name, Description from Product2 where Id = :ProductId];
        
        return null;
    }
    
    
    public PageReference Prodsave(){
        Update ProductList;
	
        return null;
    }
    
    
}