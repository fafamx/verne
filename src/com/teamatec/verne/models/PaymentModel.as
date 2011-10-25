package com.teamatec.verne.models
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.maclema.mysql.MySqlToken;
	import com.maclema.mysql.Statement;
	
	import mx.rpc.AsyncResponder;
	
	
	public class PaymentModel extends AbstractModel
	{
		public function PaymentModel()
		{
			table = "payments";
			columns =  ["value","factor_id","client_id","description","creation_date","user_id"];
		
		}
		
		
		public override function selectALL(callBack:Function, others:String=""):void
		{
			var statement:Statement = connection.createStatement();
			statement.sql = "SELECT *,(select title from clients where clients.client_id=payments.client_id) as client_title,(select username from users where users.user_id=payments.user_id) as user_name FROM payments " + others;
			var token:MySqlToken = statement.executeQuery();
			var responder:AsyncResponder = new AsyncResponder(callBack,onFail,token);
			token.addResponder(responder);
		}
		
		public function selectDateRangeCount(callBack:Function,from:String,to:String):void
		{
			var statement:Statement = connection.createStatement();
			statement.sql = "SELECT COUNT(payment_id) as count ,creation_date as date FROM payments WHERE creation_date <= '"+to+"' and creation_date >= '"+from+"'";
			
			
			statement.sql += " GROUP BY DAY(creation_date)"; 
			MonsterDebugger.trace(this , statement.sql );
			var token:MySqlToken = statement.executeQuery();
			var responder:AsyncResponder = new AsyncResponder(callBack,onFail,token);
			token.addResponder(responder);
		}
		
		public function selectAllInDateRange(callBack:Function,from:String,to:String):void
		{
			selectALL(callBack , "WHERE creation_date <= '"+to+"' and creation_date >= '"+from+"'");
		}
	}
}