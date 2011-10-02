package com.teamatec.verne.models
{
	
	import com.demonsters.debugger.MonsterDebugger;
	import com.maclema.mysql.MySqlToken;
	import com.maclema.mysql.Statement;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncResponder;
	
	public class UserModel extends AbstractModel
	{
		public static var systemAccessList:ArrayCollection;
		
		public function UserModel()
		{
			table = "users";
			columns =  ["company_id","name","username","password","rights"];
			systemAccessList = new ArrayCollection();
			
			systemAccessList.addItem({label:"بخش کاربران",code:"UsersGrid"});
			systemAccessList.addItem({label:"اضافه کردن کاربر",code:"UsersForm"});
			systemAccessList.addItem({label:"حذف کاربر",code:"UsersGrid-delete"});
			
			systemAccessList.addItem({label:"بخش فاکتورها",code:"FactorsGrid"});
			systemAccessList.addItem({label:"اضافه کردن فاکتور",code:"FactorsForm"});
			systemAccessList.addItem({label:"گزارش فاکتورها",code:"FactorsReport"});
			systemAccessList.addItem({label:"اضافه کردن فاکتور سریع",code:"FastFactorForm"});
			systemAccessList.addItem({label:"حذف فاکتور",code:"FactorsGrid-delete"});
			systemAccessList.addItem({label:"ویرایش فاکتور",code:"FactorsGrid-edit"});
			
			systemAccessList.addItem({label:"بخش محصولات و خدمات",code:"ProductsGrid"});
			systemAccessList.addItem({label:"اضافه کردن محصولات و خدمات",code:"ProductsForm"});
			systemAccessList.addItem({label:"گزارش محصولات و خدمات",code:"ProductsReport"});
			
			systemAccessList.addItem({label:"بخش مجموعه ها",code:"SequencesGrid"});
			systemAccessList.addItem({label:"اضافه کردن مجموعه",code:"SequencesForm"});
		}
		
	}
}