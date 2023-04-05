package com.ankama.haapi.client.model
{
   public class MoneyOgrine
   {
       
      
      public var id:String = null;
      
      public var date_creation:String = null;
      
      public var date_action_subscription:String = null;
      
      public var date_expiration:String = null;
      
      public var amount:Number = 0;
      
      public var amount_left:Number = 0;
      
      public var id_subscription:Number = 0;
      
      public var forbidden_usages:String = null;
      
      public function MoneyOgrine()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "MoneyOgrine: ";
         str += " (id: " + this.id + ")";
         str += " (date_creation: " + this.date_creation + ")";
         str += " (date_action_subscription: " + this.date_action_subscription + ")";
         str += " (date_expiration: " + this.date_expiration + ")";
         str += " (amount: " + this.amount + ")";
         str += " (amount_left: " + this.amount_left + ")";
         str += " (id_subscription: " + this.id_subscription + ")";
         return str + (" (forbidden_usages: " + this.forbidden_usages + ")");
      }
   }
}
