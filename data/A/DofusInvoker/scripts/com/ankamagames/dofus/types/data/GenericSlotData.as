package com.ankamagames.dofus.types.data
{
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import com.ankamagames.jerakine.types.Uri;
   
   public dynamic class GenericSlotData implements ISlotData
   {
       
      
      private var _iconUri:Uri;
      
      private var _fullSizeIconUri:Uri;
      
      private var _errorIconUri:Uri;
      
      private var _info1:String;
      
      private var _active:Boolean;
      
      private var _timer:int;
      
      public function GenericSlotData(iconUri:Uri = null, fullSizeIconUri:Uri = null, errorIconUri:Uri = null, info1:String = null, active:Boolean = true, timer:int = 0)
      {
         super();
         this._iconUri = iconUri;
         this._fullSizeIconUri = fullSizeIconUri;
         this._errorIconUri = errorIconUri;
         this._info1 = info1;
         this._active = active;
         this._timer = timer;
      }
      
      public function set fullSizeIconUri(value:Uri) : void
      {
         this._fullSizeIconUri = value;
      }
      
      public function set errorIconUri(value:Uri) : void
      {
         this._errorIconUri = value;
      }
      
      public function set info1(value:String) : void
      {
         this._info1 = value;
      }
      
      public function set timer(value:int) : void
      {
         this._timer = value;
      }
      
      public function set active(value:Boolean) : void
      {
         this._active = value;
      }
      
      public function set iconUri(value:Uri) : void
      {
         this._iconUri = value;
      }
      
      public function get iconUri() : Uri
      {
         return this._iconUri;
      }
      
      public function get fullSizeIconUri() : Uri
      {
         return this._fullSizeIconUri;
      }
      
      public function get errorIconUri() : Uri
      {
         return this._errorIconUri;
      }
      
      public function get info1() : String
      {
         return this._info1;
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
         return this._timer;
      }
      
      public function get active() : Boolean
      {
         return this._active;
      }
      
      public function addHolder(h:ISlotDataHolder) : void
      {
      }
      
      public function removeHolder(h:ISlotDataHolder) : void
      {
      }
   }
}
