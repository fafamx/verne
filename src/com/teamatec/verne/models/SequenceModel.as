package com.teamatec.verne.models
{
	
	import com.demonsters.debugger.MonsterDebugger;
	import com.maclema.mysql.MySqlToken;
	import com.maclema.mysql.Statement;
	
	import flash.events.IEventDispatcher;
	
	import mx.rpc.AsyncResponder;
	
	public class SequenceModel extends AbstractModel
	{
		public function SequenceModel()
		{
			table = "sequences";
			columns =  ["title","value"];
		}
		
		public function plusPlus(id:String):void
		{
			var statement:Statement = connection.createStatement();
			statement.sql = "UPDATE sequences SET value = value + 1 where sequence_id = "+id;
			MonsterDebugger.trace(this,statement.sql);
			var token:MySqlToken = statement.executeQuery();
		}
		
	}
}