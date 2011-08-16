package com.teamatec.utils
{
	public class NumberUtil
	{
		private static var persianNumbers:String = "۰۱۲۳۴۵۶۷۸۹";
		
		public static function digital(value:uint):String
		{
			var result:String = value.toString();
			if(value < 10)
			{
				result = "0"+value;
			}
			return result;
		}
		
		public static function internationalizeNumbers(value:String):String
		{
			var result:String = value;
			var numbers:Array = persianNumbers.split("");
			for(var i:uint = 0;i<numbers.length;i++)
			{
				result = result.split(String(numbers[i])).join(i.toString());
			}
			return result;
		}
		
		public static function zeroPad (number:String, width:int):String {
			if (number.length < width)
				return "0" + zeroPad(number, width-1);
			return number;
		}
	}
}