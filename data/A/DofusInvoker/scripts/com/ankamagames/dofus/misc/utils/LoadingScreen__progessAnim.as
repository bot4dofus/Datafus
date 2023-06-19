package com.ankamagames.dofus.misc.utils
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class LoadingScreen__progessAnim extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function LoadingScreen__progessAnim()
      {
         this.dataClass = LoadingScreen__progessAnim_dataClass;
         super();
         initialWidth = 400 / 20;
         initialHeight = 400 / 20;
      }
      
      override public function get movieClipData() : ByteArray
      {
         if(bytes == null)
         {
            bytes = ByteArray(new this.dataClass());
         }
         return bytes;
      }
   }
}
