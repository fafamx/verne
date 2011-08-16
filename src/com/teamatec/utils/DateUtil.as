package com.teamatec.utils
{
	public class DateUtil
	{
		public static function dateMySqlToDate(date:String):Date{
			
			if(date == "")
				return null;
			
			if(date == "0000-00-00")
				return null;
			
			// Split time and date
			var aux:Array = date.split(" ");
			
			// Get the date part into an array
			var d:Array = String(aux[0]).split("-");
			
			// Get the hour part into an array
			var h:Array = String(aux[1]).split(":");
			
			if(h.length > 1)
				return new Date(d[0], d[1] - 1, d[2], h[0], h[1], h[2]);
			else
				return new Date(d[0], d[1] - 1, d[2]);
			
		}
		
		
		public static function getMySQLDate( date:Date ):String {
			var s:String = date.fullYear + '-';
			
			// add the month
			if( date.month < 10 ) {
				s += '0' + ( date.month + 1 ) + '-';
			} else {
				s += ( date.month + 1 ) + '-';
			}
			
			// add the day
			if( date.date < 10 ) {
				s += '0' + date.date;
			} else {
				s += date.date;
			}
			
			return s;
		}

		
		
	}
}