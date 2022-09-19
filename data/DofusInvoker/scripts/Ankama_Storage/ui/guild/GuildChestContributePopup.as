package Ankama_Storage.ui.guild
{
   import Ankama_Common.ui.TextButtonPopup;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveKamaAction;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class GuildChestContributePopup extends TextButtonPopup
   {
       
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      public var lbl_myContribution:Label;
      
      public var lbl_contentWarning:Label;
      
      public var tx_kamaMyContribution:Texture;
      
      private var _myContribution:uint;
      
      public function GuildChestContributePopup()
      {
         super();
      }
      
      override public function main(params:Object) : void
      {
         sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         if(!params.hasOwnProperty("title"))
         {
            params.title = uiApi.getText("ui.common.confirm");
         }
         if(!params.hasOwnProperty("content"))
         {
            params.content = uiApi.getText("ui.guild.confirmContributionContent");
         }
         if(!params.hasOwnProperty("buttonText"))
         {
            params.buttonText = [uiApi.getText("ui.common.validation"),uiApi.getText("ui.common.cancel")];
         }
         if(!params.hasOwnProperty("buttonCallback"))
         {
            params.buttonCallback = [this.contribute,this.cancel];
         }
         if(!params.hasOwnProperty("onCancel"))
         {
            params.onCancel = this.cancel;
         }
         if(!params.hasOwnProperty("onEnterKey"))
         {
            params.onEnterKey = this.contribute;
         }
         this._myContribution = params.myContribution;
         this.lbl_myContribution.text = this.utilApi.kamasToString(this._myContribution,"");
         this.lbl_contentWarning.text = uiApi.getText("ui.guild.confirmContributionContentWarning");
         super.main(params);
      }
      
      public function onUiLoaded(uiName:String) : void
      {
         if(uiName == uiApi.me().name)
         {
            this.tx_kamaMyContribution.x = this.lbl_myContribution.x + this.lbl_myContribution.width / 2 + this.lbl_myContribution.textWidth / 2;
         }
      }
      
      override protected function computePopupHeight() : void
      {
         lbl_content.fullWidthAndHeight(0,20);
         height += this.lbl_contentWarning.y + this.lbl_contentWarning.contentHeight + Number(uiApi.me().getConstant("bottom_margin"));
         popup.height = height;
      }
      
      private function cancel() : void
      {
      }
      
      private function contribute() : void
      {
         sysApi.sendAction(new ExchangeObjectMoveKamaAction([this._myContribution]));
         uiApi.unloadUi(UIEnum.UNLOCK_GUILD_CHEST);
         uiApi.unloadUi(uiApi.me().name);
      }
   }
}
