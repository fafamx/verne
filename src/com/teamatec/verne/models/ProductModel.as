package com.teamatec.verne.models
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.maclema.mysql.MySqlToken;
	import com.maclema.mysql.Statement;
	
	import flash.events.IEventDispatcher;
	
	public class ProductModel extends AbstractModel
	{
		public function ProductModel()
		{
			table = "products";
			columns = ["title","description","sku","barcode","storage","buy_price","sell_price","unit","photo"];
		}
		
		public function addStorage(value:uint,id:String):void
		{
			var statement:Statement = connection.createStatement();
			statement.sql = "UPDATE products SET storage = storage + "+value+" where product_id = "+id;
			MonsterDebugger.trace(this,statement.sql);
			var token:MySqlToken = statement.executeQuery();
		}
	}
}