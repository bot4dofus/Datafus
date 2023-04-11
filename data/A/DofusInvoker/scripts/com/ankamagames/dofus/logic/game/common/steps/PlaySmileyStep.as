package com.ankamagames.dofus.logic.game.common.steps
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.dofus.internalDatacenter.communication.SmileyWrapper;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import flash.events.TimerEvent;
   
   public class PlaySmileyStep extends AbstractSequencable
   {
       
      
      private var _entity:AnimatedCharacter;
      
      private var _smileyId:int;
      
      private var _waitForEnd:Boolean;
      
      private var _timer:BenchmarkTimer;
      
      public function PlaySmileyStep(pEntity:AnimatedCharacter, pSmileyId:int, pWaitForEnd:Boolean)
      {
         super();
         this._entity = pEntity;
         this._smileyId = pSmileyId;
         this._waitForEnd = pWaitForEnd;
      }
      
      override public function start() : void
      {
         var sw:SmileyWrapper = new SmileyWrapper();
         sw.id = this._smileyId;
         if(this._waitForEnd)
         {
            this._timer = new BenchmarkTimer(ProtocolConstantsEnum.DEFAULT_TOOLTIP_DURATION,0,"PlaySmileyStep._timer");
            this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
            this._timer.start();
         }
         TooltipManager.show(sw,this._entity.absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),true,"smiley" + this._entity.id,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,null,null,null,null,false,StrataEnum.STRATA_WORLD,Atouin.getInstance().currentZoom);
         if(!this._waitForEnd)
         {
            executeCallbacks();
         }
      }
      
      override public function clear() : void
      {
         if(this._timer)
         {
            this._timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
         }
         TooltipManager.hide("smiley" + this._entity.id);
      }
      
      private function onTimer(pEvent:TimerEvent) : void
      {
         pEvent.currentTarget.removeEventListener(TimerEvent.TIMER,this.onTimer);
         executeCallbacks();
      }
   }
}
