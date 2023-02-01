package com.ankamagames.tiphon.sequence
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.getQualifiedClassName;
   import flash.utils.setTimeout;
   
   public class PlayAnimationStep extends AbstractSequencable
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(PlayAnimationStep));
       
      
      private var _target:TiphonSprite;
      
      private var _animationName:String;
      
      private var _startFrame:int = -1;
      
      private var _loop:int;
      
      private var _endEvent:String;
      
      private var _waitEvent:Boolean;
      
      private var _endAnimationName:String;
      
      private var _lastSpriteAnimation:String;
      
      private var _backToLastAnimationAtEnd:Boolean;
      
      private var _callbackExecuted:Boolean = false;
      
      public function PlayAnimationStep(target:TiphonSprite, animationName:String, backToLastAnimationAtEnd:Boolean = true, waitEvent:Boolean = true, eventEnd:String = "animation_event_end", loop:int = 1, endAnimationName:String = "")
      {
         super();
         this._endEvent = eventEnd;
         this._target = target;
         this._animationName = animationName;
         this._loop = loop;
         this._waitEvent = waitEvent;
         this._backToLastAnimationAtEnd = backToLastAnimationAtEnd;
         this._endAnimationName = endAnimationName;
      }
      
      public function get target() : TiphonSprite
      {
         return this._target;
      }
      
      public function get animation() : String
      {
         return this._animationName;
      }
      
      public function set animation(anim:String) : void
      {
         this._animationName = anim;
      }
      
      public function set waitEvent(v:Boolean) : void
      {
         this._waitEvent = v;
      }
      
      public function set startFrame(frame:int) : void
      {
         this._startFrame = frame;
      }
      
      override public function start() : void
      {
         var s:* = null;
         if(!this._target)
         {
            this._callbackExecuted = true;
            executeCallbacks();
            this.onAnimationEnd(null);
            return;
         }
         this._target.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
         this._target.addEventListener(TiphonEvent.ADDED_IN_POOL,this.onAddedInPool);
         if(this._target.isShowingOnlyBackground())
         {
            this._callbackExecuted = true;
            executeCallbacks();
            return;
         }
         if(this._endEvent != TiphonEvent.ANIMATION_END)
         {
            this._target.addEventListener(this._endEvent,this.onCustomEvent);
         }
         this._target.addEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
         this._target.addEventListener(TiphonEvent.RENDER_FAILED,this.onAnimationFail);
         this._target.addEventListener(TiphonEvent.SPRITE_INIT_FAILED,this.onAnimationFail);
         this._target.overrideNextAnimation = true;
         var directions:Array = this._target.getAvaibleDirection(this._animationName,true);
         if(!directions[this._target.getDirection()])
         {
            for(s in directions)
            {
               if(directions[s])
               {
                  this._target.setDirection(uint(s));
                  break;
               }
            }
         }
         this._target.setAnimation(this._animationName,this._startFrame);
         this._lastSpriteAnimation = this._target.getAnimation();
         if(!this._waitEvent)
         {
            this._callbackExecuted = true;
            executeCallbacks();
         }
      }
      
      private function onCustomEvent(e:TiphonEvent) : void
      {
         this._target.removeEventListener(this._endEvent,this.onCustomEvent);
         this._callbackExecuted = true;
         executeCallbacks();
      }
      
      private function onAnimationFail(e:TiphonEvent) : void
      {
         if(this._endEvent != TiphonEvent.ANIMATION_END)
         {
            this.onCustomEvent(e);
         }
         this.onAnimationEnd(e);
      }
      
      private function onRemoveFromStage(e:Event) : void
      {
         var subEntity:TiphonSprite = null;
         var playingAnim:Boolean = this._target.isPlayingAnimation();
         var subEntities:Array = this._target.getSubEntitiesList();
         if(!playingAnim && subEntities && subEntities.length > 0)
         {
            for each(subEntity in subEntities)
            {
               if(subEntity.isPlayingAnimation())
               {
                  playingAnim = true;
                  break;
               }
            }
         }
         if(!playingAnim)
         {
            setTimeout(this.onAnimationEnd,1,e);
         }
      }
      
      private function onAddedInPool(e:TiphonEvent) : void
      {
         var subEntity:TiphonSprite = null;
         var playingAnim:Boolean = this._target.isPlayingAnimation();
         var subEntities:Array = this._target.getSubEntitiesList();
         if(!playingAnim && subEntities && subEntities.length > 0)
         {
            for each(subEntity in subEntities)
            {
               if(subEntity.isPlayingAnimation())
               {
                  playingAnim = true;
                  break;
               }
            }
         }
         if(!playingAnim)
         {
            setTimeout(this.onAnimationEnd,1,e);
         }
      }
      
      private function onAnimationEnd(e:Event) : void
      {
         var currentSpriteAnimation:String = null;
         if(this._target)
         {
            if(this._loop > 0)
            {
               --this._loop;
            }
            if(this._loop > 0 || this._loop == -1)
            {
               this._target.setAnimation(this._animationName);
               return;
            }
            if(this._endEvent != TiphonEvent.ANIMATION_END)
            {
               this._target.removeEventListener(this._endEvent,this.onCustomEvent);
            }
            this._target.removeEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
            this._target.removeEventListener(TiphonEvent.RENDER_FAILED,this.onAnimationEnd);
            this._target.removeEventListener(TiphonEvent.SPRITE_INIT_FAILED,this.onAnimationFail);
            this._target.removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
            this._target.removeEventListener(TiphonEvent.ADDED_IN_POOL,this.onAddedInPool);
            currentSpriteAnimation = this._target.getAnimation();
            if(this._backToLastAnimationAtEnd)
            {
               if(currentSpriteAnimation && this._lastSpriteAnimation && this._lastSpriteAnimation.indexOf(currentSpriteAnimation) != -1)
               {
                  if(this._endAnimationName)
                  {
                     this._target.setAnimation(this._endAnimationName);
                  }
                  else if(this._target.hasAnimation("AnimStatique"))
                  {
                     this._target.setAnimation("AnimStatique");
                  }
               }
            }
         }
         if(!this._callbackExecuted)
         {
            executeCallbacks();
         }
      }
      
      override public function toString() : String
      {
         return "play " + this._animationName + " on " + (!!this._target ? this._target.name : this._target);
      }
      
      override protected function onTimeOut(e:TimerEvent) : void
      {
         this._callbackExecuted = true;
         this.onAnimationEnd(null);
         super.onTimeOut(e);
      }
   }
}
