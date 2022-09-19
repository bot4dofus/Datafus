package Ankama_Tooltips.ui
{
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.uiApi.AveragePricesApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.events.TimerEvent;
   
   public class ItemNameTooltipUi
   {
      
      private static var _shortcutColor:String;
       
      
      private var _timerHide:BenchmarkTimer;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="AveragePricesApi")]
      public var averagePricesApi:AveragePricesApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      public var backgroundCtr:GraphicContainer;
      
      public var lbl_content:Label;
      
      private var _itemWrapper:Object;
      
      private var _shortcutKey:String;
      
      private var _timerShowItemTooltip:BenchmarkTimer;
      
      private var _param:Object;
      
      private var _alwaysShowTooltipModuleException:Array;
      
      public function ItemNameTooltipUi()
      {
         this._alwaysShowTooltipModuleException = ["giftMenu"];
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         var delay:int = 0;
         if(!_shortcutColor)
         {
            _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
            _shortcutColor = _shortcutColor.replace("0x","#");
         }
         this._param = oParam;
         var displayItemToolTip:Boolean = this.sysApi.getOption("itemTooltipDelay","dofus") != -1 && (this._param.makerParam.hasOwnProperty("nameOnly") && !this._param.makerParam.nameOnly || (!this._param.makerParam.hasOwnProperty("nameOnly") || this._alwaysShowTooltipModuleException.indexOf(this._param.tooltip.uiModuleName) != -1));
         var text:String = "";
         if(this._param.data != null && this._param.data is Item)
         {
            this._itemWrapper = this._param.data;
            text = this._itemWrapper.name;
         }
         else
         {
            this._itemWrapper = this._param.data.itemWrapper;
            this._shortcutKey = this._param.data.shortcutKey;
            text = this._itemWrapper.name;
            if(this._shortcutKey && this._shortcutKey != "")
            {
               text += " <font color=\'" + _shortcutColor + "\'>(" + this._shortcutKey + ")</font>";
            }
         }
         this.lbl_content.text = text;
         if(this.sysApi.isInGame() && !displayItemToolTip && this._itemWrapper.exchangeable)
         {
            this.lbl_content.appendText(this.averagePricesApi.getItemAveragePriceString(this._itemWrapper));
         }
         this.lbl_content.multiline = true;
         this.lbl_content.wordWrap = false;
         this.lbl_content.fullWidthAndHeight();
         this.backgroundCtr.width = this.lbl_content.textfield.width + 12;
         this.backgroundCtr.height = this.lbl_content.textfield.height + 12;
         this.tooltipApi.place(this._param.position,this._param.showDirectionalArrow,this._param.point,this._param.relativePoint,this._param.offset);
         if(displayItemToolTip)
         {
            delay = this.sysApi.getOption("itemTooltipDelay","dofus");
            this._timerShowItemTooltip = new BenchmarkTimer(delay,1,"ItemNameTooltipUi._timerShowItemTooltip");
            this._timerShowItemTooltip.addEventListener(TimerEvent.TIMER,this.onTimer);
            this._timerShowItemTooltip.start();
         }
      }
      
      public function unload() : void
      {
         this.removeTimer();
      }
      
      private function onTimer(e:TimerEvent) : void
      {
         this.removeTimer();
         this.uiApi.showTooltip(this._itemWrapper,this._param.makerParam.hasOwnProperty("ref") && this._param.makerParam.ref != null ? this._param.makerParam.ref : this._param.position,false,"standard",this._param.point,this._param.relativePoint,this._param.offset,null,null,this._param.makerParam);
      }
      
      private function removeTimer() : void
      {
         if(this._timerShowItemTooltip)
         {
            this._timerShowItemTooltip.stop();
            this._timerShowItemTooltip.removeEventListener(TimerEvent.TIMER,this.onTimer);
            this._timerShowItemTooltip = null;
         }
      }
   }
}
