package com.ankamagames.dofus.uiApi
{
   import by.blooddy.crypto.Base64;
   import by.blooddy.crypto.image.JPEGEncoder;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.filesystem.File;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class CaptureApi implements IApi
   {
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CaptureApi));
      
      private static var _instance:CaptureApi;
       
      
      public function CaptureApi()
      {
         super();
         MEMORY_LOG[this] = 1;
         _instance = this;
      }
      
      public static function getInstance() : CaptureApi
      {
         if(!_instance)
         {
            _instance = new CaptureApi();
         }
         return _instance;
      }
      
      [NoBoxing]
      public function getScreen(rect:Rectangle = null, scale:Number = 1.0) : BitmapData
      {
         return this.capture(StageShareManager.stage,rect,StageShareManager.stageVisibleBounds,scale);
      }
      
      [NoBoxing]
      public function getBattleField(rect:Rectangle = null, scale:Number = 1.0) : BitmapData
      {
         return this.capture(Atouin.getInstance().worldContainer,rect,new Rectangle(-Atouin.getInstance().worldContainer.x,0,StageShareManager.startWidth - Atouin.getInstance().worldContainer.x * 2,AtouinConstants.CELL_HEIGHT * AtouinConstants.MAP_HEIGHT + 15),scale);
      }
      
      [NoBoxing]
      public function getFromTarget(target:DisplayObject, rect:Rectangle = null, scale:Number = 1.0, transparent:Boolean = false) : BitmapData
      {
         if(!target || !(target is DisplayObject))
         {
            return null;
         }
         var dObj:DisplayObject = target as DisplayObject;
         var bounds:Rectangle = dObj.getBounds(dObj);
         if(!bounds.width || !bounds.height)
         {
            return null;
         }
         return this.capture(dObj,rect,bounds,scale,transparent);
      }
      
      [NoBoxing]
      public function jpegEncode(img:BitmapData, quality:uint = 80, askForSave:Boolean = true, fileName:String = "image.jpg") : ByteArray
      {
         var encodedImg:ByteArray = JPEGEncoder.encode(img,quality);
         if(askForSave)
         {
            File.desktopDirectory.save(encodedImg,fileName);
         }
         return encodedImg;
      }
      
      [NoBoxing]
      public function pngEncode(img:BitmapData, askForSave:Boolean = true, fileName:String = "image.png") : ByteArray
      {
         var encodedImg:ByteArray = PNGEncoder2.encode(img);
         if(askForSave)
         {
            File.desktopDirectory.save(encodedImg,fileName);
         }
         return encodedImg;
      }
      
      [NoBoxing]
      public function getScreenAsJpgCompressedBase64(rect:Rectangle = null, scale:Number = 1.0, quality:uint = 80) : String
      {
         var ba:ByteArray = null;
         var base64Image:String = "";
         var maxRect:Rectangle = StageShareManager.stageVisibleBounds;
         var bd:BitmapData = this.capture(StageShareManager.stage,rect,maxRect,scale);
         if(bd)
         {
            ba = JPEGEncoder.encode(bd,quality);
            base64Image = Base64.encode(ba);
            ba.clear();
         }
         return base64Image;
      }
      
      private function capture(target:DisplayObject, rect:Rectangle, maxRect:Rectangle, scale:Number = 1.0, transparent:Boolean = false) : BitmapData
      {
         var rect2:Rectangle = null;
         var matrix:Matrix = null;
         var data:BitmapData = null;
         if(!rect)
         {
            rect2 = maxRect;
         }
         else
         {
            rect2 = maxRect.intersection(rect);
         }
         if(target)
         {
            matrix = new Matrix();
            matrix.scale(scale,scale);
            matrix.translate(-rect2.x * scale,-rect2.y * scale);
            data = new BitmapData(rect2.width * scale,rect2.height * scale,transparent,!!transparent ? uint(16711680) : uint(4294967295));
            data.draw(target,matrix);
            return data;
         }
         return null;
      }
   }
}
