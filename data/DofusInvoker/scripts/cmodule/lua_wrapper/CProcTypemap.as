package cmodule.lua_wrapper
{
   class CProcTypemap extends CTypemap
   {
       
      
      private var retTypemap:CTypemap;
      
      private var varargs:Boolean;
      
      private var argTypemaps:Array;
      
      private var async:Boolean;
      
      function CProcTypemap(param1:CTypemap, param2:Array, param3:Boolean = false, param4:Boolean = false)
      {
         super();
         this.retTypemap = param1;
         this.argTypemaps = param2;
         this.varargs = param3;
         this.async = param4;
      }
      
      override public function createC(param1:*, param2:int = 0) : Array
      {
         var id:int = 0;
         var v:* = param1;
         var ptr:int = param2;
         id = regFunc(function():void
         {
            var args:* = undefined;
            var sp:* = undefined;
            var n:* = undefined;
            var tm:* = undefined;
            var aa:* = undefined;
            var ts:* = undefined;
            args = [];
            mstate.pop();
            sp = mstate.esp;
            n = 0;
            while(n < argTypemaps.length)
            {
               tm = argTypemaps[n];
               aa = [];
               ts = tm.typeSize;
               mstate.ds.position = sp;
               sp += ts;
               while(ts)
               {
                  aa.push(mstate.ds.readInt());
                  ts -= 4;
               }
               args.push(tm.fromC(aa));
               n++;
            }
            if(varargs)
            {
               args.push(sp);
            }
            try
            {
               retTypemap.toReturnRegs(mstate,v.apply(null,args));
            }
            catch(e:*)
            {
               mstate.eax = 0;
               mstate.edx = 0;
               mstate.st0 = 0;
               log(2,"v.apply: " + e.toString());
            }
         });
         return [id];
      }
      
      override public function destroyC(param1:Array) : void
      {
         unregFunc(int(param1[0]));
      }
      
      override public function fromC(param1:Array) : *
      {
         var v:Array = param1;
         return function(... rest):*
         {
            /*
             * Decompilation error
             * Code may be obfuscated
             * Tip: You can try enabling "Automatic deobfuscation" in Settings
             * Error type: NullPointerException (null)
             */
            throw new flash.errors.IllegalOperationError("Not decompiled due to error");
         };
      }
      
      private function push(param1:*) : void
      {
         var _loc2_:int = 0;
         if(param1 is Array)
         {
            _loc2_ = param1.length - 1;
            while(_loc2_ >= 0)
            {
               mstate.push(param1[_loc2_]);
               _loc2_--;
            }
         }
         else
         {
            mstate.push(param1);
         }
      }
   }
}
