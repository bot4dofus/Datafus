package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.dofus.datacenter.guild.EmblemBackground;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
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
   
   public class EmblemWrapper extends Proxy implements IDataCenter, ISlotData
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EmblemWrapper));
      
      private static var _cache:Array = new Array();
      
      public static const UP:uint = 1;
      
      public static const BACK:uint = 2;
       
      
      private var _uri:Uri;
      
      private var _fullSizeUri:Uri;
      
      private var _color:uint;
      
      private var _type:uint;
      
      private var _order:int;
      
      private var _category:int;
      
      private var _forAlliance:Boolean;
      
      private var _isInit:Boolean;
      
      public var idEmblem:uint;
      
      public function EmblemWrapper()
      {
         super();
      }
      
      public static function fromNetwork(msg:GuildEmblem, background:Boolean, forAlliance:Boolean = false) : EmblemWrapper
      {
         var o:EmblemWrapper = new EmblemWrapper();
         o._forAlliance = forAlliance;
         if(background)
         {
            o.idEmblem = msg.backgroundShape;
            o._color = msg.backgroundColor;
            o._type = BACK;
         }
         else
         {
            o.idEmblem = msg.symbolShape;
            o._color = msg.symbolColor;
            o._type = UP;
         }
         return o;
      }
      
      public static function create(pIdEmblem:uint, pType:uint, pColor:uint = 0, forAlliance:Boolean = false, useCache:Boolean = false) : EmblemWrapper
      {
         var emblem:EmblemWrapper = null;
         if(!_cache[pIdEmblem] || !useCache)
         {
            emblem = new EmblemWrapper();
            emblem.idEmblem = pIdEmblem;
            if(useCache)
            {
               _cache[pIdEmblem] = emblem;
            }
         }
         else
         {
            emblem = _cache[pIdEmblem];
         }
         emblem._type = pType;
         emblem._color = pColor;
         emblem._forAlliance = forAlliance;
         emblem._isInit = false;
         return emblem;
      }
      
      public static function getEmblemFromId(emblemId:uint) : EmblemWrapper
      {
         return _cache[emblemId];
      }
      
      public function get category() : int
      {
         this.init();
         return this._category;
      }
      
      public function get order() : int
      {
         this.init();
         return this._order;
      }
      
      public function get iconUri() : Uri
      {
         this.init();
         return this._uri;
      }
      
      public function get fullSizeIconUri() : Uri
      {
         this.init();
         return this._fullSizeUri;
      }
      
      public function get backGroundIconUri() : Uri
      {
         return new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("texture/slot/emptySlot.png"));
      }
      
      public function set backGroundIconUri(bgUri:Uri) : void
      {
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
      
      public function get type() : uint
      {
         return this._type;
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function get errorIconUri() : Uri
      {
         return null;
      }
      
      override flash_proxy function getProperty(name:*) : *
      {
         if(isAttribute(name))
         {
            return this[name];
         }
         return "Error on emblem " + name;
      }
      
      override flash_proxy function hasProperty(name:*) : Boolean
      {
         return isAttribute(name);
      }
      
      public function update(pIdEmblem:uint, pType:uint, pColor:uint = 0) : void
      {
         this.idEmblem = pIdEmblem;
         this._type = pType;
         this._color = pColor;
         this._isInit = false;
      }
      
      public function addHolder(h:ISlotDataHolder) : void
      {
      }
      
      public function removeHolder(h:ISlotDataHolder) : void
      {
      }
      
      private function init() : void
      {
         var path:* = null;
         var pathFullSize:* = null;
         var iconId:int = 0;
         var symbol:EmblemSymbol = null;
         var back:EmblemBackground = null;
         if(this._isInit)
         {
            return;
         }
         switch(this._type)
         {
            case UP:
               symbol = EmblemSymbol.getEmblemSymbolById(this.idEmblem);
               iconId = symbol.iconId;
               this._order = symbol.order;
               this._category = symbol.categoryId;
               path = XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.small") + "up/";
               pathFullSize = XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.large") + "up/";
               break;
            case BACK:
               back = EmblemBackground.getEmblemBackgroundById(this.idEmblem);
               this._order = back.order;
               iconId = this.idEmblem;
               if(this._forAlliance)
               {
                  path = XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.small") + "backalliance/";
                  pathFullSize = XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.large") + "backalliance/";
               }
               else
               {
                  path = XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.small") + "back/";
                  pathFullSize = XmlConfig.getInstance().getEntry("config.gfx.path.emblem_icons.large") + "back/";
               }
         }
         this._uri = new Uri(path + iconId + ".png");
         this._fullSizeUri = new Uri(pathFullSize + iconId + ".swf");
         this._isInit = true;
      }
   }
}
