package com.teamatec.verne.models
{
	import com.maclema.mysql.MySqlToken;
	import com.maclema.mysql.Statement;
	
	import flash.events.IEventDispatcher;
	
	import mx.rpc.AsyncResponder;
	
	public class ItemsModel extends AbstractModel
	{
		public function ItemsModel()
		{
			table = "items";
			columns =  ["factor_id","product_id","description","count","tax","discount"];
		}
		
		public override function selectALL(callBack:Function, others:String=""):void
		{
			var statement:Statement = connection.createStatement();
			statement.sql = "SELECT items.*, products.title,products.unit,products.sku,products.sell_price,products.photo FROM items Left JOIN products ON items.product_id = products.product_id"+ others;
			var token:MySqlToken = statement.executeQuery();
			var responder:AsyncResponder = new AsyncResponder(callBack,onFail,token);
			token.addResponder(responder)
		}
		
		public override function insert(values:Array):void
		{
			super.insert(values);
			var statement:Statement = connection.createStatement();
			statement.sql = "UPDATE products SET storage = storage - "+values[3]+" where product_id="+values[1];
			var token:MySqlToken = statement.executeQuery();
		}
		
	}
}