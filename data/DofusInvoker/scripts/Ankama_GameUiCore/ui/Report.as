package Ankama_GameUiCore.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.internalDatacenter.communication.BasicChatSentence;
   import com.ankamagames.dofus.logic.game.common.actions.social.AddIgnoredAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.CharacterReportAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.ChatReportAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   
   public class Report
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _playerID:Number = 0;
      
      private var _reasonName:Array;
      
      private var _playerName:String = "";
      
      private var _message:String = "";
      
      private var _fingerprint:String = "";
      
      private var _id:Number = 0;
      
      private var _channel:int = 0;
      
      private var _timestamp:Number = 0;
      
      private var _type:uint = 0;
      
      public var lbl_text:TextArea;
      
      public var btn_close:ButtonContainer;
      
      public var btn_send:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var btn_howTo:ButtonContainer;
      
      public var cb_reason:ComboBox;
      
      public function Report()
      {
         super();
      }
      
      public function main(param:Object) : void
      {
         var chatSentence:BasicChatSentence = null;
         var abuseReason:Object = null;
         var reasonObject:Object = null;
         this.uiApi.addComponentHook(this.cb_reason,"onRelease");
         this.uiApi.addComponentHook(this.btn_send,"onRelease");
         this.uiApi.addComponentHook(this.cb_reason,"onSelectItem");
         if(param.playerID is Number && param.playerName is String)
         {
            this._playerID = param.playerID;
            this._playerName = param.playerName;
            this._type = 1;
         }
         if(param.context != null && param.context.hasOwnProperty("fingerprint") && param.context.hasOwnProperty("timestamp"))
         {
            chatSentence = this.socialApi.getChatSentence(param.context.timestamp,param.context.fingerprint);
            if(chatSentence != null)
            {
               this._message = chatSentence.baseMsg;
               this._fingerprint = chatSentence.fingerprint;
               this._id = param.context.id;
               this._channel = chatSentence.channel;
               this._timestamp = param.context.timestamp;
               this._type = 0;
            }
         }
         var reasonList:Array = this.dataApi.getAllAbuseReasons();
         var cbProvider:Array = [];
         var reasonListSize:int = reasonList.length;
         for(var i:int = 0; i < reasonListSize; i++)
         {
            abuseReason = reasonList[i];
            if(abuseReason != null)
            {
               if((abuseReason.mask >> this._type & 1) == 1)
               {
                  reasonObject = {
                     "label":abuseReason.name,
                     "abuseReasonId":abuseReason.abuseReasonId,
                     "mask":abuseReason.mask,
                     "reasonTextId":abuseReason.reasonTextId
                  };
                  cbProvider.push(reasonObject);
               }
            }
         }
         this.cb_reason.dataProvider = cbProvider;
         this.cb_reason.value = cbProvider[0];
         var header:String = this.sysApi.getCurrentServer().name + " - " + this.timeApi.getDate(this._timestamp) + " " + this.timeApi.getClock(this._timestamp,true);
         if(this._message)
         {
            this.lbl_text.text = header + " - " + this._playerName + this.uiApi.getText("ui.common.colon") + this.chatApi.getStaticHyperlink(this._message);
         }
         else
         {
            this.lbl_text.text = header + " - " + this._playerName;
         }
      }
      
      public function unload() : void
      {
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi("report");
               break;
            case this.btn_send:
               this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.social.reportValidation"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onValidation],this.onValidation);
               break;
            case this.btn_help:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.phishing"));
               break;
            case this.btn_howTo:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.howToReport"));
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         switch(target)
         {
            case this.cb_reason:
               this.btn_help.visible = this.cb_reason.value.abuseReasonId == 4;
         }
      }
      
      public function onValidation() : void
      {
         if(this._type == 1)
         {
            this.sysApi.sendAction(new CharacterReportAction([this._playerID,this.cb_reason.value.abuseReasonId]));
         }
         else if(this._type == 0)
         {
            this.sysApi.sendAction(new ChatReportAction([this._playerID,this.cb_reason.value.abuseReasonId,this._playerName,this._channel,this._fingerprint,this._message,this._timestamp]));
         }
         this.sysApi.sendAction(new AddIgnoredAction([this._playerName]));
         this.sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.social.reportFeedBack",this._playerName),10,this.timeApi.getTimestamp());
         this.uiApi.unloadUi("report");
      }
   }
}
