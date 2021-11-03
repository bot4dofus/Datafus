package com.ankamagames.dofus.console.chat
{
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.managers.CharacterDisplacementManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.messages.game.basic.BasicWhoAmIRequestMessage;
   import com.ankamagames.dofus.network.messages.game.basic.BasicWhoIsRequestMessage;
   import com.ankamagames.dofus.network.types.common.AbstractPlayerSearchInformation;
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.dofus.network.types.common.PlayerSearchCharacterNameInformation;
   import com.ankamagames.dofus.network.types.common.PlayerSearchTagInformation;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.system.Capabilities;
   import flash.utils.getQualifiedClassName;
   
   public class InfoInstructionHandler implements ConsoleInstructionHandler
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(InfoInstructionHandler));
       
      
      public function InfoInstructionHandler()
      {
         super();
      }
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
      {
         var _loc4_:String = null;
         var _loc5_:AbstractPlayerSearchInformation = null;
         var _loc6_:BasicWhoAmIRequestMessage = null;
         var _loc7_:String = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:* = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:Array = null;
         var _loc17_:String = null;
         var _loc18_:String = null;
         var _loc19_:BasicWhoIsRequestMessage = null;
         switch(param2)
         {
            case "whois":
               if(param3.length == 0)
               {
                  return;
               }
               _loc4_ = param3.shift();
               if(_loc4_ == "*")
               {
                  _loc4_ = PlayedCharacterManager.getInstance().infos.name;
               }
               _loc5_ = null;
               if(_loc4_.charAt(0) == "*" && _loc4_.indexOf(PlayerManager.TAG_PREFIX) >= 2)
               {
                  _loc4_ = _loc4_.substr(1,_loc4_.length);
                  _loc16_ = _loc4_.split(PlayerManager.TAG_PREFIX);
                  _loc17_ = _loc16_[0];
                  _loc18_ = _loc16_[1];
                  if(_loc17_.length >= ProtocolConstantsEnum.MIN_ACCOUNT_NAME_LEN && _loc17_.length <= ProtocolConstantsEnum.MAX_ACCOUNT_NAME_LEN && _loc18_.length == ProtocolConstantsEnum.ACCOUNT_TAG_LEN)
                  {
                     _loc5_ = new PlayerSearchTagInformation().initPlayerSearchTagInformation(new AccountTagInformation().initAccountTagInformation(_loc17_,_loc18_));
                  }
               }
               else if(_loc4_.charAt(0) != "*" && _loc4_.length >= ProtocolConstantsEnum.MIN_NICK_LEN && _loc4_ && _loc4_.length <= ProtocolConstantsEnum.MAX_NICK_LEN)
               {
                  _loc5_ = new PlayerSearchCharacterNameInformation().initPlayerSearchCharacterNameInformation(_loc4_);
               }
               if(_loc5_ != null)
               {
                  _loc19_ = new BasicWhoIsRequestMessage();
                  _loc19_.initBasicWhoIsRequestMessage(true,_loc5_);
                  ConnectionsHandler.getConnection().send(_loc19_);
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.common.playerNotFound",[_loc4_]),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               break;
            case "version":
               param1.output(this.getVersion());
               break;
            case "about":
               param1.output(this.getVersion());
               break;
            case "whoami":
               _loc6_ = new BasicWhoAmIRequestMessage();
               _loc6_.initBasicWhoAmIRequestMessage(true);
               ConnectionsHandler.getConnection().send(_loc6_);
               break;
            case "mapid":
               _loc7_ = MapDisplayManager.getInstance().currentMapPoint.x + "/" + MapDisplayManager.getInstance().currentMapPoint.y;
               _loc8_ = MapDisplayManager.getInstance().currentMapPoint.mapId;
               _loc9_ = MapDisplayManager.getInstance().mapInstanceId;
               if(_loc9_ > 0)
               {
                  _loc10_ = _loc9_ + " (model " + _loc8_ + ")";
               }
               else
               {
                  _loc10_ = _loc8_.toString();
               }
               param1.output(I18n.getUiText("ui.chat.console.currentMap",[PlayedCharacterManager.getInstance().currentMap.outdoorX + "/" + PlayedCharacterManager.getInstance().currentMap.outdoorY + ", " + _loc7_,_loc10_]));
               break;
            case "cellid":
               _loc11_ = EntitiesManager.getInstance().getEntity(PlayedCharacterManager.getInstance().id).position.cellId.toString();
               param1.output(I18n.getUiText("ui.console.chat.currentCell",[_loc11_]));
               break;
            case "time":
               param1.output(TimeManager.getInstance().formatDateIG(0) + " - " + TimeManager.getInstance().formatClock(0,false));
               break;
            case "travel":
               if(param3.length > 2 || param3.length < 1)
               {
                  param1.output("No destination given, canceling auto travel attempt.");
                  return;
               }
               _loc12_ = param3[0] as String;
               if(param3[1])
               {
                  _loc13_ = param3[1] as String;
               }
               else
               {
                  param3 = _loc12_.split(",");
                  _loc12_ = param3[0];
                  _loc13_ = param3[1];
               }
               _loc14_ = int(_loc12_);
               _loc15_ = int(_loc13_);
               CharacterDisplacementManager.getInstance().autoTravel(_loc14_,_loc15_);
               break;
         }
      }
      
      private function getVersion() : String
      {
         return "----------------------------------------------\n" + "DOFUS CLIENT v " + BuildInfos.VERSION + "\n" + "(c) ANKAMA GAMES (" + BuildInfos.BUILD_DATE + ") \n" + "Flash player " + Capabilities.version + "\n----------------------------------------------";
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "version":
               return I18n.getUiText("ui.chat.console.help.version");
            case "about":
               return I18n.getUiText("ui.chat.console.help.version");
            case "whois":
               return I18n.getUiText("ui.chat.console.help.whois");
            case "whoami":
               return I18n.getUiText("ui.chat.console.help.whoami");
            case "cellid":
               return I18n.getUiText("ui.chat.console.help.cellid");
            case "mapid":
               return I18n.getUiText("ui.chat.console.help.mapid");
            case "time":
               return I18n.getUiText("ui.chat.console.help.time");
            default:
               return I18n.getUiText("ui.chat.console.noHelp",[cmd]);
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         return [];
      }
   }
}
