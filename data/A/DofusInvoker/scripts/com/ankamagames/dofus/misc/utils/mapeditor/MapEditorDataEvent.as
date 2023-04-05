package com.ankamagames.dofus.misc.utils.mapeditor
{
   import flash.events.Event;
   
   public class MapEditorDataEvent extends Event
   {
      
      public static const NEW_DATA:String = "MapEditorDataEvent_NEW_DATA";
       
      
      public var data:MapEditorMessage;
      
      public function MapEditorDataEvent(type:String, data:MapEditorMessage)
      {
         super(type,false,false);
         this.data = data;
      }
   }
}
