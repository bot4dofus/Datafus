package com.ankamagames.dofus.internalDatacenter.items
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Uri;
   import flash.utils.getQualifiedClassName;
   
   public class SimpleTextureWrapper implements ISlotData, IDataCenter
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(SimpleTextureWrapper));
       
      
      protected var _uri:Uri;
      
      public function SimpleTextureWrapper()
      {
         super();
      }
      
      public static function create(uri:Uri) : SimpleTextureWrapper
      {
         var simpleTextureWrapper:SimpleTextureWrapper = new SimpleTextureWrapper();
         simpleTextureWrapper._uri = uri;
         return simpleTextureWrapper;
      }
      
      public function get iconUri() : Uri
      {
         return this._uri;
      }
      
      public function get fullSizeIconUri() : Uri
      {
         return this._uri;
      }
      
      public function get errorIconUri() : Uri
      {
         return null;
      }
      
      public function get uri() : Uri
      {
         return this._uri;
      }
      
      public function get info1() : String
      {
         return null;
      }
      
      public function get startTime() : int
      {
         return 0;
      }
      
      public function get endTime() : int
      {
         return 0;
      }
      
      public function set endTime(t:int) : void
      {
      }
      
      public function get timer() : int
      {
         return 0;
      }
      
      public function get active() : Boolean
      {
         return true;
      }
      
      public function addHolder(h:ISlotDataHolder) : void
      {
      }
      
      public function removeHolder(h:ISlotDataHolder) : void
      {
      }
   }
}
