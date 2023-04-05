package com.demonsters.debugger
{
   import flash.utils.ByteArray;
   
   public class MonsterDebuggerData
   {
       
      
      private var _data:Object;
      
      private var _id:String;
      
      public function MonsterDebuggerData(id:String, data:Object)
      {
         super();
         _id = id;
         _data = data;
      }
      
      public static function read(bytes:ByteArray) : MonsterDebuggerData
      {
         var item:MonsterDebuggerData = new MonsterDebuggerData(null,null);
         item.bytes = bytes;
         return item;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set bytes(value:ByteArray) : void
      {
         var bytesId:ByteArray = new ByteArray();
         var bytesData:ByteArray = new ByteArray();
         try
         {
            value.readBytes(bytesId,0,value.readUnsignedInt());
            value.readBytes(bytesData,0,value.readUnsignedInt());
            _id = bytesId.readObject() as String;
            _data = bytesData.readObject() as Object;
         }
         catch(e:Error)
         {
            _id = null;
            _data = null;
         }
         bytesId = null;
         bytesData = null;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get bytes() : ByteArray
      {
         var bytesId:ByteArray = new ByteArray();
         var bytesData:ByteArray = new ByteArray();
         bytesId.writeObject(_id);
         bytesData.writeObject(_data);
         var item:ByteArray = new ByteArray();
         item.writeUnsignedInt(bytesId.length);
         item.writeBytes(bytesId);
         item.writeUnsignedInt(bytesData.length);
         item.writeBytes(bytesData);
         item.position = 0;
         bytesId = null;
         bytesData = null;
         return item;
      }
   }
}
