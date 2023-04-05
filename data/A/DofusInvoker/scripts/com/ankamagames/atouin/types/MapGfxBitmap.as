package com.ankamagames.atouin.types
{
   import com.ankamagames.jerakine.interfaces.ICustomUnicNameGetter;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class MapGfxBitmap extends Bitmap implements ICustomUnicNameGetter
   {
       
      
      private var _name:String;
      
      public function MapGfxBitmap(bitmapdata:BitmapData, pixelSnapping:String = "auto", smoothing:Boolean = false, identifier:uint = 0)
      {
         super(bitmapdata,pixelSnapping,smoothing);
         this._name = "mapGfx::" + identifier;
      }
      
      public function get customUnicName() : String
      {
         return this._name;
      }
   }
}
