package com.teamatec.verne.models
{
	import mx.collections.ArrayCollection;

	public class StandardFactorModel extends Object
	{
		[Bindable]
		public var id:String;
		
		[Bindable]
		public var title:String;
		
		[Bindable]
		public var date:String;
		
		[Bindable]
		public var serial:String;
		
		[Bindable]
		public var ownerName:String;
		
		[Bindable]
		public var ownerEconomicCode:String;
		
		[Bindable]
		public var ownerNationalCode:String;
		
		[Bindable]
		public var ownerState:String;
		
		[Bindable]
		public var ownerTownship:String;
		
		[Bindable]
		public var ownerCity:String;
		
		[Bindable]
		public var ownerPostalCode:String;
		
		[Bindable]
		public var ownerTitle:String;
		
		[Bindable]
		public var ownerAddress:String;
		
		[Bindable]
		public var ownerTell:String;
		
		
		
		[Bindable]
		public var clientName:String;
		
		[Bindable]
		public var clientEconomicCode:String;
		
		[Bindable]
		public var clientNationalCode:String;
		
		[Bindable]
		public var clientState:String;
		
		[Bindable]
		public var clientTownship:String;
		
		[Bindable]
		public var clientCity:String;
		
		[Bindable]
		public var clientPostalCode:String;
		
		[Bindable]
		public var clientTitle:String;
		
		[Bindable]
		public var clientAddress:String;
		
		[Bindable]
		public var clientTell:String;
		
		[Bindable]
		private var factorItems:ArrayCollection;
		
		[Bindable]
		public var conditions:String;
		
		[Bindable]
		public var isCash:Boolean;
		
		[Bindable]
		public var condition:String;
		
		public function StandardFactorModel()
		{
			super();
		}
		
		public function set items(value:ArrayCollection):void
		{
			factorItems = value;
			for(var i:uint=0;i<value.length;i++)
			{
				var item:Object = factorItems[i];
				
				if(!item.title || item.title.toString() == "null" ||item.title.toString() == "")
				{
					factorItems.removeItemAt(i);
					continue;
				}
				
				item.total = item.price* item.count;
				item.totalWithDiscount = item.total - item.discount;
				item.totalWithTax = item.totalWithDiscount + item.tax;
				
				priceSum += item.price;
				totalPriceSum += item.total;
				discountTotalSum += item.discount;
				totalWithDiscountSum += item.totalWithDiscount;
				taxSum += item.tax;
				totalWithTaxSum += item.totalWithTax;
			}
			var model:FactorModel = new FactorModel();
			model.updateTotal(id,totalWithTaxSum.toString());
		}
		
		[Bindable]
		public function get items():ArrayCollection
		{
			return factorItems;
		}
		
		[Bindable]
		public var priceSum:Number = 0;
		
		[Bindable]
		public var totalPriceSum:Number = 0;
		
		[Bindable]
		public var discountTotalSum:Number = 0;
		
		[Bindable]
		public var totalWithDiscountSum:Number = 0;
		
		[Bindable]
		public var taxSum:Number = 0;
		
		[Bindable]
		public var totalWithTaxSum:Number = 0;
	}
}