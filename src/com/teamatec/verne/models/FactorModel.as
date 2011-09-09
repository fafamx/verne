package com.teamatec.verne.models
{
	
	import com.demonsters.debugger.MonsterDebugger;
	import com.maclema.mysql.MySqlToken;
	import com.maclema.mysql.Statement;
	
	import flash.events.IEventDispatcher;
	
	import mx.rpc.AsyncResponder;
	
	public class FactorModel extends AbstractModel
	{
		public function FactorModel()
		{
			table = "factors";
			columns =  ["type","title","description","company_id","client_id","serial","factor_date","total","is_cash","factor_condition","discount","tax","status"];
		}
		
		public override function selectALL(callBack:Function, others:String=""):void
		{
			var statement:Statement = connection.createStatement();
			statement.sql = "SELECT *,(select title from clients where clients.client_id=factors.company_id) as company_title,(select title from clients where clients.client_id=factors.client_id) as client_title FROM factors " + others;
			var token:MySqlToken = statement.executeQuery();
			var responder:AsyncResponder = new AsyncResponder(callBack,onFail,token);
			token.addResponder(responder);
		}
		
		public function selectDateRangeCount(callBack:Function,from:String,to:String,type:String = null):void
		{
			var statement:Statement = connection.createStatement();
			statement.sql = "SELECT COUNT(factor_id) as count ,DAY(creation_date) as day FROM factors WHERE creation_date < '"+to+"' and creation_date > '"+from+"'";
			if(type && type != "0" && type != "null")
			{
				statement.sql += " and type="+type;	
			}
			
			statement.sql += " GROUP BY DAY(creation_date)"; 
			var token:MySqlToken = statement.executeQuery();
			var responder:AsyncResponder = new AsyncResponder(callBack,onFail,token);
			token.addResponder(responder);
		}
		
		public function updateTotal(id:String,value:String):void
		{
			var statement:Statement = connection.createStatement();
			statement.sql = "UPDATE factors SET total = "+value+" where factor_id ="+id;
			MonsterDebugger.trace(this,statement.sql);
			var token:MySqlToken = statement.executeQuery();
		}
		
		public function returnFactor(id:String):void
		{
			var statement:Statement = connection.createStatement();
			statement.sql = "UPDATE factors SET status = 1 where factor_id ="+id;
			MonsterDebugger.trace(this,statement.sql);
			var token:MySqlToken = statement.executeQuery();
		}
		
	}
}