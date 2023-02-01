package com.ankamagames.tiphon.types
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
   import com.ankamagames.jerakine.utils.display.FpsControler;
   import com.ankamagames.tiphon.display.TiphonAnimation;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.engine.TiphonFpsManager;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class ScriptedAnimation extends TiphonAnimation
   {
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ScriptedAnimation));
      
      public static var currentSpriteHandler:IAnimationSpriteHandler;
      
      private static const EVENT_SHOT:String = "SHOT";
      
      private static const EVENT_END:String = "END";
      
      private static const PLAYER_STOP:String = "STOP";
      
      private static const EVENTS:Object = {
         "SHOT":TiphonEvent.ANIMATION_SHOT,
         "END":TiphonEvent.ANIMATION_END,
         "DESTROY":TiphonEvent.ANIMATION_DESTROY
      };
       
      
      public var SHOT:String;
      
      public var END:String;
      
      public var destroyed:Boolean = false;
      
      private var events:Array;
      
      private var anims:Array;
      
      private var _displayInfoSprite:Dictionary;
      
      private var _lastFrame:int = -1;
      
      public var bone:int;
      
      public var animationName:String;
      
      public var direction:int;
      
      public function ScriptedAnimation()
      {
         this.events = [];
         this.anims = [];
         this._displayInfoSprite = new Dictionary(true);
         super();
         FpsManager.getInstance().watchObject(this,false,"ScriptedAnimation");
         this.setDisplayInfoSprite();
         this.init();
      }
      
      public function init() : void
      {
         var animationName:* = null;
         spriteHandler = currentSpriteHandler;
         MEMORY_LOG[this] = 1;
         if(spriteHandler != null)
         {
            switch(spriteHandler.getDirection())
            {
               case 1:
               case 3:
                  animationName = spriteHandler.getAnimation() + "_1";
                  break;
               case 5:
               case 7:
                  animationName = spriteHandler.getAnimation() + "_5";
                  break;
               default:
                  animationName = spriteHandler.getAnimation() + "_" + spriteHandler.getDirection();
            }
            spriteHandler.tiphonEventManager.parseLabels(currentScene,animationName);
         }
         TiphonFpsManager.addOldScriptedAnimation(this);
      }
      
      public function playEventAtFrame(frame:int) : void
      {
         if(!this.destroyed && frame != this._lastFrame)
         {
            if(currentLabel == PLAYER_STOP)
            {
               stop();
               FpsControler.uncontrolFps(this);
            }
            if(!this.destroyed && !(spriteHandler as TiphonSprite).destroyed)
            {
               spriteHandler.tiphonEventManager.dispatchEvents(frame);
            }
            if(!this.destroyed && totalFrames > 1 && frame == totalFrames)
            {
               spriteHandler.onAnimationEvent(TiphonEvent.ANIMATION_END);
            }
            this._lastFrame = frame;
         }
      }
      
      public function setDisplayInfoSprite() : void
      {
         var child:DisplayObject = null;
         this._displayInfoSprite = new Dictionary(true);
         var numChild:int = this.numChildren;
         for(var i:int = 0; i < numChild; i++)
         {
            child = this.getChildAt(i);
            if(child)
            {
               this._displayInfoSprite[getQualifiedClassName(child)] = child;
            }
         }
      }
      
      public function getDisplayInfoSprite(infoSpriteName:String) : DisplayObject
      {
         var key:* = null;
         if(infoSpriteName.indexOf("timeline") != -1)
         {
            for(key in this._displayInfoSprite)
            {
               if(key.indexOf("timeline") != -1)
               {
                  return this._displayInfoSprite[key];
               }
            }
         }
         else if(infoSpriteName.indexOf("turnstart") != -1)
         {
            for(key in this._displayInfoSprite)
            {
               if(key.indexOf("turnstart") != -1)
               {
                  return this._displayInfoSprite[key];
               }
            }
         }
         return this._displayInfoSprite[infoSpriteName];
      }
      
      public function destroy() : void
      {
         if(!this.destroyed)
         {
            this.destroyed = true;
            this.events = null;
            this.anims = null;
            spriteHandler = null;
            if(parent)
            {
               parent.removeChild(this);
            }
         }
      }
      
      public function setAnimation(... args) : void
      {
      }
      
      public function event(... args) : void
      {
      }
      
      public function help() : void
      {
      }
   }
}
