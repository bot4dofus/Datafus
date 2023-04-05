package com.ankamagames.tiphon.display
{
   import com.ankamagames.tiphon.types.ScriptedAnimation;
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   
   public class RasterizedSyncAnimation extends RasterizedAnimation
   {
      
      private static var _events:Dictionary = new Dictionary(true);
       
      
      public function RasterizedSyncAnimation(target:MovieClip, lookCode:String)
      {
         var animationName:* = null;
         super(target,lookCode);
         _target = target;
         _totalFrames = _target.totalFrames;
         spriteHandler = (target as ScriptedAnimation).spriteHandler;
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
         if(spriteHandler != null)
         {
            spriteHandler.tiphonEventManager.parseLabels(currentScene,animationName);
         }
      }
      
      override public function gotoAndStop(frame:Object, scene:String = null) : void
      {
         var targetFrame:uint = frame as uint;
         if(targetFrame > 0)
         {
            targetFrame--;
         }
         this.displayFrame(targetFrame % _totalFrames);
      }
      
      override public function gotoAndPlay(frame:Object, scene:String = null) : void
      {
         this.gotoAndStop(frame,scene);
         play();
      }
      
      override protected function displayFrame(frameIndex:uint) : Boolean
      {
         var changed:Boolean = super.displayFrame(frameIndex);
         if(changed)
         {
            spriteHandler.tiphonEventManager.dispatchEvents(frameIndex);
         }
         return changed;
      }
   }
}
