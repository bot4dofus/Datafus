package com.ankamagames.dofus.kernel.sound.manager
{
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.misc.utils.errormanager.DofusErrorHandler;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.protocolAudio.ProtocolEnum;
   import com.ankamagames.jerakine.utils.system.CommandLineArguments;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.filesystem.File;
   import flash.net.Socket;
   import flash.net.URLLoader;
   import flash.system.MessageChannel;
   import flash.system.MessageChannelState;
   import flash.system.Worker;
   import flash.system.WorkerDomain;
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   
   public class RegConnectionManager
   {
      
      private static var _log:Logger = Log.getLogger(getQualifiedClassName(RegConnectionManager));
      
      private static var _self:RegConnectionManager;
      
      private static var Reg:Class = RegConnectionManager_Reg;
       
      
      private var _channelIn:MessageChannel;
      
      private var _channelOut:MessageChannel;
      
      private var _buffer:Vector.<String>;
      
      private var _isMain:Boolean = false;
      
      private var _worker:Worker;
      
      private var _legacySock:Socket;
      
      public function RegConnectionManager(pSingletonEnforcer:SingletonEnforcer)
      {
         super();
         if(_self)
         {
            throw new Error("RegConnectionManager is a Singleton");
         }
         this.init();
      }
      
      public static function getInstance() : RegConnectionManager
      {
         if(_self == null)
         {
            _self = new RegConnectionManager(new SingletonEnforcer());
         }
         return _self;
      }
      
      public function get isMain() : Boolean
      {
         return this._isMain;
      }
      
      public function setAsMain(pMain:Boolean) : void
      {
         if(pMain == this._isMain)
         {
            return;
         }
         this._isMain = pMain;
         if(pMain)
         {
            _log.warn("Je passe en main");
            SoundManager.getInstance().manager.playMainClientSounds();
         }
         else
         {
            _log.warn("Je ne suis plus main");
            SoundManager.getInstance().manager.stopMainClientSounds();
         }
         this.send(ProtocolEnum.SET_MAIN_CLIENT,this._isMain);
      }
      
      public function send(pMethodName:String, ... params) : void
      {
         var data:* = pMethodName + "(" + params + ")";
         if(!this._channelOut)
         {
            _log.info("No Out channel");
            if(!this._buffer)
            {
               this._buffer = new Vector.<String>();
            }
            this._buffer.push(data);
            return;
         }
         if(this._channelOut.state == MessageChannelState.CLOSED || this._channelOut.state == MessageChannelState.CLOSING)
         {
            _log.error("Message Channel Closed !");
            return;
         }
         this._channelOut.send(data);
      }
      
      private function init() : void
      {
         _log.info("Init Reg...");
         _log.info("Reg is Embed");
         this.OnRegReady(new Reg());
         if(CommandLineArguments.getInstance().hasArgument("reg-client-port"))
         {
            this._legacySock = new Socket();
            this._legacySock.connect("127.0.0.1",int(CommandLineArguments.getInstance().getArgument("reg-client-port")));
         }
      }
      
      private function removeLoaderListeners(loader:URLLoader) : void
      {
         loader.removeEventListener(Event.COMPLETE,this.onLoadComplete);
         loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
      }
      
      private function onError(event:ErrorEvent) : void
      {
         this.removeLoaderListeners(event.currentTarget as URLLoader);
         _log.error(event.toString());
      }
      
      private function onLoadComplete(event:Event) : void
      {
         this.removeLoaderListeners(event.currentTarget as URLLoader);
         this.OnRegReady(event.target.data);
      }
      
      private function OnRegReady(reg:ByteArray) : void
      {
         _log.info("Reg created.");
         this._worker = WorkerDomain.current.createWorker(reg,true);
         this._channelOut = Worker.current.createMessageChannel(this._worker);
         this._channelIn = this._worker.createMessageChannel(Worker.current);
         this._channelIn.addEventListener(Event.CHANNEL_MESSAGE,this.onData);
         this._worker.setSharedProperty("DofusToRegChannel",this._channelOut);
         this._worker.setSharedProperty("RegToDofusChannel",this._channelIn);
         this._worker.start();
         this.send(ProtocolEnum.CONFIG,File.applicationDirectory.nativePath);
         if(this._buffer)
         {
            while(this._buffer.length)
            {
               this._channelOut.send(this._buffer.shift());
            }
            this._buffer = null;
         }
      }
      
      public function onExit() : void
      {
         _log.info("Terminating Reg");
         if(this._worker)
         {
            this._worker.terminate();
         }
      }
      
      private function onData(pEvent:Event) : void
      {
         var cmd:String = null;
         var functionName:String = null;
         var soundID:int = 0;
         var data:String = null;
         while(this._channelIn.messageAvailable)
         {
            cmd = this._channelIn.receive() as String;
            if(cmd == "")
            {
               return;
            }
            functionName = cmd.split("(")[0];
            switch(functionName)
            {
               case ProtocolEnum.ENDOFSONG:
                  soundID = Number(cmd.split(":")[1]);
                  if(this._isMain)
                  {
                     SoundManager.getInstance().manager.endOfSound(soundID);
                  }
                  break;
               case ProtocolEnum.NEED_REG_LOGS:
                  data = cmd.substr(cmd.indexOf(":") + 1);
                  DofusErrorHandler.formatLogBufferReg(data);
                  break;
            }
         }
      }
   }
}

class SingletonEnforcer
{
    
   
   function SingletonEnforcer()
   {
      super();
   }
}
