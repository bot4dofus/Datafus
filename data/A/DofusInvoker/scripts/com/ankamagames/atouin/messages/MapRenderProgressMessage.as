package com.ankamagames.atouin.messages
{
   public class MapRenderProgressMessage extends MapMessage
   {
       
      
      private var _percent:Number = 0;
      
      public function MapRenderProgressMessage(percent:Number)
      {
         super();
         this._percent = percent;
      }
      
      public function get percent() : Number
      {
         return this._percent;
      }
   }
}
