package Ankama_Tooltips.ui
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.makers.ItemTooltipMaker;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.types.shortcut.Bind;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   
   public class ItemTooltipUi extends TooltipPinableBaseUi
   {
      
      protected static var MARGIN:int;
      
      private static const TOOLTIP_ITEM_COMPARE:String = "tooltip_itemCompare";
      
      private static const TOOLTIP_STANDARD:String = "tooltip_standard";
      
      private static const KEY_GREATER_THAN:int = 226;
      
      private static const KEY_FOR_COMPARE:uint = Keyboard.SHIFT;
      
      private static var _compareTooltips:Array;
       
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="BindsApi")]
      public var bindsApi:BindsApi;
      
      public var lbl_content:Label;
      
      public var tx_icon:Texture;
      
      public var tx_iconbg:TextureBitmap;
      
      public var tx_importantNoticeIcon:Texture;
      
      private var _timerHide:BenchmarkTimer;
      
      private var _timerCompare:BenchmarkTimer;
      
      private var _timerDisplay:BenchmarkTimer;
      
      private var _item:Object;
      
      private var _equippedItems:Object;
      
      private var _ctrlKeyIsDown:Boolean = false;
      
      private var _compareKeyIsDown:Boolean = false;
      
      private var _ttOffset:Number;
      
      private var _mainParams:Object;
      
      private var _isEquipped:Boolean = false;
      
      private var _htmlTextWithoutTheoreticalEffects:String;
      
      private var _htmlTextWitTheoreticalEffects:String;
      
      private var _hasShortDescription:Boolean = false;
      
      private var _tooltipName:String;
      
      private var _indexCompare:int = 0;
      
      private var _comparableItems:Array;
      
      public function ItemTooltipUi()
      {
         super();
      }
      
      override public function main(oParam:Object = null) : void
      {
         var colorStr:* = undefined;
         var displayDelay:int = 0;
         this._equippedItems = inventoryApi.getEquipement();
         if(this.tx_icon)
         {
            this.tx_iconbg.x = backgroundCtr.width - 18 - this.tx_iconbg.width;
            this.tx_iconbg.y = 21;
            this.tx_icon.x = 10 + this.tx_iconbg.x;
            this.tx_icon.y = 10 + this.tx_iconbg.y;
            this.tx_iconbg.visible = true;
            this.tx_icon.visible = true;
         }
         MARGIN = this.lbl_content.x;
         this._tooltipName = uiApi.me().name;
         this._item = oParam.data;
         this._mainParams = oParam;
         if(oParam.data != null && oParam.data is Item)
         {
            this._item = oParam.data;
         }
         else
         {
            this._item = oParam.data.itemWrapper;
         }
         this.onFontActiveTypeChanged();
         this.lbl_content.multiline = true;
         this.lbl_content.text = oParam.tooltip.htmlText;
         if(this.tx_icon)
         {
            this.tx_icon.uri = this._item.fullSizeIconUri;
         }
         if(this._tooltipName == "tooltip_Hyperlink")
         {
            uiApi.addComponentHook(backgroundCtr,"onRelease");
            uiApi.addComponentHook(backgroundCtr,"onRollOver");
            uiApi.addComponentHook(backgroundCtr,"onRollOut");
            uiApi.addComponentHook(backgroundCtr,"onRightClick");
            backgroundCtr.buttonMode = true;
            backgroundCtr.useHandCursor = true;
         }
         var updatePosition:Boolean = false;
         if(this._tooltipName.indexOf("tooltip_compare") == 0)
         {
            colorStr = Api.system.getConfigEntry("colors.grid.title");
            backgroundCtr.borderColor = parseInt(colorStr);
            if(this.tx_icon)
            {
               this.tx_icon.y = 36 + MARGIN;
            }
         }
         else
         {
            updatePosition = true;
         }
         sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
         sysApi.addHook(BeriliaHookList.KeyDown,this.onKeyDown);
         sysApi.addHook(HookList.FontActiveTypeChanged,this.onFontActiveTypeChanged);
         this._ctrlKeyIsDown = sysApi.isKeyDown(Keyboard.CONTROL);
         if(this._tooltipName == TOOLTIP_STANDARD)
         {
            sysApi.addHook(BeriliaHookList.UiLoaded,this.onTooltipItemCompareLoaded);
         }
         if(oParam.autoHide)
         {
            this._timerHide = new BenchmarkTimer(ProtocolConstantsEnum.DEFAULT_TOOLTIP_DURATION,0,"ItemTooltipUi._timerHide");
            this._timerHide.addEventListener(TimerEvent.TIMER,this.onTimerHide);
            this._timerHide.start();
         }
         if(uiApi.me().height > uiApi.getStageHeight() && this._item.description)
         {
            this.lbl_content.text = this.shortenDescriptionFromHtmlText(this._mainParams.tooltip.htmlText);
            updatePosition = true;
         }
         if(this._mainParams.makerParam && this._mainParams.makerParam.hasOwnProperty("addTheoreticalEffects") && !this.hasTheoreticalEffectsOnly)
         {
            if(this._mainParams.makerParam.addTheoreticalEffects)
            {
               if(this.lbl_content.htmlText.indexOf("<p class=\'footerright\'></p>") == -1)
               {
                  sysApi.dispatchHook(CustomUiHookList.ShowTheoreticalEffects);
               }
               this._htmlTextWitTheoreticalEffects = this.lbl_content.htmlText;
            }
            else
            {
               this._htmlTextWithoutTheoreticalEffects = this.lbl_content.htmlText;
            }
         }
         this.updateTooltipSize();
         if(updatePosition)
         {
            this.tooltipApi.place(oParam.position,oParam.showDirectionalArrow,oParam.point,oParam.relativePoint,oParam.offset);
         }
         this.setimportantNoticeIcon();
         super.main(oParam);
         if((!oParam || !oParam.makerParam || !oParam.makerParam.hasOwnProperty("pinnable") || !oParam.makerParam.pinnable) && !isPin)
         {
            displayDelay = sysApi.getOption("itemTooltipDelay","dofus");
            if(displayDelay > 0)
            {
               mainCtr.visible = false;
               this._timerDisplay = new BenchmarkTimer(displayDelay,0,"ItemTooltipUi._timerDisplay");
               this._timerDisplay.addEventListener(TimerEvent.TIMER,this.onTimerDisplay);
               this._timerDisplay.start();
            }
            else if(displayDelay == -1)
            {
               mainCtr.visible = false;
            }
         }
      }
      
      private function setimportantNoticeIcon() : void
      {
         if(this.tx_importantNoticeIcon === null)
         {
            return;
         }
         var importantNotice:String = this._item.importantNotice;
         if(importantNotice)
         {
            importantNotice = importantNotice.replace(/^\s+|\s+$/g,"");
         }
         if(!importantNotice)
         {
            this.tx_importantNoticeIcon.visible = false;
            return;
         }
         var importantNoticePos:Number = this.lbl_content.text.replace(/(\r\n|\r|\n)/g,"\n").indexOf(importantNotice);
         var importantNoticeOffset:Rectangle = this.lbl_content.getCharBoundaries(importantNoticePos);
         if(importantNoticeOffset === null)
         {
            this.tx_importantNoticeIcon.visible = false;
            return;
         }
         this.tx_importantNoticeIcon.visible = true;
         var offsetX:Number = parseInt(uiApi.me().getConstant("importantNoticeIconXOffset"));
         var offsetY:Number = parseInt(uiApi.me().getConstant("importantNoticeIconYOffset"));
         if(isNaN(offsetX))
         {
            offsetX = 0;
         }
         if(isNaN(offsetY))
         {
            offsetY = 0;
         }
         this.tx_importantNoticeIcon.x = offsetX;
         this.tx_importantNoticeIcon.y = offsetY + importantNoticeOffset.y;
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
         if(uiApi.me().height > uiApi.getStageHeight() && this._item.description)
         {
            this.lbl_content.text = this.shortenDescriptionFromHtmlText(this._mainParams.tooltip.htmlText);
         }
         this.updateTooltipSize();
      }
      
      private function updateTooltipSize() : void
      {
         backgroundCtr.height = this.lbl_content.contentHeight + MARGIN * 2;
      }
      
      protected function onTimerDisplay(event:TimerEvent) : void
      {
         this._timerDisplay.removeEventListener(TimerEvent.TIMER,this.onTimerDisplay);
         mainCtr.visible = true;
      }
      
      protected function onTimerCompare(event:TimerEvent) : void
      {
         var i:uint = 0;
         var item:ItemWrapper = null;
         this._timerCompare.removeEventListener(TimerEvent.TIMER,this.onTimerCompare);
         if(!this._isEquipped)
         {
            _compareTooltips = [];
            this._ttOffset = 6;
            i = 0;
            for each(item in this._equippedItems)
            {
               if(item)
               {
                  if(item.type && this._item.type && item.type.superTypeId == this._item.type.superTypeId)
                  {
                     _compareTooltips.push("tooltip_compare" + i);
                     uiApi.showTooltip(item,new Rectangle(),false,"compare" + i,LocationEnum.POINT_TOPRIGHT,LocationEnum.POINT_TOPLEFT,this._ttOffset,"item",null,{
                        "header":true,
                        "description":false,
                        "equipped":true
                     },null,false,4,1,"Ankama_Tooltips");
                     i++;
                  }
               }
            }
            if(_compareTooltips.length > 0)
            {
               if(uiApi.getUi(_compareTooltips[_compareTooltips.length - 1]))
               {
                  this.tooltipApi.adjustTooltipPositions(_compareTooltips,TOOLTIP_STANDARD,this._ttOffset);
               }
               else
               {
                  sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
               }
            }
         }
      }
      
      protected function compareItem() : void
      {
         if(this._tooltipName == TOOLTIP_ITEM_COMPARE || this._equippedItems.indexOf(this._item) >= 0)
         {
            return;
         }
         this.getItemsWithSameType();
         if(this._comparableItems.length == 0)
         {
            return;
         }
         if(this._indexCompare >= this._comparableItems.length)
         {
            this._indexCompare = 0;
         }
         else if(this._indexCompare < 0)
         {
            this._indexCompare = this._comparableItems.length - 1;
         }
         uiApi.showTooltip(this._comparableItems[this._indexCompare],uiApi.me(),false,"itemCompare",LocationEnum.POINT_TOPRIGHT,LocationEnum.POINT_TOPLEFT,0,null,null,{
            "header":true,
            "description":false,
            "equipped":false,
            "noFooter":true
         });
      }
      
      private function getItemsWithSameType() : void
      {
         var item:Item = null;
         this._comparableItems = [];
         for each(item in this._equippedItems)
         {
            if(item && item.type && this._item.type && item.type.superTypeId == this._item.type.superTypeId)
            {
               this._comparableItems.push(item);
            }
         }
      }
      
      private function hideCompareItemTooltips() : void
      {
         uiApi.hideTooltip(TOOLTIP_ITEM_COMPARE);
      }
      
      override protected function makePin() : void
      {
         btnClose.x = this.tx_iconbg.x + this.tx_iconbg.width + 7;
         btnClose.y = this.tx_iconbg.y - 2;
         btnMenu.x = btnClose.x;
         btnMenu.y = btnClose.y + 40;
         backgroundCtr.width = 460;
         super.makePin();
      }
      
      public function onKeyUp(target:DisplayObject, keyCode:uint) : void
      {
         if(keyCode == Keyboard.CONTROL && !this.hasTheoreticalEffectsOnly && !sysApi.getOption("alwaysDisplayTheoreticalEffectsInTooltip","dofus"))
         {
            this._ctrlKeyIsDown = false;
            this.hideTheoreticalEffects();
         }
         if(keyCode == KEY_FOR_COMPARE)
         {
            this.disableShortcutForComparison(false);
            this._compareKeyIsDown = false;
            this.hideCompareItemTooltips();
         }
         if(this._compareKeyIsDown && keyCode == KEY_GREATER_THAN && this._tooltipName == TOOLTIP_STANDARD)
         {
            this.hideCompareItemTooltips();
            ++this._indexCompare;
            this.compareItem();
         }
      }
      
      public function onKeyDown(target:DisplayObject, keyCode:uint) : void
      {
         if(!this._ctrlKeyIsDown && keyCode == Keyboard.CONTROL && !this.hasTheoreticalEffectsOnly && this.lbl_content.text != this._htmlTextWitTheoreticalEffects && !sysApi.getOption("alwaysDisplayTheoreticalEffectsInTooltip","dofus") && !this.bindsApi.getShortcutByName("showTheoreticalEffects").disable)
         {
            this._ctrlKeyIsDown = true;
            this.showTheoreticalEffects();
         }
         if(!this._compareKeyIsDown && keyCode == KEY_FOR_COMPARE && this._tooltipName == TOOLTIP_STANDARD)
         {
            this.disableShortcutForComparison(true);
            this._compareKeyIsDown = true;
            this.compareItem();
         }
      }
      
      public function onRightClick(target:GraphicContainer) : void
      {
         var contextMenu:ContextMenuData = null;
         if(this._item)
         {
            contextMenu = menuApi.create(this._item);
            if(contextMenu.content.length > 0)
            {
               modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         backgroundCtr.filters = new Array(new GlowFilter(sysApi.getConfigEntry("colors.text.glow.red"),1,5,5,2,3));
         uiApi.showTooltip(uiApi.textTooltipInfo(uiApi.getText("ui.common.close")),target,false,"close_tooltip",7,1,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         backgroundCtr.filters = [];
         uiApi.hideTooltip("close_tooltip");
      }
      
      public function onTooltipItemCompareLoaded(name:String) : void
      {
         var offsetX:uint = 0;
         var offsetY:uint = 0;
         var finalX:int = 0;
         var tooltipCompare:UiRootContainer = uiApi.getUi(TOOLTIP_ITEM_COMPARE);
         var tooltipStandard:UiRootContainer = uiApi.getUi(TOOLTIP_STANDARD);
         if(tooltipCompare && tooltipStandard)
         {
            offsetX = 10;
            offsetY = 100;
            finalX = tooltipStandard.x - tooltipCompare.width - offsetX;
            if(finalX >= 0)
            {
               tooltipCompare.x = finalX;
            }
            else
            {
               tooltipCompare.x = tooltipStandard.x + tooltipStandard.width + offsetX;
            }
            if(tooltipStandard.y + tooltipCompare.height > uiApi.getStageHeight() - offsetY)
            {
               tooltipCompare.y = tooltipStandard.y - (tooltipCompare.height - tooltipStandard.height);
            }
            else
            {
               tooltipCompare.y = tooltipStandard.y;
            }
         }
      }
      
      public function onUiLoaded(name:String) : void
      {
         if(name == _compareTooltips[_compareTooltips.length - 1])
         {
            this.tooltipApi.adjustTooltipPositions(_compareTooltips,TOOLTIP_STANDARD,this._ttOffset);
            sysApi.removeHook(BeriliaHookList.UiLoaded);
         }
      }
      
      public function updateContent(oParam:Object) : void
      {
         this.lbl_content.text = oParam.tooltip.htmlText;
         this.updateTooltipSize();
      }
      
      private function shortenDescriptionFromHtmlText(htmlText:String) : String
      {
         this._hasShortDescription = true;
         var fullText:String = htmlText;
         var indexOfDescriptionStartTag:int = fullText.indexOf("<p class=\'quote\'>" + 17);
         return fullText.replace(this._item.description,"[" + String.fromCharCode(8230) + "]");
      }
      
      private function showTheoreticalEffects() : void
      {
         var maker:ItemTooltipMaker = null;
         var tooltip:* = undefined;
         if(!this._htmlTextWitTheoreticalEffects)
         {
            maker = new ItemTooltipMaker();
            if(this._mainParams.makerParam)
            {
               this._mainParams.makerParam.addTheoreticalEffects = true;
            }
            tooltip = maker.createTooltip(this._item,this._mainParams.makerParam);
            this._htmlTextWitTheoreticalEffects = tooltip.updateAndReturnHtmlText();
            if(this._hasShortDescription)
            {
               this._htmlTextWitTheoreticalEffects = this.shortenDescriptionFromHtmlText(this._htmlTextWitTheoreticalEffects);
            }
         }
         this.lbl_content.text = this._htmlTextWitTheoreticalEffects;
         if(this.lbl_content.htmlText.indexOf("<p class=\'footerright\'></p>") == -1)
         {
            sysApi.dispatchHook(CustomUiHookList.ShowTheoreticalEffects);
         }
         this.updateTooltipSize();
      }
      
      private function hideTheoreticalEffects() : void
      {
         var maker:ItemTooltipMaker = null;
         var tooltip:* = undefined;
         if(!this._htmlTextWithoutTheoreticalEffects)
         {
            maker = new ItemTooltipMaker();
            if(this._mainParams.makerParam)
            {
               this._mainParams.makerParam.addTheoreticalEffects = false;
            }
            tooltip = maker.createTooltip(this._item,this._mainParams.makerParam);
            this._htmlTextWithoutTheoreticalEffects = tooltip.updateAndReturnHtmlText();
            if(this._hasShortDescription)
            {
               this._htmlTextWithoutTheoreticalEffects = this.shortenDescriptionFromHtmlText(this._htmlTextWithoutTheoreticalEffects);
            }
         }
         this.lbl_content.text = this._htmlTextWithoutTheoreticalEffects;
         this.updateTooltipSize();
      }
      
      private function get hasTheoreticalEffectsOnly() : Boolean
      {
         if(this._mainParams.makerParam && this._mainParams.makerParam.hasOwnProperty("showEffects"))
         {
            return this._mainParams.makerParam.showEffects;
         }
         return false;
      }
      
      private function onTimerHide(e:TimerEvent) : void
      {
         this._timerHide.removeEventListener(TimerEvent.TIMER,this.onTimerHide);
         this._timerHide.stop();
         uiApi.hideTooltip(this._tooltipName);
      }
      
      private function hideCompareTooltips() : void
      {
         var tooltipName:String = null;
         if(_compareTooltips)
         {
            for each(tooltipName in _compareTooltips)
            {
               uiApi.hideTooltip(tooltipName.replace("tooltip_",""));
            }
            _compareTooltips = null;
         }
      }
      
      private function disableShortcutForComparison(value:Boolean) : void
      {
         var bind:Bind = this.bindsApi.getShortcutBind("bannerNextTab",true);
         this.bindsApi.setBindDisabled(bind,value);
      }
      
      public function unload() : void
      {
         if(this._timerDisplay)
         {
            this._timerDisplay.removeEventListener(TimerEvent.TIMER,this.onTimerDisplay);
            this._timerDisplay.stop();
            this._timerDisplay = null;
         }
         if(this._timerCompare)
         {
            this._timerCompare.removeEventListener(TimerEvent.TIMER,this.onTimerCompare);
            this._timerCompare.stop();
            this._timerCompare = null;
         }
         if(this._timerHide)
         {
            this._timerHide.removeEventListener(TimerEvent.TIMER,this.onTimerHide);
            this._timerHide.stop();
            this._timerHide = null;
         }
         if(uiApi && uiApi.me().name.indexOf("compare") == -1)
         {
            this.hideCompareTooltips();
         }
         if(uiApi && uiApi.me().name == TOOLTIP_STANDARD)
         {
            this.hideCompareItemTooltips();
            this.disableShortcutForComparison(false);
         }
         this._compareKeyIsDown = false;
         if(sysApi)
         {
            sysApi.removeHook(BeriliaHookList.KeyUp);
            sysApi.removeHook(BeriliaHookList.KeyDown);
            sysApi.removeHook(BeriliaHookList.UiLoaded);
         }
         this._equippedItems = null;
         this._item = null;
         this._mainParams = null;
      }
   }
}
