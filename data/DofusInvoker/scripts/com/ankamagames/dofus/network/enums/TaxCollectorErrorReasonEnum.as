package com.ankamagames.dofus.network.enums
{
   public class TaxCollectorErrorReasonEnum
   {
      
      public static const TAX_COLLECTOR_ERROR_UNKNOWN:int = 0;
      
      public static const TAX_COLLECTOR_NOT_FOUND:int = 1;
      
      public static const TAX_COLLECTOR_NOT_OWNED:int = 2;
      
      public static const TAX_COLLECTOR_NO_RIGHTS:int = 3;
      
      public static const TAX_COLLECTOR_MAX_REACHED:int = 4;
      
      public static const TAX_COLLECTOR_ALREADY_ONE:int = 5;
      
      public static const TAX_COLLECTOR_CANT_HIRE_YET:int = 6;
      
      public static const TAX_COLLECTOR_CANT_HIRE_HERE:int = 7;
      
      public static const TAX_COLLECTOR_NOT_ENOUGH_KAMAS:int = 8;
       
      
      public function TaxCollectorErrorReasonEnum()
      {
         super();
      }
   }
}
