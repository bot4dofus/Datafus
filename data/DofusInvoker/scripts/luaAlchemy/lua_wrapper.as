package luaAlchemy
{
   import cmodule.lua_wrapper.CLibInit;
   
   public class lua_wrapper
   {
      
      protected static const _lib_init:CLibInit = new CLibInit();
      
      protected static const _lib = _lib_init.init();
       
      
      public function lua_wrapper()
      {
         super();
      }
      
      public static function luaInitializeState() : uint
      {
         return _lib.luaInitializeState();
      }
      
      public static function luaClose(luaState:uint) : void
      {
         _lib.luaClose(luaState);
      }
      
      public static function doFile(luaState:uint, strFileName:*) : Array
      {
         return _lib.doFile(luaState,strFileName);
      }
      
      public static function doFileAsync(gg_handle:Function, luaState:uint, strFileName:*) : void
      {
         _lib.doFileAsync(gg_handle,luaState,strFileName);
      }
      
      public static function luaDoString(luaState:uint, strValue:*) : Array
      {
         return _lib.luaDoString(luaState,strValue);
      }
      
      public static function luaDoStringAsync(gg_handle:Function, luaState:uint, strValue:*) : void
      {
         _lib.luaDoStringAsync(gg_handle,luaState,strValue);
      }
      
      public static function setGlobal(luaState:uint, key:String, value:*) : void
      {
         _lib.setGlobal(luaState,key,value);
      }
      
      public static function setGlobalLuaValue(luaState:uint, key:String, value:*) : void
      {
         _lib.setGlobalLuaValue(luaState,key,value);
      }
      
      public static function callGlobal(luaState:uint, key:*, args:Array) : Array
      {
         return _lib.callGlobal(luaState,key,args);
      }
   }
}
