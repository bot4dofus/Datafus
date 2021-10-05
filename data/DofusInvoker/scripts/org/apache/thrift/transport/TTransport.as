package org.apache.thrift.transport
{
   import flash.utils.ByteArray;
   import org.apache.thrift.AbstractMethodError;
   
   public class TTransport
   {
       
      
      public function TTransport()
      {
         super();
      }
      
      public function isOpen() : Boolean
      {
         throw new AbstractMethodError();
      }
      
      public function peek() : Boolean
      {
         return this.isOpen();
      }
      
      public function open() : void
      {
         throw new AbstractMethodError();
      }
      
      public function close() : void
      {
         throw new AbstractMethodError();
      }
      
      public function read(param1:ByteArray, param2:int, param3:int) : int
      {
         throw new AbstractMethodError();
      }
      
      public function readAll(param1:ByteArray, param2:int, param3:int) : int
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc4_ < param3)
         {
            _loc5_ = this.read(param1,param2 + _loc4_,param3 - _loc4_);
            if(_loc5_ <= 0)
            {
               throw new TTransportError(TTransportError.UNKNOWN,"Cannot read. Remote side has closed. Tried to read " + param3 + " bytes, but only got " + _loc4_ + " bytes.");
            }
            _loc4_ += _loc5_;
         }
         return _loc4_;
      }
      
      public function writeAll(param1:ByteArray) : void
      {
         this.write(param1,0,param1.length);
      }
      
      public function write(param1:ByteArray, param2:int, param3:int) : void
      {
         throw new AbstractMethodError();
      }
      
      public function flush(param1:Function = null) : void
      {
         throw new AbstractMethodError();
      }
   }
}
