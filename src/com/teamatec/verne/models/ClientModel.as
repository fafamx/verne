package com.teamatec.verne.models
{
	import com.maclema.mysql.MySqlToken;
	import com.maclema.mysql.Statement;
	
	import flash.events.IEventDispatcher;
	
	import mx.rpc.AsyncResponder;
	
	public class ClientModel extends AbstractModel
	{
		public function ClientModel()
		{
			table = "clients";
			columns =  ["title","description","phone","cell","email","economic_code","national_code","postal_code","address","fax","city","state","township"];
		}
		
		public function getClientTitle(id:String,callBack:Function):void
		{
			var statement:Statement = connection.createStatement();
			statement.sql = "SELECT title FROM "+table+" WHERE client_id = "+id;
			var token:MySqlToken = statement.executeQuery();
			var responder:AsyncResponder = new AsyncResponder(callBack,onFail,token);
			token.addResponder(responder);
		}
		
		public function clientsInCategory(category:String,callBack:Function):void
		{
			
			var statement:Statement = connection.createStatement();
			statement.sql = "SELECT client_id,title,cell,(SELECT count(category_client.client_id) FROM category_client WHERE category_client.category_id = "+category+" and category_client.client_id = clients.client_id) as selected FROM clients"
			var token:MySqlToken = statement.executeQuery();
			var responder:AsyncResponder = new AsyncResponder(callBack,onFail,token);
			token.addResponder(responder);
		}
	}
}