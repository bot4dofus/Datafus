package com.ankamagames.berilia.types.event
{
   import com.ankamagames.berilia.uiRender.XmlPreProcessor;
   import flash.events.Event;
   
   public class PreProcessEndEvent extends Event
   {
      
      public static const PRE_PROCESS_END:String = "pre_process_end";
       
      
      private var _preprocessor:XmlPreProcessor;
      
      public function PreProcessEndEvent(preprocessor:XmlPreProcessor)
      {
         super(PRE_PROCESS_END,false,false);
         this._preprocessor = preprocessor;
      }
      
      public function get preprocessor() : XmlPreProcessor
      {
         return this._preprocessor;
      }
   }
}
