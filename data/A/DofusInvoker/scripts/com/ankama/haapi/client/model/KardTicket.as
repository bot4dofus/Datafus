package com.ankama.haapi.client.model
{
   public class KardTicket
   {
       
      
      private var _order_list_obj_class:Array = null;
      
      public var order_list:Vector.<KardTypeOrder>;
      
      private var _kard_list_obj_class:Array = null;
      
      public var kard_list:Vector.<KardKard>;
      
      public function KardTicket()
      {
         this.order_list = new Vector.<KardTypeOrder>();
         this.kard_list = new Vector.<KardKard>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "KardTicket: ";
         str += " (order_list: " + this.order_list + ")";
         return str + (" (kard_list: " + this.kard_list + ")");
      }
   }
}
