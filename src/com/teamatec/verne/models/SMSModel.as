package com.teamatec.verne.models
{
	import com.maclema.mysql.MySqlToken;
	import com.maclema.mysql.ResultSet;
	import com.maclema.mysql.Statement;
	import com.teamatec.verne.ui.elements.ApplicationInterface;
	
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class SMSModel extends AbstractModel
	{
		public function SMSModel()
		{
			table = "sms";
			columns = ["token","reciver","message","sender","time","status"];
			insertColumns = ["reciver","message","sender"];
		}
		
		public function sync():void
		{
			ApplicationInterface.tokenToItem = new Dictionary(true);
			var statement:Statement = connection.createStatement();
			statement.sql = "SELECT * FROM "+table+" WHERE status != 1 and status != 2 and status != 16 order by status DESC, sms_id DESC LIMIT 0, 20" ;
			var token:MySqlToken = statement.executeQuery();
			var responder:AsyncResponder = new AsyncResponder(syncResponse,syncFail,token);
			token.addResponder(responder);
		}
		
		public function selectMonthCount(callBack:Function):void
		{
			var statement:Statement = connection.createStatement();
			statement.sql = "SELECT COUNT(sms_id) as count ,DAY(creation_date) as day FROM sms WHERE MONTH(creation_date) = MONTH(current_DATE) GROUP BY DAY(creation_date)";
			var token:MySqlToken = statement.executeQuery();
			var responder:AsyncResponder = new AsyncResponder(callBack,syncFail,token);
			token.addResponder(responder);
		}
		
		public function countByStatus(callBack:Function):void
		{
			var statement:Statement = connection.createStatement();
			statement.sql = "SELECT COUNT(sms_id) as count,status from sms GROUP BY status";
			var token:MySqlToken = statement.executeQuery();
			var responder:AsyncResponder = new AsyncResponder(callBack,syncFail,token);
			token.addResponder(responder);
		}
		
		protected function syncResponse(data:ResultSet, token:*):void
		{
			var result:ArrayCollection = data.getRows();
			var item:Object;
			if(!ApplicationInterface.que)
			{
				ApplicationInterface.que = new ArrayCollection();
			}
			var now:Date = new Date();
			var at:String =  now.getSeconds()+" : "+now.getMinutes().toString()+" : "+now.getHours().toString();
			if(ApplicationInterface.que.length == 10)
			{
				ApplicationInterface.que.removeItemAt(0);
			}
			ApplicationInterface.que.addItem({at:"",count:result.length});
			
			for(var i:uint;i<result.length;i++)
			{
				item = result.getItemAt(i);
				if(item.status == "-1")
				{
					var sendToken:* = ApplicationInterface.smsGateway.send.send(item.reciver,item.message,item.sender,null);
					ApplicationInterface.tokenToItem [sendToken] = item;
				}
				else
				{
					var deliveryToken:* = ApplicationInterface.smsGateway.deliveryStatus.send(item.token);
					ApplicationInterface.tokenToItem [deliveryToken] = item;
				}
			}
		}
		
		protected function syncFail(info:*, token:*):void
		{
			
		}
		
		public function updateToken(id:String,value:String):void
		{
			var statement:Statement = connection.createStatement();
			statement.sql = "UPDATE "+table + " SET status = 0, token='"+value+"' WHERE sms_id = "+id;
			var token:MySqlToken = statement.executeQuery();
		}
		
		public function updateStatus(tokenId:String,status:String):void
		{
			var statement:Statement = connection.createStatement();
			statement.sql = "UPDATE "+table + " SET status = '"+status+"' WHERE token = '"+tokenId+"'";
			var token:MySqlToken = statement.executeQuery();
		}
	}
}