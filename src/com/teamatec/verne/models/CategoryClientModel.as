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
			table = "category_client";
			columns =  ["client_id","category_id"];
		}
		
	}
}