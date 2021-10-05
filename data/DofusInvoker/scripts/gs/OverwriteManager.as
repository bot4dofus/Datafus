package gs
{
   import gs.core.SimpleTimeline;
   import gs.core.TweenCore;
   
   public final class OverwriteManager
   {
      
      public static const version:Number = 6.1;
      
      public static const NONE:int = 0;
      
      public static const ALL_IMMEDIATE:int = 1;
      
      public static const AUTO:int = 2;
      
      public static const CONCURRENT:int = 3;
      
      public static const ALL_ONSTART:int = 4;
      
      public static const PREEXISTING:int = 5;
      
      public static var mode:int;
      
      public static var enabled:Boolean;
       
      
      public function OverwriteManager()
      {
         super();
      }
      
      public static function init(defaultMode:int = 2) : int
      {
         if(TweenLite.version < 11.6)
         {
            throw new Error("Warning: Your TweenLite class needs to be updated to work with OverwriteManager (or you may need to clear your ASO files). Please download and install the latest version from http://www.tweenlite.com.");
         }
         TweenLite.overwriteManager = OverwriteManager;
         mode = defaultMode;
         enabled = true;
         return mode;
      }
      
      public static function manageOverwrites(tween:TweenLite, props:Object, targetTweens:Array, mode:int) : Boolean
      {
         var i:int = 0;
         var changed:Boolean = false;
         var curTween:TweenLite = null;
         var l:int = 0;
         var combinedTimeScale:Number = NaN;
         var combinedStartTime:Number = NaN;
         var cousin:TweenCore = null;
         var cousinStartTime:Number = NaN;
         var timeline:SimpleTimeline = null;
         if(mode >= 4)
         {
            l = targetTweens.length;
            for(i = 0; i < l; i++)
            {
               curTween = targetTweens[i];
               if(curTween != tween)
               {
                  if(curTween.setEnabled(false,false))
                  {
                     changed = true;
                  }
               }
               else if(mode == 5)
               {
                  break;
               }
            }
            return changed;
         }
         var startTime:Number = tween.cachedStartTime + 1e-10;
         var overlaps:Array = [];
         var cousins:Array = [];
         var cCount:int = 0;
         var oCount:int = 0;
         i = targetTweens.length;
         while(--i > -1)
         {
            curTween = targetTweens[i];
            if(!(curTween == tween || curTween.gc || !curTween.initted && startTime - curTween.cachedStartTime <= 2e-10))
            {
               if(curTween.timeline != tween.timeline)
               {
                  if(!getGlobalPaused(curTween))
                  {
                     var _loc19_:* = cCount++;
                     cousins[_loc19_] = curTween;
                  }
               }
               else if(curTween.cachedStartTime <= startTime && curTween.cachedStartTime + curTween.totalDuration + 1e-10 > startTime && !curTween.cachedPaused && !(tween.cachedDuration == 0 && startTime - curTween.cachedStartTime <= 2e-10))
               {
                  _loc19_ = oCount++;
                  overlaps[_loc19_] = curTween;
               }
            }
         }
         if(cCount != 0)
         {
            combinedTimeScale = tween.cachedTimeScale;
            combinedStartTime = startTime;
            timeline = tween.timeline;
            while(timeline)
            {
               combinedTimeScale *= timeline.cachedTimeScale;
               combinedStartTime += timeline.cachedStartTime;
               timeline = timeline.timeline;
            }
            startTime = combinedTimeScale * combinedStartTime;
            i = cCount;
            while(--i > -1)
            {
               cousin = cousins[i];
               combinedTimeScale = cousin.cachedTimeScale;
               combinedStartTime = cousin.cachedStartTime;
               timeline = cousin.timeline;
               while(timeline)
               {
                  combinedTimeScale *= timeline.cachedTimeScale;
                  combinedStartTime += timeline.cachedStartTime;
                  timeline = timeline.timeline;
               }
               cousinStartTime = combinedTimeScale * combinedStartTime;
               if(cousinStartTime <= startTime && (cousinStartTime + cousin.totalDuration * combinedTimeScale + 1e-10 > startTime || cousin.cachedDuration == 0))
               {
                  _loc19_ = oCount++;
                  overlaps[_loc19_] = cousin;
               }
            }
         }
         if(oCount == 0)
         {
            return changed;
         }
         i = oCount;
         if(mode == 2)
         {
            while(--i > -1)
            {
               curTween = overlaps[i];
               if(curTween.killVars(props))
               {
                  changed = true;
               }
               if(curTween.cachedPT1 == null && curTween.initted)
               {
                  curTween.setEnabled(false,false);
               }
            }
         }
         else
         {
            while(--i > -1)
            {
               if(TweenLite(overlaps[i]).setEnabled(false,false))
               {
                  changed = true;
               }
            }
         }
         return changed;
      }
      
      public static function getGlobalPaused(tween:TweenCore) : Boolean
      {
         var paused:Boolean = false;
         while(tween)
         {
            if(tween.cachedPaused)
            {
               paused = true;
               break;
            }
            tween = tween.timeline;
         }
         return paused;
      }
   }
}
