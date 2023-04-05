package com.ankamagames.atouin.utils.errors
{
   public class AtouinError extends Error
   {
       
      
      public function AtouinError(message:String = "", id:uint = 0)
      {
         super(message,id);
      }
   }
}
