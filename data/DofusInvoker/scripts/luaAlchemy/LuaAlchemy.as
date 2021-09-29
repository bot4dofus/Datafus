package luaAlchemy
{
   import cmodule.lua_wrapper.CLibInit;
   import flash.utils.ByteArray;
   
   public class LuaAlchemy
   {
      
      public static const libInit:CLibInit = new CLibInit();
      
      private static const _luaAssetInit = LuaAssets.init(libInit);
       
      
      private var luaState:uint = 0;
      
      private var vfsRoot:String = "builtin://";
      
      public function LuaAlchemy(param1:* = null, param2:Boolean = true)
      {
         super();
         this.init(param1,param2);
      }
      
      public function init(param1:* = null, param2:Boolean = true) : void
      {
         var _loc3_:Array = null;
         if(this.luaState != 0)
         {
            this.close();
         }
         if(param1)
         {
            this.vfsRoot = param1;
         }
         this.luaState = lua_wrapper.luaInitializeState();
         lua_wrapper.setGlobalLuaValue(this.luaState,"_LUA_ALCHEMY_FILESYSTEM_ROOT",this.vfsRoot);
         if(param2)
         {
            _loc3_ = lua_wrapper.doFile(this.luaState,"builtin://lua_alchemy.lua");
            if(_loc3_.shift() == false)
            {
               this.close();
               throw new Error("LuaAlchemy.init() to call \'lua_alchemy.lua\' failed: " + _loc3_.toString());
            }
         }
      }
      
      public function close() : void
      {
         if(this.luaState != 0)
         {
            lua_wrapper.luaClose(this.luaState);
            this.luaState = 0;
         }
      }
      
      public function doFile(param1:String) : Array
      {
         if(this.luaState == 0)
         {
            this.init();
         }
         return lua_wrapper.doFile(this.luaState,param1);
      }
      
      public function doFileAsync(param1:String, param2:Function) : void
      {
         if(this.luaState == 0)
         {
            this.init();
         }
         lua_wrapper.doFileAsync(param2,this.luaState,param1);
      }
      
      public function doString(param1:String) : Array
      {
         if(this.luaState == 0)
         {
            this.init();
         }
         return lua_wrapper.luaDoString(this.luaState,param1);
      }
      
      public function doStringAsync(param1:String, param2:Function) : void
      {
         if(this.luaState == 0)
         {
            this.init();
         }
         lua_wrapper.luaDoStringAsync(param2,this.luaState,param1);
      }
      
      public function setGlobal(param1:String, param2:*) : void
      {
         if(this.luaState == 0)
         {
            this.init();
         }
         lua_wrapper.setGlobal(this.luaState,param1,param2);
      }
      
      public function setGlobalLuaValue(param1:String, param2:*) : void
      {
         if(this.luaState == 0)
         {
            this.init();
         }
         lua_wrapper.setGlobalLuaValue(this.luaState,param1,param2);
      }
      
      public function callGlobal(param1:String, ... rest) : Array
      {
         if(this.luaState == 0)
         {
            this.init();
         }
         return lua_wrapper.callGlobal(this.luaState,param1,rest);
      }
      
      public function supplyFile(param1:String, param2:ByteArray) : void
      {
         libInit.supplyFile(param1,param2);
      }
   }
}
