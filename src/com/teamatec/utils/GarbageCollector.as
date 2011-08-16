package com.teamatec.utils
{
	import flash.net.LocalConnection;
	import flash.system.System;

	public class GarbageCollector
	{
		/**
		 *  custom Garbage Collector method to managing memory in better way
		 * 
		 */
		public static function gc():void
		{
			System.gc();
			System.gc();
			
			try {
				var lc1:LocalConnection = new LocalConnection();
				var lc2:LocalConnection = new LocalConnection();
				lc1.connect("dummy1");
				lc2.connect("dummy1");
			} catch (e:Error) {}
		}
	}
}