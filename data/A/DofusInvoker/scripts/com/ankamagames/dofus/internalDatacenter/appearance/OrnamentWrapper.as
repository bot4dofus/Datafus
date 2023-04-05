package com.ankamagames.dofus.internalDatacenter.appearance
{
   import com.ankamagames.dofus.datacenter.appearance.Ornament;
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
   
   public class OrnamentWrapper extends Proxy implements IDataCenter, ISlotData
   {
      
      private static var _cache:Array = new Array();
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(OrnamentWrapper));
       
      
      private var _uri:Uri;
      
      public var id:uint = 0;
      
      public var name:String;
      
      public var iconId:uint = 0;
      
      public var isOkForMultiUse:Boolean = false;
      
      public var quantity:uint = 1;
      
      public function OrnamentWrapper()
      {
         super();
      }
      
      public static function create(ornId:uint, position:int = -1, useCache:Boolean = true) : OrnamentWrapper
      {
         var ow:OrnamentWrapper = new OrnamentWrapper();
         if(!_cache[ornId] || !useCache)
         {
            ow = new OrnamentWrapper();
            ow.id = ornId;
            if(useCache)
            {
               _cache[ornId] = ow;
            }
         }
         else
         {
            ow = _cache[ornId];
         }
         var ornament:Ornament = Ornament.getOrnamentById(ornId);
         ow.id = ornId;
         ow.name = ornament.name;
         ow.iconId = ornament.iconId;
         return ow;
      }
      
      public static function getOrnamentWrapperById(id:uint) : OrnamentWrapper
      {
         return _cache[id];
      }
      
      public function get iconUri() : Uri
      {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/ornaments/").concat(this.iconId).concat(".png"));
         }
         return this._uri;
      }
      
      public function get fullSizeIconUri() : Uri
      {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/ornaments/").concat(this.iconId).concat(".png"));
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
         return true;
      }
      
      public function get ornament() : Ornament
      {
         return Ornament.getOrnamentById(this.id);
      }
      
      public function get ornamentId() : uint
      {
         return this.id;
      }
      
      public function get isUsable() : Boolean
      {
         return false;
      }
      
      override flash_proxy function getProperty(name:*) : *
      {
         var t:* = undefined;
         var r:* = undefined;
         if(isAttribute(name))
         {
            return this[name];
         }
         t = this.ornament;
         if(!t)
         {
            r = "";
         }
         try
         {
            return t[name];
         }
         catch(e:Error)
         {
            return "Error_on_item_" + name;
         }
      }
      
      override flash_proxy function hasProperty(name:*) : Boolean
      {
         return isAttribute(name);
      }
      
      public function toString() : String
      {
         return "[OrnamentWrapper#" + this.id + "]";
      }
      
      public function addHolder(h:ISlotDataHolder) : void
      {
      }
      
      public function removeHolder(h:ISlotDataHolder) : void
      {
      }
      
      public function getIconUri(pngMode:Boolean = true) : Uri
      {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/ornaments/").concat(this.iconId).concat(".png"));
         }
         return this._uri;
      }
   }
}
