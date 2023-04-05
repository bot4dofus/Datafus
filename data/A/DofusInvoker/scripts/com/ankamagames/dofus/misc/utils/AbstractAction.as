package com.ankamagames.dofus.misc.utils
{
   public class AbstractAction
   {
       
      
      protected var _parameters:Array;
      
      public function AbstractAction(params:Array = null)
      {
         super();
         if(params == null)
         {
            params = [];
         }
         this._parameters = params;
      }
      
      public function get parameters() : Array
      {
         return this._parameters;
      }
   }
}
