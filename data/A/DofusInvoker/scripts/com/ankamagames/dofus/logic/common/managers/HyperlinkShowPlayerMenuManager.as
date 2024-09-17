package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.factories.MenusFactory;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.managers.ChatAutocompleteNameManager;
   import com.ankamagames.dofus.logic.game.common.misc.PlayerIdName;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   
   public class HyperlinkShowPlayerMenuManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HyperlinkShowPlayerMenuManager));
       
      
      public function HyperlinkShowPlayerMenuManager()
      {
         super();
      }
      
      public static function getLink(pPlayerId:uint, pPlayerName:String, pText:String = null, plinkColor:String = null, phoverColor:String = null) : String
      {
         var linkColor:String = !!plinkColor ? ",linkColor:" + plinkColor : "";
         var hoverColor:String = !!phoverColor ? ",hoverColor:" + phoverColor : "";
         var text:String = !!pText ? "::" + pText : "";
         return "{player," + pPlayerName + "," + pPlayerId + linkColor + hoverColor + text + "}";
      }
      
      public static function showPlayerMenu(playerName:String, playerId:Number = 0, timestamp:Number = 0, fingerprint:String = null, chan:uint = 0, accountId:uint = 0) : void
      {
         var playerInfo:GameRolePlayCharacterInformations = null;
         var playerIdName:PlayerIdName = null;
         if(playerName)
         {
            playerName = StringUtils.unescapeAllowedChar(playerName);
         }
         var _modContextMenu:Object = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
         if(playerName && playerName.indexOf("★") == 0)
         {
            playerName = playerName.substr(1);
         }
         var roleplayEntitiesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(roleplayEntitiesFrame && playerId)
         {
            playerInfo = roleplayEntitiesFrame.getEntityInfos(playerId) as GameRolePlayCharacterInformations;
            if(!playerInfo)
            {
               playerInfo = new GameRolePlayCharacterInformations();
               playerInfo.contextualId = playerId;
               playerInfo.name = playerName;
               playerInfo.accountId = accountId;
            }
            _modContextMenu.createContextMenu(MenusFactory.create(playerInfo,null,[{
               "id":playerId,
               "fingerprint":fingerprint,
               "timestamp":timestamp,
               "chan":chan
            }]));
         }
         else
         {
            playerIdName = new PlayerIdName(playerId,playerName);
            _modContextMenu.createContextMenu(MenusFactory.create(playerIdName));
         }
      }
      
      public static function getPlayerName(pPlayerName:String, playerId:Number = 0, timestamp:Number = 0, fingerprint:String = null, chan:uint = 0, accountId:uint = 0) : String
      {
         var priority:int = 0;
         var playerName:String = unescape(pPlayerName);
         switch(chan)
         {
            case ChatActivableChannelsEnum.CHANNEL_TEAM:
            case ChatActivableChannelsEnum.CHANNEL_GUILD:
            case ChatActivableChannelsEnum.CHANNEL_PARTY:
            case ChatActivableChannelsEnum.CHANNEL_ARENA:
            case ChatActivableChannelsEnum.CHANNEL_ADMIN:
               priority = 3;
               break;
            case ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE:
               priority = 4;
               break;
            default:
               priority = 1;
         }
         if(playerName && playerName.indexOf("★") == 0)
         {
            playerName = playerName.substr(1);
         }
         ChatAutocompleteNameManager.getInstance().addEntry(playerName,priority);
         return playerName;
      }
      
      public static function rollOverPlayer(pX:int, pY:int, playerName:String, playerId:Number = 0, timestamp:Number = 0, fingerprint:String = null, chan:uint = 0) : void
      {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.player"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
