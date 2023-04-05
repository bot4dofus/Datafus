package com.ankamagames.jerakine.types
{
   import flash.display.DisplayObject;
   import flash.system.ApplicationDomain;
   
   public class ASwf
   {
       
      
      private var _content:DisplayObject;
      
      private var _appDomain:ApplicationDomain;
      
      private var _loaderWidth:Number;
      
      private var _loaderHeight:Number;
      
      public function ASwf(content:DisplayObject, appDomain:ApplicationDomain, loaderWidth:Number, loaderHeight:Number)
      {
         super();
         this._content = content;
         this._appDomain = appDomain;
         this._loaderWidth = loaderWidth;
         this._loaderHeight = loaderHeight;
      }
      
      public function get content() : DisplayObject
      {
         return this._content;
      }
      
      public function get applicationDomain() : ApplicationDomain
      {
         return this._appDomain;
      }
      
      public function get loaderWidth() : Number
      {
         return this._loaderWidth;
      }
      
      public function get loaderHeight() : Number
      {
         return this._loaderHeight;
      }
   }
}
