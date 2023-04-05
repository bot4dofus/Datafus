package com.ankamagames.tiphon.types
{
   import com.ankamagames.jerakine.interfaces.IFLAEventHandler;
   
   public class EventListener
   {
       
      
      public var listener:IFLAEventHandler;
      
      public var typesEvents:String;
      
      public function EventListener(pListener:IFLAEventHandler, pTypesEvents:String)
      {
         super();
         this.listener = pListener;
         this.typesEvents = pTypesEvents;
      }
   }
}
