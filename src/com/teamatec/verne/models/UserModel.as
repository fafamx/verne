package com.teamatec.verne.models
{
	
	import com.demonsters.debugger.MonsterDebugger;
	import com.maclema.mysql.MySqlToken;
	import com.maclema.mysql.Statement;
	
	import flash.events.IEventDispatcher;
	
	import mx.rpc.AsyncResponder;
	
	public class CategoryClientModel extends AbstractModel
	{
		public function CategoryClientModel()
		{
			table = "users";
			columns =  ["company_id","name","username","password","access"];
		}
		
	}
}