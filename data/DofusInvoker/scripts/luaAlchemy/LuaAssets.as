package luaAlchemy
{
   import flash.system.Security;
   import flash.utils.ByteArray;
   
   public class LuaAssets
   {
      
      private static var _asset0:Class = LuaAssets__asset0;
      
      private static var _asset1:Class = LuaAssets__asset1;
      
      private static var _asset2:Class = LuaAssets__asset2;
      
      private static var _asset3:Class = LuaAssets__asset3;
      
      private static var _asset4:Class = LuaAssets__asset4;
      
      private static var _asset5:Class = LuaAssets__asset5;
      
      private static var _asset6:Class = LuaAssets__asset6;
      
      private static var _asset7:Class = LuaAssets__asset7;
      
      private static var _asset8:Class = LuaAssets__asset8;
      
      private static var _filesystemRoot:String;
       
      
      public function LuaAssets()
      {
         super();
      }
      
      public static function filesystemRoot() : String
      {
         return _filesystemRoot;
      }
      
      public static function init(param1:*) : void
      {
         param1.supplyFile("builtin://lua_alchemy/as3/filegetcontents.lua",new _asset0() as ByteArray);
         param1.supplyFile("builtin://lua_alchemy/as3/onclose.lua",new _asset1() as ByteArray);
         param1.supplyFile("builtin://lua_alchemy/as3/print.lua",new _asset2() as ByteArray);
         param1.supplyFile("builtin://lua_alchemy/as3/sugar.lua",new _asset3() as ByteArray);
         param1.supplyFile("builtin://lua_alchemy/as3/toobject.lua",new _asset4() as ByteArray);
         param1.supplyFile("builtin://lua_alchemy/lua/dofile.lua",new _asset5() as ByteArray);
         param1.supplyFile("builtin://lua_alchemy/lua/print.lua",new _asset6() as ByteArray);
         param1.supplyFile("builtin://lua_alchemy/lua/strict.lua",new _asset7() as ByteArray);
         param1.supplyFile("builtin://lua_alchemy.lua",new _asset8() as ByteArray);
         if(Security.sandboxType == Security.LOCAL_WITH_FILE || Security.sandboxType == Security.LOCAL_TRUSTED)
         {
            _filesystemRoot = "file:///Users/agladysh/projects/lua-alchemy/alchemy/lua-lib/assets/";
         }
         else
         {
            _filesystemRoot = "builtin://";
         }
      }
   }
}
