package Ankama_Tooltips.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.dofus.internalDatacenter.communication.DelayedActionItem;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class DelayedActionTooltipUi
   {
       
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      public var delayedActionBackground:Texture;
      
      private var _currentTargetTs:Number;
      
      private var _targetTs:Number;
      
      private var _lastTs:Number;
      
      public function DelayedActionTooltipUi()
      {
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         if(oParam.zoom > 1)
         {
            this.uiApi.me().scaleX = oParam.zoom;
            this.uiApi.me().scaleY = oParam.zoom;
         }
         this._currentTargetTs = 0;
         this._targetTs = DelayedActionItem(oParam.data).endTime;
         this._lastTs = getTimer();
         this.sysApi.addEventListener(this.updateProgress,"delayed item use tooltip");
         this.tooltipApi.place(oParam.position,oParam.showDirectionalArrow,oParam.point,oParam.relativePoint,oParam.offset);
      }
      
      private function updateProgress(e:Event) : void
      {
         this._currentTargetTs += getTimer() - this._lastTs;
         this._lastTs = getTimer();
         var prc:uint = Math.min(100,Math.ceil(this._currentTargetTs / this._targetTs * 100));
         this.delayedActionBackground.gotoAndStop = prc;
      }
      
      public function unload() : void
      {
         this.sysApi.removeEventListener(this.updateProgress);
      }
   }
}
