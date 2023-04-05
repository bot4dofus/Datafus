package com.ankamagames.dofus.internalDatacenter.userInterface
{
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Uri;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   import flash.utils.getQualifiedClassName;
   
   public class ButtonWrapper extends Proxy implements IDataCenter, ISlotData
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ButtonWrapper));
       
      
      private var _uri:Uri;
      
      private var _active:Boolean = true;
      
      public var highlight:Boolean = false;
      
      public var position:uint;
      
      public var id:uint = 0;
      
      public var uriName:String;
      
      public var callback:Function;
      
      public var name:String;
      
      public var shortcutName:String;
      
      public var description:String;
      
      public function ButtonWrapper()
      {
         super();
      }
      
      public static function create(buttonId:uint, position:int, uriName:String, callback:Function, name:String, shortcutName:String = "", description:String = "") : ButtonWrapper
      {
         var button:ButtonWrapper = new ButtonWrapper();
         button.id = buttonId;
         button.position = position;
         button.callback = callback;
         button.uriName = uriName;
         button.name = name;
         button.shortcutName = shortcutName;
         button.description = description;
         return button;
      }
      
      public static function getButtonWrapperById(id:uint) : ButtonWrapper
      {
         return null;
      }
      
      public function get iconUri() : Uri
      {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("assets.swf|").concat(this.uriName));
         }
         return this._uri;
      }
      
      public function get fullSizeIconUri() : Uri
      {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("assets.swf|").concat(this.uriName));
         }
         return this._uri;
      }
      
      public function get backGroundIconUri() : Uri
      {
         return null;
      }
      
      public function get errorIconUri() : Uri
      {
         return null;
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
         return this._active;
      }
      
      public function set active(active:Boolean) : void
      {
         this._active = active;
      }
      
      override flash_proxy function getProperty(name:*) : *
      {
         if(isAttribute(name))
         {
            return this[name];
         }
         return "Error_on_buttonWrapper_" + name;
      }
      
      override flash_proxy function hasProperty(name:*) : Boolean
      {
         return isAttribute(name);
      }
      
      public function toString() : String
      {
         return "[ButtonWrapper#" + this.id + "]";
      }
      
      public function setPosition(value:int) : void
      {
         this.position = value;
      }
      
      public function addHolder(h:ISlotDataHolder) : void
      {
      }
      
      public function removeHolder(h:ISlotDataHolder) : void
      {
      }
      
      public function getIconUri(pngMode:Boolean = true) : Uri
      {
         return this.iconUri;
      }
   }
}
