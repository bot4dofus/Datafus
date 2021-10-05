package cmodule.lua_wrapper
{
   public class MemUser
   {
       
      
      public function MemUser()
      {
         super();
      }
      
      public final function _mrd(param1:int) : Number
      {
         gstate.ds.position = param1;
         return gstate.ds.readDouble();
      }
      
      public final function _mrf(param1:int) : Number
      {
         gstate.ds.position = param1;
         return gstate.ds.readFloat();
      }
      
      public final function _mr32(param1:int) : int
      {
         gstate.ds.position = param1;
         return gstate.ds.readInt();
      }
      
      public final function _mru8(param1:int) : int
      {
         gstate.ds.position = param1;
         return gstate.ds.readUnsignedByte();
      }
      
      public final function _mw32(param1:int, param2:int) : void
      {
         gstate.ds.position = param1;
         gstate.ds.writeInt(param2);
      }
      
      public final function _mrs8(param1:int) : int
      {
         gstate.ds.position = param1;
         return gstate.ds.readByte();
      }
      
      public final function _mw16(param1:int, param2:int) : void
      {
         gstate.ds.position = param1;
         gstate.ds.writeShort(param2);
      }
      
      public final function _mw8(param1:int, param2:int) : void
      {
         gstate.ds.position = param1;
         gstate.ds.writeByte(param2);
      }
      
      public final function _mrs16(param1:int) : int
      {
         gstate.ds.position = param1;
         return gstate.ds.readShort();
      }
      
      public final function _mru16(param1:int) : int
      {
         gstate.ds.position = param1;
         return gstate.ds.readUnsignedShort();
      }
      
      public final function _mwd(param1:int, param2:Number) : void
      {
         gstate.ds.position = param1;
         gstate.ds.writeDouble(param2);
      }
      
      public final function _mwf(param1:int, param2:Number) : void
      {
         gstate.ds.position = param1;
         gstate.ds.writeFloat(param2);
      }
   }
}
