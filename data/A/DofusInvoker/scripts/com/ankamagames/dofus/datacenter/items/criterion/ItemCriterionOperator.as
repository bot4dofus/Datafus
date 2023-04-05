package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ItemCriterionOperator implements IDataCenter
   {
      
      public static const SUPERIOR:String = ">";
      
      public static const INFERIOR:String = "<";
      
      public static const EQUAL:String = "=";
      
      public static const DIFFERENT:String = "!";
      
      public static const EQUIPPED:String = "E";
      
      public static const NOT_EQUIPPED:String = "X";
      
      public static const OPERATORS_LIST:Array = [SUPERIOR,INFERIOR,EQUAL,DIFFERENT,EQUIPPED,NOT_EQUIPPED,"#","~","s","S","e","v","i","/"];
       
      
      private var _operator:String;
      
      public function ItemCriterionOperator(pStringOperator:String)
      {
         super();
         this._operator = pStringOperator;
      }
      
      public function get text() : String
      {
         return this._operator;
      }
      
      public function get htmlText() : String
      {
         if(this._operator == SUPERIOR)
         {
            return "&gt;";
         }
         if(this._operator == INFERIOR)
         {
            return "&lt;";
         }
         return this._operator;
      }
      
      public function compare(pLeftMember:Number, pRightMember:Number) : Boolean
      {
         switch(this._operator)
         {
            case SUPERIOR:
               if(pLeftMember > pRightMember)
               {
                  return true;
               }
               break;
            case INFERIOR:
               if(pLeftMember < pRightMember)
               {
                  return true;
               }
               break;
            case EQUAL:
               if(pLeftMember == pRightMember)
               {
                  return true;
               }
               break;
            case DIFFERENT:
               if(pLeftMember != pRightMember)
               {
                  return true;
               }
               break;
         }
         return false;
      }
   }
}
