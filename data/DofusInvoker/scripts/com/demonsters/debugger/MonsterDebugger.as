package com.demonsters.debugger
{
   import flash.display.DisplayObject;
   
   public class MonsterDebugger
   {
      
      private static var _enabled:Boolean = true;
      
      private static var _initialized:Boolean = false;
      
      public static var logger:Function;
      
      static const VERSION:Number = 3.02;
       
      
      public function MonsterDebugger()
      {
         super();
      }
      
      public static function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public static function trace(caller:*, object:*, person:String = "", label:String = "", color:uint = 0, depth:int = 5) : void
      {
         if(_initialized && _enabled)
         {
            MonsterDebuggerCore.trace(caller,object,person,label,color,depth);
         }
      }
      
      public static function log(... args) : void
      {
         var target:String = null;
         var stack:String = null;
         var lines:Array = null;
         var s:String = null;
         var bracketIndex:int = 0;
         var methodIndex:int = 0;
         if(_initialized && _enabled)
         {
            if(args.length == 0)
            {
               return;
            }
            target = "Log";
            try
            {
               throw new Error();
            }
            catch(e:Error)
            {
               stack = e.getStackTrace();
               if(stack != null && stack != "")
               {
                  stack = stack.split("\t").join("");
                  lines = stack.split("\n");
                  if(lines.length > 2)
                  {
                     lines.shift();
                     lines.shift();
                     s = lines[0];
                     s = s.substring(3,s.length);
                     bracketIndex = s.indexOf("[");
                     methodIndex = s.indexOf("/");
                     if(bracketIndex == -1)
                     {
                        bracketIndex = s.length;
                     }
                     if(methodIndex == -1)
                     {
                        methodIndex = bracketIndex;
                     }
                     target = MonsterDebuggerUtils.parseType(s.substring(0,methodIndex));
                     if(target == "<anonymous>")
                     {
                        target = "";
                     }
                     if(target == "")
                     {
                        target = "Log";
                     }
                  }
               }
               if(args.length == 1)
               {
                  MonsterDebuggerCore.trace(target,args[0],"","",0,5);
               }
               else
               {
                  MonsterDebuggerCore.trace(target,args,"","",0,5);
               }
            }
         }
      }
      
      public static function clear() : void
      {
         if(_initialized && _enabled)
         {
            MonsterDebuggerCore.clear();
         }
      }
      
      public static function set enabled(value:Boolean) : void
      {
         _enabled = value;
      }
      
      public static function snapshot(caller:*, object:DisplayObject, person:String = "", label:String = "") : void
      {
         if(_initialized && _enabled)
         {
            MonsterDebuggerCore.snapshot(caller,object,person,label);
         }
      }
      
      public static function inspect(object:*) : void
      {
         if(_initialized && _enabled)
         {
            MonsterDebuggerCore.inspect(object);
         }
      }
      
      public static function breakpoint(caller:*, id:String = "breakpoint") : void
      {
         if(_initialized && _enabled)
         {
            MonsterDebuggerCore.breakpoint(caller,id);
         }
      }
      
      public static function initialize(base:Object, address:String = "127.0.0.1") : void
      {
         if(!_initialized)
         {
            _initialized = true;
            MonsterDebuggerCore.base = base;
            MonsterDebuggerCore.initialize();
            MonsterDebuggerConnection.initialize();
            MonsterDebuggerConnection.address = address;
            MonsterDebuggerConnection.connect();
         }
      }
   }
}
