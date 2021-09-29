package cmodule.lua_wrapper
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   
   public class CSystemLocal implements CSystem
   {
       
      
      private const statCache:Object = {};
      
      private var forceSync:Boolean;
      
      private const fds:Array = [];
      
      public function CSystemLocal(param1:Boolean = false)
      {
         super();
         this.forceSync = param1;
         gtextField = new TextField();
         gtextField.width = !!gsprite ? Number(gsprite.stage.stageWidth) : Number(800);
         gtextField.height = !!gsprite ? Number(gsprite.stage.stageHeight) : Number(600);
         gtextField.multiline = true;
         gtextField.defaultTextFormat = new TextFormat("Courier New");
         gtextField.type = TextFieldType.INPUT;
         gtextField.doubleClickEnabled = true;
         this.fds[0] = new TextFieldI(gtextField);
         this.fds[1] = new TextFieldO(gtextField,gsprite == null);
         this.fds[2] = new TextFieldO(gtextField,true);
         if(gsprite && gtextField)
         {
            gsprite.addChild(gtextField);
         }
         else
         {
            log(3,"local system w/o gsprite");
         }
      }
      
      public function getargv() : Array
      {
         return gargs;
      }
      
      public function lseek(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:IO = null;
         _loc4_ = this.fds[param1];
         if(param3 == 0)
         {
            _loc4_.position = param2;
         }
         else if(param3 == 1)
         {
            _loc4_.position += param2;
         }
         else if(param3 == 2)
         {
            _loc4_.position = _loc4_.size + param2;
         }
         return _loc4_.position;
      }
      
      public function open(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:ByteArrayIO = null;
         _loc4_ = gstate.gworker.stringFromPtr(param1);
         if(param2 != 0)
         {
            log(3,"failed open(" + _loc4_ + ") flags(" + param2 + ")");
            return -1;
         }
         _loc5_ = this.fetch(_loc4_);
         if(_loc5_.pending)
         {
            throw new AlchemyBlock();
         }
         if(_loc5_.size < 0)
         {
            log(3,"failed open(" + _loc4_ + ") doesn\'t exist");
            return -1;
         }
         _loc6_ = 0;
         while(this.fds[_loc6_])
         {
            _loc6_++;
         }
         _loc7_ = new ByteArrayIO();
         _loc7_.byteArray = new ByteArray();
         _loc7_.byteArray.writeBytes(_loc5_.data);
         _loc7_.byteArray.position = 0;
         this.fds[_loc6_] = _loc7_;
         log(4,"open(" + _loc4_ + "): " + _loc7_.size);
         return _loc6_;
      }
      
      public function psize(param1:int) : int
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         _loc2_ = gstate.gworker.stringFromPtr(param1);
         _loc3_ = this.fetch(_loc2_);
         if(_loc3_.pending)
         {
            throw new AlchemyBlock();
         }
         if(_loc3_.size < 0)
         {
            log(3,"psize(" + _loc2_ + ") failed");
         }
         else
         {
            log(3,"psize(" + _loc2_ + "): " + _loc3_.size);
         }
         return _loc3_.size;
      }
      
      public function read(param1:int, param2:int, param3:int) : int
      {
         return this.fds[param1].read(param2,param3);
      }
      
      public function getenv() : Object
      {
         return genv;
      }
      
      public function write(param1:int, param2:int, param3:int) : int
      {
         return this.fds[param1].write(param2,param3);
      }
      
      public function access(param1:int, param2:int) : int
      {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         _loc3_ = gstate.gworker.stringFromPtr(param1);
         if(param2 & ~4)
         {
            log(3,"failed access(" + _loc3_ + ") mode(" + param2 + ")");
            return -1;
         }
         _loc4_ = this.fetch(_loc3_);
         if(_loc4_.pending)
         {
            throw new AlchemyBlock();
         }
         log(3,"access(" + _loc3_ + "): " + (_loc4_.size >= 0));
         if(_loc4_.size < 0)
         {
            return -1;
         }
         return 0;
      }
      
      public function exit(param1:int) : void
      {
         log(3,"exit: " + param1);
         shellExit(param1);
      }
      
      public function fsize(param1:int) : int
      {
         return this.fds[param1].size;
      }
      
      public function tell(param1:int) : int
      {
         return this.fds[param1].position;
      }
      
      public function ioctl(param1:int, param2:int, param3:int) : int
      {
         return -1;
      }
      
      public function close(param1:int) : int
      {
         var _loc2_:int = 0;
         _loc2_ = this.fds[param1].close();
         this.fds[param1] = null;
         return _loc2_;
      }
      
      private function fetch(param1:String) : Object
      {
         var res:Object = null;
         var gf:ByteArray = null;
         var request:URLRequest = null;
         var loader:URLLoader = null;
         var path:String = param1;
         res = this.statCache[path];
         if(!res)
         {
            gf = gfiles[path];
            if(gf)
            {
               res = {
                  "pending":false,
                  "size":gf.length,
                  "data":gf
               };
               this.statCache[path] = res;
               return res;
            }
         }
         if(this.forceSync)
         {
            return res || {
               "size":-1,
               "pending":false
            };
         }
         if(!res)
         {
            request = new URLRequest(path);
            loader = new URLLoader();
            loader.dataFormat = URLLoaderDataFormat.BINARY;
            loader.addEventListener(Event.COMPLETE,function(param1:Event):void
            {
               statCache[path].data = loader.data;
               statCache[path].size = loader.data.length;
               statCache[path].pending = false;
            });
            loader.addEventListener(IOErrorEvent.IO_ERROR,function(param1:Event):void
            {
               statCache[path].size = -1;
               statCache[path].pending = false;
            });
            this.statCache[path] = res = {"pending":true};
            loader.load(request);
         }
         return res;
      }
      
      public function setup(param1:Function) : void
      {
         param1();
      }
   }
}
