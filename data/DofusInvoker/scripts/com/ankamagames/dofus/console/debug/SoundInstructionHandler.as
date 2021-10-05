package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.managers.UiSoundManager;
   import com.ankamagames.berilia.types.data.UiData;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.datacenter.sounds.SoundUiHook;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.kernel.sound.manager.RegConnectionManager;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.protocolAudio.ProtocolEnum;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class SoundInstructionHandler implements ConsoleInstructionHandler
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SoundInstructionHandler));
       
      
      public function SoundInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var soundId:String = null;
         var sIdm:String = null;
         var volm:Number = NaN;
         var loopm:Boolean = false;
         var sIda:String = null;
         var vola:Number = NaN;
         var loopa:Boolean = false;
         var volume:Number = NaN;
         var silenceMin:uint = 0;
         var silenceMax:uint = 0;
         switch(cmd)
         {
            case "playmusic":
               if(args.length != 2)
               {
                  console.output("COMMAND FAILED ! playmusic must have followings parameters : \n-id\n-volume");
                  return;
               }
               sIdm = args[0];
               volm = args[1];
               loopm = true;
               SoundManager.getInstance().manager.playAdminSound(sIdm,volm,loopm,0);
               break;
            case "stopmusic":
               SoundManager.getInstance().manager.removeAllSounds();
               break;
            case "playambiance":
               if(args.length != 2)
               {
                  console.output("COMMAND FAILED ! playambiance must have followings parameters : \n-id\n-volume");
                  return;
               }
               sIda = args[0];
               vola = args[1];
               loopa = true;
               SoundManager.getInstance().manager.playAdminSound(sIda,vola,loopa,1);
               break;
            case "stopambiance":
               SoundManager.getInstance().manager.stopAdminSound(1);
               break;
            case "addsoundinplaylist":
               if(args.length != 4)
               {
                  console.output("addSoundInPLaylist must have followings parameters : \n-id\n-volume\n-silenceMin\n-SilenceMax");
                  return;
               }
               soundId = args[0];
               volume = args[1];
               silenceMin = args[2];
               silenceMax = args[3];
               if(!SoundManager.getInstance().manager.addSoundInPlaylist(soundId,volume,silenceMin,silenceMax))
               {
                  console.output("addSoundInPLaylist failed !");
               }
               break;
            case "stopplaylist":
               if(args.length != 0)
               {
                  console.output("stopplaylist doesn\'t accept any paramter");
                  return;
               }
               SoundManager.getInstance().manager.stopPlaylist();
               break;
            case "playplaylist":
               if(args.length != 0)
               {
                  console.output("removeSoundInPLaylist doesn\'t accept any paramter");
                  return;
               }
               SoundManager.getInstance().manager.playPlaylist();
               break;
            case "activesounds":
               SoundManager.getInstance().manager.forceSoundsDebugMode = true;
               break;
            case "clearsoundcache":
               RegConnectionManager.getInstance().send(ProtocolEnum.REMOVE_ALL_SOUNDS);
               RegConnectionManager.getInstance().send(ProtocolEnum.CLEAR_CACHE);
               break;
            case "adduisoundelement":
               if(args.length < 4)
               {
                  console.output("4 parameters needed");
                  return;
               }
               if(!UiSoundManager.getInstance().getUi(args[0]))
               {
                  UiSoundManager.getInstance().registerUi(args[0]);
               }
               UiSoundManager.getInstance().registerUiElement(args[0],args[1],args[2],args[3]);
               break;
         }
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "playsound":
               return "Play a sound";
            case "clearsoundcache":
               return "Nettoye les fichiers pré-cachés pour le son afin de les relire directement depuis le disque lors de la prochaine demande de lecture";
            default:
               return "Unknown command \'" + cmd + "\'.";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         var filter:String = null;
         var hooks:Array = null;
         var hooksList:Array = null;
         var hook:SoundUiHook = null;
         switch(cmd)
         {
            case "adduisoundelement":
               if(paramIndex == 0)
               {
                  return this.getUiList(currentParams && currentParams.length ? currentParams[0] : null);
               }
               if(paramIndex == 2)
               {
                  filter = currentParams && currentParams.length > 2 ? currentParams[2].toLowerCase() : "";
                  hooks = [];
                  hooksList = SoundUiHook.getSoundUiHooks();
                  for each(hook in hooksList)
                  {
                     if(hook.name.toLowerCase().indexOf(filter) != -1)
                     {
                        hooks.push(hook.name);
                     }
                  }
                  return hooks;
               }
               break;
         }
         return [];
      }
      
      private function getUiList(filter:String = null) : Array
      {
         var m:UiModule = null;
         var ui:UiData = null;
         filter = filter.toLowerCase();
         var uiList:Array = [];
         var modList:Dictionary = UiModuleManager.getInstance().getModules();
         for each(m in modList)
         {
            for each(ui in m.uis)
            {
               if(!filter || ui.name.toLowerCase().indexOf(filter) != -1)
               {
                  uiList.push(ui.name);
               }
            }
         }
         uiList.sort();
         return uiList;
      }
      
      private function getParams(data:Array, types:Array) : Array
      {
         var iStr:* = null;
         var i:uint = 0;
         var v:String = null;
         var t:String = null;
         var params:Array = [];
         for(iStr in data)
         {
            i = parseInt(iStr);
            v = data[i];
            t = types[i];
            params[i] = this.getParam(v,t);
         }
         return params;
      }
      
      private function getParam(value:String, type:String) : *
      {
         switch(type)
         {
            case "String":
               return value;
            case "Boolean":
               return value == "true" || value == "1";
            case "int":
            case "uint":
               return parseInt(value);
            default:
               _log.warn("Unsupported parameter type \'" + type + "\'.");
               return value;
         }
      }
   }
}
