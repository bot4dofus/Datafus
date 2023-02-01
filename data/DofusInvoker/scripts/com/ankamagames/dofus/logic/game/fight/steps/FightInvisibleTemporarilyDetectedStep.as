package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.filters.BlurFilter;
   import flash.geom.ColorTransform;
   
   public class FightInvisibleTemporarilyDetectedStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _duplicateSprite:AnimatedCharacter;
      
      private var _cellId:int;
      
      private var _fadeTimer:BenchmarkTimer;
      
      private var _targetId:Number;
      
      public function FightInvisibleTemporarilyDetectedStep(target:AnimatedCharacter, cellId:int)
      {
         super();
         this._targetId = target.id;
         var id:Number = EntitiesManager.getInstance().getFreeEntityId();
         this._duplicateSprite = new AnimatedCharacter(id,target.look.clone());
         this._cellId = cellId;
         this._fadeTimer = new BenchmarkTimer(25,40,"FightInvisibleTemporarilyDetectedStep._fadeTimer");
         this._fadeTimer.addEventListener(TimerEvent.TIMER,this.onFade);
      }
      
      public function get stepType() : String
      {
         return "invisibleTemporarilyDetected";
      }
      
      override public function start() : void
      {
         this._duplicateSprite.filters = [new BlurFilter(5,5)];
         this._duplicateSprite.transform.colorTransform = new ColorTransform(0,0,0,1,30,30,30);
         EntitiesDisplayManager.getInstance().displayEntity(this._duplicateSprite,MapPoint.fromCellId(this._cellId));
         this._fadeTimer.start();
         executeCallbacks();
      }
      
      override public function clear() : void
      {
         if(this._fadeTimer)
         {
            this._fadeTimer.removeEventListener(TimerEvent.TIMER,this.onFade);
            this._fadeTimer = null;
            EntitiesDisplayManager.getInstance().removeEntity(this._duplicateSprite);
            this._duplicateSprite.destroy();
            this._duplicateSprite = null;
         }
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._targetId];
      }
      
      private function onFade(e:Event) : void
      {
         if(!this._duplicateSprite)
         {
            return;
         }
         this._duplicateSprite.alpha -= 0.025;
         if(this._duplicateSprite.alpha < 0.025)
         {
            this.clear();
         }
      }
   }
}
