package com.teamatec.verne.models
{
	
	import com.demonsters.debugger.MonsterDebugger;
	import com.maclema.mysql.MySqlToken;
	import com.maclema.mysql.Statement;
	
	import flash.events.IEventDispatcher;
	
	import mx.rpc.AsyncResponder;
	
	public class CategoriesModel extends AbstractModel
	{
		public function CategoriesModel()
		{
			table = "categories";
			columns =  ["title"];
		}
		
	}
}