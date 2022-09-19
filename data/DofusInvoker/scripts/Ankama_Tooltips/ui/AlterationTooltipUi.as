package Ankama_Tooltips.ui
{
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.internalDatacenter.alterations.AlterationWrapper;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.events.TimerEvent;
   
   public class AlterationTooltipUi extends TooltipPinableBaseUi
   {
       
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="BindsApi")]
      public var bindsApi:BindsApi;
      
      public var lbl_content:Label;
      
      public var tx_icon:Texture;
      
      public var tx_iconbg:TextureBitmap;
      
      private var _timerHide:BenchmarkTimer;
      
      private var _timerDisplay:BenchmarkTimer;
      
      private var _alteration:AlterationWrapper;
      
      private var _mainParams:Object;
      
      private var _tooltipName:String;
      
      private var _margin:int;
      
      public function AlterationTooltipUi()
      {
         super();
      }
      
      override public function main(params:Object = null) : void
      {
         var displayDelay:int = 0;
         this._mainParams = params;
         this._alteration = params.data as AlterationWrapper;
         if(this.tx_icon !== null)
         {
            this.tx_iconbg.x = Number(uiApi.me().getConstant("tooltipLength")) - Number(uiApi.me().getConstant("iconOffsetX")) - this.tx_iconbg.width;
            this.tx_iconbg.y = Number(uiApi.me().getConstant("iconOffsetY"));
            this.tx_icon.x = this.tx_iconbg.x + this.tx_iconbg.width / 2 - this.tx_icon.width / 2;
            this.tx_icon.y = this.tx_iconbg.y + this.tx_iconbg.height / 2 - this.tx_icon.height / 2;
            this.tx_iconbg.visible = true;
            this.tx_icon.visible = true;
            this.tx_icon.uri = this._alteration.fullSizeIconUri;
         }
         else
         {
            this.tx_iconbg.visible = false;
            this.tx_icon.visible = false;
         }
         this._margin = this.lbl_content.x;
         this._tooltipName = uiApi.me().name;
         this.onFontActiveTypeChanged();
         this.lbl_content.multiline = true;
         this.lbl_content.text = params.tooltip.htmlText;
         sysApi.addHook(RoleplayHookList.AlterationRemoved,this.onAlterationRemoved);
         sysApi.addHook(HookList.FontActiveTypeChanged,this.onFontActiveTypeChanged);
         if(params.autoHide)
         {
            this._timerHide = new BenchmarkTimer(ProtocolConstantsEnum.DEFAULT_TOOLTIP_DURATION,0,"AlterationTooltipUi._timerHide");
            this._timerHide.addEventListener(TimerEvent.TIMER,this.onTimerHide);
            this._timerHide.start();
         }
         if(uiApi.me().height > uiApi.getStageHeight() && this._alteration.description)
         {
            this.lbl_content.text = this.shortenDescriptionFromHtmlText(this._mainParams.tooltip.htmlText);
         }
         this.updateTooltipSize();
         this.tooltipApi.place(params.position,params.showDirectionalArrow,params.point,params.relativePoint,params.offset);
         super.main(params);
         if((!params || !params.makerParam || !params.makerParam.hasOwnProperty("pinnable") || !params.makerParam.pinnable) && !isPin)
         {
            displayDelay = sysApi.getOption("itemTooltipDelay","dofus");
            if(displayDelay > 0)
            {
               mainCtr.visible = false;
               this._timerDisplay = new BenchmarkTimer(displayDelay,0,"AlterationTooltipUi._timerDisplay");
               this._timerDisplay.addEventListener(TimerEvent.TIMER,this.onTimerDisplay);
               this._timerDisplay.start();
            }
            else if(displayDelay == -1)
            {
               mainCtr.visible = false;
            }
         }
      }
      
      override protected function makePin() : void
      {
         btnClose.x = this.tx_iconbg.x + this.tx_iconbg.width + Number(uiApi.me().getConstant("btnCloseOffsetX"));
         btnClose.y = this.tx_iconbg.y + Number(uiApi.me().getConstant("btnCloseOffsetY"));
         if(btnMenu !== null)
         {
            btnMenu.x = btnClose.x + Number(uiApi.me().getConstant("btnMenuOffsetX"));
            btnMenu.y = btnClose.y + Number(uiApi.me().getConstant("btnMenuOffsetY"));
         }
         backgroundCtr.width = Number(uiApi.me().getConstant("PinnedTooltipBackgroundWidth"));
         super.makePin();
      }
      
      private function onFontActiveTypeChanged() : void
      {
         this.lbl_content.text = this._mainParams.tooltip.htmlText;
         var tooltipCssName:String = "tooltip_item";
         var activeFontType:String = sysApi.getActiveFontType();
         if(activeFontType && activeFontType != "default")
         {
            tooltipCssName += "-" + activeFontType;
         }
         uiApi.setLabelStyleSheet(this.lbl_content,sysApi.getConfigEntry("config.ui.skin") + "css/" + tooltipCssName + ".css");
         if(uiApi.me().height > uiApi.getStageHeight() && this._alteration.description)
         {
            this.lbl_content.text = this.shortenDescriptionFromHtmlText(this._mainParams.tooltip.htmlText);
         }
         this.updateTooltipSize();
      }
      
      private function shortenDescriptionFromHtmlText(htmlText:String) : String
      {
         var fullText:String = htmlText;
         return fullText.replace(this._alteration.description,"[" + String.fromCharCode(8230) + "]");
      }
      
      private function updateTooltipSize() : void
      {
         backgroundCtr.height = this.lbl_content.contentHeight + this._margin * 2;
      }
      
      protected function onTimerDisplay(event:TimerEvent) : void
      {
         this._timerDisplay.removeEventListener(TimerEvent.TIMER,this.onTimerDisplay);
         mainCtr.visible = true;
      }
      
      public function updateContent(params:Object) : void
      {
         this.lbl_content.text = params.tooltip.htmlText;
         this.updateTooltipSize();
      }
      
      private function onTimerHide(e:TimerEvent) : void
      {
         this._timerHide.removeEventListener(TimerEvent.TIMER,this.onTimerHide);
         this._timerHide.stop();
         uiApi.hideTooltip(this._tooltipName);
      }
      
      public function unload() : void
      {
         if(this._timerDisplay !== null)
         {
            this._timerDisplay.removeEventListener(TimerEvent.TIMER,this.onTimerDisplay);
            this._timerDisplay.stop();
            this._timerDisplay = null;
         }
         if(this._timerHide !== null)
         {
            this._timerHide.removeEventListener(TimerEvent.TIMER,this.onTimerHide);
            this._timerHide.stop();
            this._timerHide = null;
         }
         if(sysApi !== null)
         {
            sysApi.removeHook(BeriliaHookList.UiLoaded);
         }
         this._alteration = null;
         this._mainParams = null;
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         if(target !== btnMenu)
         {
            super.onRelease(target);
            return;
         }
         var contextMenu:ContextMenuData = menuApi.create(this._alteration,"alteration",[null,uiApi.me().name]);
         modContextMenu.createContextMenu(contextMenu);
      }
      
      private function onAlterationRemoved(removedAlteration:AlterationWrapper) : void
      {
         if(removedAlteration.id === this._alteration.id)
         {
            uiApi.unloadUi(uiApi.me().name);
         }
      }
   }
}
