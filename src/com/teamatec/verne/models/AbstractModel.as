package com.teamatec.verne.models
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.TweenMax;
	import com.maclema.mysql.Connection;
	import com.maclema.mysql.MySqlResponse;
	import com.maclema.mysql.MySqlToken;
	import com.maclema.mysql.ResultSet;
	import com.maclema.mysql.Statement;
	import com.teamatec.utils.NumberUtil;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.setTimeout;
	
	import mx.rpc.AsyncResponder;
	import mx.utils.ArrayUtil;
	
	public class AbstractModel extends EventDispatcher
	{
		public static var connection:Connection;
		public var table:String;
		public var columns:Array;
		public var updateColumns:Array;
		public var insertColumns:Array;
		public var pageSize:uint = 20;
		protected var rowsCount:uint = 0;
		
		public static const COUNT_COMPLETE:String = "count-complete";
		public static const DELETE_COMPLETE:String = "delete-complete";
		
		public function AbstractModel()
		{
			super(this);
			setTimeout(countRows,1);
		}
		
		public function insert(values:Array):void
		{
			
			if(!insertColumns)
			{
				insertColumns = columns;
			}
			
			var statement:Statement = connection.createStatement();
			statement.sql = "INSERT INTO "+table + " (" + insertColumns.toString()+") VALUES ('"+NumberUtil.internationalizeNumbers(values.join("','"))+"')";
			MonsterDebugger.trace(this,statement.sql);
			var token:MySqlToken = statement.executeQuery();
			var responder:AsyncResponder = new AsyncResponder(onComplete,onFail,token);
			token.addResponder(responder);
		}
		
		public function update(values:Array,condition:String):void
		{
			
			if(!updateColumns)
			{
				updateColumns = columns;
			}
			
			var statement:Statement = connection.createStatement();
			var updateValues:Array = ("='"+values.join("', ='")+"'").split(",");
			for(var i:uint = 0;i<updateValues.length;i++)
			{
				updateValues[i] = updateColumns[i] + NumberUtil.internationalizeNumbers(updateValues[i]);
			}
			statement.sql = "UPDATE "+table + " SET " + updateValues + " WHERE "+ condition;
			statement.sql = statement.sql.split("undefined").join("")
			MonsterDebugger.trace(this,statement.sql);
			var token:MySqlToken = statement.executeQuery();
			var responder:AsyncResponder = new AsyncResponder(updateComplete,onFail,token);
			token.addResponder(responder);
		}
		
		protected function updateComplete(response:MySqlResponse,token:MySqlToken):void
		{
			var event:Event = new Event(Event.COMPLETE);
			dispatchEvent(event);
		}
		
		public function selectALL(callBack:Function,others:String = ""):void
		{
			var statement:Statement = connection.createStatement();
			statement.sql = "SELECT * FROM "+table + others;
			MonsterDebugger.trace(this,statement.sql);
			var token:MySqlToken = statement.executeQuery();
			var responder:AsyncResponder = new AsyncResponder(callBack,onFail,token);
			token.addResponder(responder);
		}
		
		public function isUnique(condition:String,callBack:Function):void
		{
			var statement:Statement = connection.createStatement();
			statement.sql = "SELECT COUNT(*) as result_count FROM "+table+" WHERE "+condition;
			MonsterDebugger.trace(this,statement.sql);
			var token:MySqlToken = statement.executeQuery();
			var responder:AsyncResponder = new AsyncResponder(callBack,onFail,token);
			token.addResponder(responder);
		}
		
		public function countRows(condition:String = null):void
		{
			var statement:Statement = connection.createStatement();
			statement.sql = "SELECT COUNT(*) as result_count FROM "+table;
			if(condition)
			{
				statement.sql+=" WHERE "+condition;
			}
			MonsterDebugger.trace(this,statement.sql);
			var token:MySqlToken = statement.executeQuery();
			var responder:AsyncResponder = new AsyncResponder(countComplete,onFail,token);
			token.addResponder(responder);
		}
		
		public function deleteRows(condition:String):void
		{
			doDelete(condition);
		}
		
		protected function doDelete(condition:String):void
		{
			var statement:Statement = connection.createStatement();
			statement.sql = "DELETE FROM "+table + " WHERE "+condition;
			MonsterDebugger.trace(this,statement.sql);
			var token:MySqlToken = statement.executeQuery();
		}
		
		public function lastInsertedId(callback:Function,key:String):void
		{
			var statement:Statement = connection.createStatement();
			
			statement.sql = "SELECT max("+key+") as last FROM "+table;
			MonsterDebugger.trace(this,statement.sql);
			var token:MySqlToken = statement.executeQuery();
			var responder:AsyncResponder = new AsyncResponder(callback,onFail,token);
			token.addResponder(responder);
		}
		
		protected function countComplete(data:*, token:*):void
		{
			rowsCount = data.getRows()[0].result_count;
			dispatchEvent(new Event(COUNT_COMPLETE));
		}
		
		public function get count():uint
		{
			return rowsCount;
		}
		
		protected function onComplete(data:*, token:*):void
		{
			var event:Event = new Event(Event.COMPLETE);
			trace("complete " ,event);
			dispatchEvent(event);
		}
		
		protected function onFail(info:*, token:*):void
		{
			var event:ErrorEvent = new ErrorEvent(ErrorEvent.ERROR);
			dispatchEvent(event);
		}
	}
}