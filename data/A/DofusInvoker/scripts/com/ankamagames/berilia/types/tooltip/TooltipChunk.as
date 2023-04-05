package com.ankamagames.berilia.types.tooltip
{
   import flash.events.EventDispatcher;
   
   public class TooltipChunk extends EventDispatcher
   {
       
      
      private var _content:String;
      
      public function TooltipChunk(content:String)
      {
         super();
         this._content = content;
      }
      
      public function processContent(params:Object, secondaryParams:Object = null) : String
      {
         var i:* = null;
         var content:String = this._content;
         for(i in params)
         {
            content = content.split("#" + i).join(params[i]);
         }
         if(secondaryParams)
         {
            for(i in secondaryParams)
            {
               content = content.split("#" + i).join(secondaryParams[i]);
            }
         }
         return content;
      }
      
      public function get content() : String
      {
         return this._content;
      }
   }
}
