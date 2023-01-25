package com.ankamagames.jerakine.managers
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   import flash.ui.MouseCursorData;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class CursorSpriteManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CursorSpriteManager));
      
      private static const MAX_CURSOR_SIZE:int = 32;
      
      private static var _cursorDataByName:Dictionary = new Dictionary();
       
      
      public function CursorSpriteManager()
      {
         super();
      }
      
      public static function displaySpecificCursor(name:String, cursorSprite:*) : void
      {
         if(!Mouse.supportsNativeCursor)
         {
            return;
         }
         if(Mouse.cursor == name)
         {
            return;
         }
         if(!_cursorDataByName[name])
         {
            registerSpecificCursor(name,cursorSprite);
         }
         Mouse.cursor = name;
      }
      
      public static function registerSpecificCursor(name:String, cursorSprite:*) : void
      {
         if(!Mouse.supportsNativeCursor)
         {
            return;
         }
         if(_cursorDataByName[name])
         {
            return;
         }
         registerCursorData(name,cursorSprite);
      }
      
      public static function resetCursor(name:String = "") : void
      {
         if(name != "" && Mouse.cursor != name)
         {
            return;
         }
         Mouse.cursor = MouseCursor.AUTO;
      }
      
      private static function registerCursorData(name:String, cursorSprite:*) : void
      {
         var clip:MovieClip = null;
         var frameIndex:int = 0;
         var cursorFrameBitmapData:BitmapData = null;
         var cursorBitmapDataList:Vector.<BitmapData> = new Vector.<BitmapData>();
         var cursorBitmapData:BitmapData = new BitmapData(MAX_CURSOR_SIZE,MAX_CURSOR_SIZE,true,0);
         var hotSpot:Point = new Point();
         if(cursorSprite.width > MAX_CURSOR_SIZE || cursorSprite.height > MAX_CURSOR_SIZE)
         {
            _log.warn("Cursor is too big to be displayed, " + cursorSprite.width + "x" + cursorSprite.height + " instead of " + MAX_CURSOR_SIZE + "x" + MAX_CURSOR_SIZE + ", it will be truncated.");
         }
         if(cursorSprite is Bitmap)
         {
            cursorBitmapData = Bitmap(cursorSprite).bitmapData;
            cursorBitmapDataList.push(cursorBitmapData);
         }
         else if(cursorSprite is BitmapData)
         {
            cursorBitmapData = cursorSprite;
            cursorBitmapDataList.push(cursorBitmapData);
         }
         else if(cursorSprite is MovieClip)
         {
            clip = cursorSprite;
            hotSpot = getOrigin(cursorSprite);
            for(frameIndex = 1; frameIndex <= clip.totalFrames; )
            {
               clip.gotoAndStop(frameIndex);
               cursorFrameBitmapData = new BitmapData(MAX_CURSOR_SIZE,MAX_CURSOR_SIZE,true,0);
               cursorFrameBitmapData.draw(clip);
               cursorBitmapDataList.push(cursorFrameBitmapData);
               frameIndex++;
            }
         }
         else
         {
            if(!(cursorSprite is DisplayObject))
            {
               return;
            }
            hotSpot = getOrigin(cursorSprite);
            cursorBitmapData.draw(cursorSprite);
            cursorBitmapDataList.push(cursorBitmapData);
         }
         var cursorData:MouseCursorData = new MouseCursorData();
         cursorData.data = cursorBitmapDataList;
         cursorData.hotSpot = hotSpot;
         cursorData.frameRate = 25;
         Mouse.registerCursor(name,cursorData);
         _cursorDataByName[name] = cursorData;
      }
      
      private static function getOrigin(target:DisplayObject) : Point
      {
         var doc:DisplayObjectContainer = null;
         var i:uint = 0;
         if(target is DisplayObjectContainer)
         {
            doc = target as DisplayObjectContainer;
            for(i = 0; i < doc.numChildren; i++)
            {
               if(doc.getChildAt(i).name.indexOf("origin") != -1)
               {
                  return new Point(doc.getChildAt(i).x,doc.getChildAt(i).y);
               }
            }
         }
         return new Point();
      }
   }
}
