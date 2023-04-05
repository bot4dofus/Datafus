package com.ankamagames.tiphon.sequence
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.tiphon.events.TiphonEvent;
   
   public class WaitAnimationEventStep extends AbstractSequencable
   {
       
      
      private var _targetStep:PlayAnimationStep;
      
      private var _initOk:Boolean;
      
      private var _waitedEvent:String;
      
      private var _released:Boolean;
      
      private var _waiting:Boolean;
      
      public function WaitAnimationEventStep(animStep:PlayAnimationStep, waitedEvent:String = "animation_event_end")
      {
         super();
         animStep.target.addEventListener(TiphonEvent.ANIMATION_EVENT,this.onEvent);
         this._waitedEvent = waitedEvent;
         this._targetStep = animStep;
         this._initOk = true;
      }
      
      override public function start() : void
      {
         if(!this._targetStep || !this._targetStep.target)
         {
            executeCallbacks();
            return;
         }
         if(!this._initOk || this._released || this._targetStep.animation != this._targetStep.target.getAnimation())
         {
            this._targetStep.target.removeEventListener(TiphonEvent.ANIMATION_EVENT,this.onEvent);
            this._targetStep = null;
            executeCallbacks();
         }
         else
         {
            this._waiting = true;
         }
      }
      
      private function onEvent(e:TiphonEvent) : void
      {
         if(e && e.type == this._waitedEvent || this._targetStep.animation != this._targetStep.target.getAnimation())
         {
            this._released = true;
            if(this._targetStep)
            {
               this._targetStep.target.removeEventListener(TiphonEvent.ANIMATION_EVENT,this.onEvent);
            }
            this._targetStep = null;
            if(this._waiting)
            {
               executeCallbacks();
            }
         }
      }
      
      override public function toString() : String
      {
         return "Waiting event [" + this._waitedEvent + "] for " + this._targetStep;
      }
   }
}
