package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceListRequestAction;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceListMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceVersatileInfoListMessage;
   import com.ankamagames.dofus.network.types.game.social.AllianceFactSheetInformations;
   import com.ankamagames.dofus.network.types.game.social.AllianceVersatileInformations;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.RegisteringFrame;
   import com.ankamagames.jerakine.resources.adapters.impl.SignedFileAdapter;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.utils.crypto.Base64;
   import com.ankamagames.jerakine.utils.crypto.Signature;
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class SocialDataFrame extends RegisteringFrame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SocialDataFrame));
      
      private static const LOCAL_URL:String = "http://gameservers-www-exports.dofus2.lan/";
      
      private static const ONLINE_URL:String = "https://dofus2.cdn.ankama.com/game-export/";
       
      
      private var _urlAllianceList:Uri;
      
      private var _urlAllianceVersatileList:Uri;
      
      private var _allianceList:Vector.<AllianceWrapper>;
      
      private var _waitStaticAllianceInfo:Boolean;
      
      private var _waitVersatileAllianceInfo:Boolean;
      
      public var versatileDataLifetime:uint = 300000.0;
      
      public var staticDataLifetime:uint = 900000.0;
      
      public function SocialDataFrame()
      {
         var output:ByteArray = null;
         var signedData:ByteArray = null;
         var signature:Signature = null;
         var signatureIsValid:Boolean = false;
         this._allianceList = new Vector.<AllianceWrapper>();
         super();
         AllianceWrapper.clearCache();
         var serverId:int = PlayerManager.getInstance().server.id;
         var base_url:String = BuildInfos.BUILD_TYPE >= BuildTypeEnum.TESTING ? LOCAL_URL : ONLINE_URL;
         var configGameExport:String = XmlConfig.getInstance().getEntry("config.gameExport");
         if(configGameExport)
         {
            if(BuildInfos.BUILD_TYPE <= BuildTypeEnum.TESTING)
            {
               if(XmlConfig.getInstance().getEntry("config.gameExport.signature"))
               {
                  output = new ByteArray();
                  try
                  {
                     signedData = Base64.decodeToByteArray(XmlConfig.getInstance().getEntry("config.gameExport.signature"));
                     signedData.position = signedData.length;
                     signedData.writeUTFBytes(configGameExport);
                     signedData.position = 0;
                     signature = new Signature(SignedFileAdapter.defaultSignatureKey);
                     signatureIsValid = signature.verify(signedData,output);
                  }
                  catch(error:Error)
                  {
                     _log.error("gameExport signature has not been properly encoded in Base64.");
                  }
                  if(signatureIsValid)
                  {
                     base_url = configGameExport;
                  }
               }
               else
               {
                  _log.error("gameExport needs to be signed!");
               }
            }
            else
            {
               base_url = configGameExport;
            }
         }
         this._urlAllianceList = new Uri(base_url + "AllianceListMessage." + serverId + ".data");
         this._urlAllianceVersatileList = new Uri(base_url + "AllianceVersatileInfoListMessage." + serverId + ".data");
         ConnectionsHandler.getHttpConnection().addToWhiteList(AllianceVersatileInfoListMessage);
         ConnectionsHandler.getHttpConnection().addToWhiteList(AllianceListMessage);
         ConnectionsHandler.getHttpConnection().resetTime(this._urlAllianceList);
         ConnectionsHandler.getHttpConnection().resetTime(this._urlAllianceVersatileList);
         this.onAllianceListRequest(new AllianceListRequestAction());
      }
      
      override public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      override protected function registerMessages() : void
      {
         register(AllianceListRequestAction,this.onAllianceListRequest);
         register(AllianceListMessage,this.onAllianceListMessage);
         register(AllianceVersatileInfoListMessage,this.onAllianceVersatileListMessage);
      }
      
      private function onAllianceListRequest(a:AllianceListRequestAction) : Boolean
      {
         var newStaticRequest:Boolean = ConnectionsHandler.getHttpConnection().request(this._urlAllianceList,this.onAllianceIoError,this.staticDataLifetime);
         if(newStaticRequest)
         {
            this._waitStaticAllianceInfo = true;
         }
         var newVersatileRequest:Boolean = ConnectionsHandler.getHttpConnection().request(this._urlAllianceVersatileList,this.onAllianceVersatileIoError,this.versatileDataLifetime);
         if(newVersatileRequest)
         {
            this._waitVersatileAllianceInfo = true;
         }
         if(!this._waitVersatileAllianceInfo && !this._waitStaticAllianceInfo)
         {
            this.dispatchAllianceList();
         }
         return true;
      }
      
      private function onAllianceListMessage(m:AllianceListMessage) : Boolean
      {
         var ts:uint = getTimer();
         this._allianceList = new Vector.<AllianceWrapper>();
         var len:uint = m.alliances.length;
         var list:Vector.<AllianceFactSheetInformations> = m.alliances;
         for(var i:uint = 0; i < len; i++)
         {
            this._allianceList[i] = AllianceWrapper.getFromNetwork(list[i]);
         }
         this._waitStaticAllianceInfo = false;
         this.dispatchAllianceList(true);
         return true;
      }
      
      private function onAllianceVersatileListMessage(m:AllianceVersatileInfoListMessage) : Boolean
      {
         var alliance:AllianceWrapper = null;
         var allianceIndex:int = 0;
         var ts:uint = getTimer();
         var len:uint = m.alliances.length;
         var list:Vector.<AllianceVersatileInformations> = m.alliances;
         var allianceFrame:AllianceFrame = Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame;
         for(var i:uint = 0; i < len; i++)
         {
            allianceIndex = -1;
            for each(alliance in this._allianceList)
            {
               if(alliance.allianceId == list[i].allianceId)
               {
                  allianceIndex = this._allianceList.indexOf(alliance);
                  break;
               }
            }
            if(allianceIndex != -1)
            {
               this._allianceList[allianceIndex] = AllianceWrapper.getFromNetwork(list[i]);
            }
            else if(allianceFrame.hasAlliance && list[i].allianceId == allianceFrame.alliance.allianceId)
            {
               alliance = allianceFrame.alliance.clone();
               alliance.nbGuilds = list[i].nbGuilds;
               alliance.nbMembers = list[i].nbMembers;
               alliance.nbSubareas = list[i].nbSubarea;
               AllianceWrapper.updateRef(alliance.allianceId,alliance);
               this._allianceList.push(alliance);
            }
         }
         this._waitVersatileAllianceInfo = false;
         this.dispatchAllianceList(true);
         return true;
      }
      
      private function dispatchAllianceList(isUpdate:Boolean = false, isError:Boolean = false) : void
      {
         var aw:AllianceWrapper = null;
         if(this._waitStaticAllianceInfo || this._waitVersatileAllianceInfo)
         {
            return;
         }
         for each(aw in this._allianceList)
         {
            AllianceWrapper.updateRef(aw.allianceId,aw);
         }
         KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceList,this._allianceList,isUpdate,this._allianceList == null || isError);
      }
      
      private function onAllianceIoError() : void
      {
         _log.error("Impossible d\'accéder aux données static de liste d\'alliance");
         this._waitStaticAllianceInfo = false;
         this.dispatchAllianceList(false,true);
      }
      
      private function onAllianceVersatileIoError() : void
      {
         _log.error("Impossible d\'accéder aux données versatile de liste d\'alliance");
         this._waitVersatileAllianceInfo = false;
         this.dispatchAllianceList(false,true);
      }
   }
}
