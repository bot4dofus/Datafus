package com.ankamagames.dofus.misc.utils.mapeditor
{
   import flash.utils.ByteArray;
   import flash.utils.IDataOutput;
   
   public class MapEditorMessage
   {
      
      public static const MESSAGE_TYPE_HELLO:uint = 1;
      
      public static const MESSAGE_TYPE_ELE:uint = 10;
      
      public static const MESSAGE_TYPE_DLM:uint = 20;
      
      public static const MESSAGE_TYPE_NPC:uint = 30;
       
      
      public var type:uint;
      
      public var data:ByteArray;
      
      public function MapEditorMessage(type:uint)
      {
         super();
         this.type = type;
      }
      
      public function serialize(target:IDataOutput) : void
      {
         if(!this.data)
         {
            target.writeInt(4);
            target.writeInt(this.type);
         }
         else
         {
            target.writeInt(4 + this.data.length);
            target.writeInt(this.type);
            this.data.position = 0;
            target.writeBytes(this.data);
         }
      }
   }
}
