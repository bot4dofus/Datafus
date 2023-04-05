package com.ankamagames.dofus.internalDatacenter.communication
{
   import com.ankamagames.berilia.managers.SlotDataHolderManager;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.EmoticonFrame;
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
   import flash.utils.getTimer;
   
   public class EmoteWrapper extends Proxy implements IDataCenter, ISlotData
   {
      
      private static var _cache:Array = new Array();
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EmoteWrapper));
       
      
      private var _uri:Uri;
      
      private var _slotDataHolderManager:SlotDataHolderManager;
      
      private var _timerDuration:int = 0;
      
      private var _timerStartTime:int = 0;
      
      private var _timerEndTime:int = 0;
      
      public var position:uint;
      
      public var id:uint = 0;
      
      public var gfxId:int;
      
      public var isOkForMultiUse:Boolean = false;
      
      public var quantity:uint = 1;
      
      public function EmoteWrapper()
      {
         super();
      }
      
      public static function create(emoteID:uint, position:int = -1, useCache:Boolean = true) : EmoteWrapper
      {
         var emote:EmoteWrapper = new EmoteWrapper();
         if(!_cache[emoteID] || !useCache)
         {
            emote = new EmoteWrapper();
            emote.id = emoteID;
            if(useCache)
            {
               _cache[emoteID] = emote;
            }
            emote._slotDataHolderManager = new SlotDataHolderManager(emote);
         }
         else
         {
            emote = _cache[emoteID];
         }
         emote.id = emoteID;
         emote.gfxId = emoteID;
         if(position >= 0)
         {
            emote.position = position;
         }
         return emote;
      }
      
      public static function refreshAllEmoteHolders() : void
      {
         var wrapper:EmoteWrapper = null;
         for each(wrapper in _cache)
         {
            wrapper._slotDataHolderManager.refreshAll();
         }
      }
      
      public static function getEmoteWrapperById(id:uint) : EmoteWrapper
      {
         return _cache[id];
      }
      
      public function get iconUri() : Uri
      {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/emotes/").concat(this.id).concat(".png"));
         }
         return this._uri;
      }
      
      public function get fullSizeIconUri() : Uri
      {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/emotes/").concat(this.id).concat(".png"));
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
         return this._timerStartTime;
      }
      
      public function get endTime() : int
      {
         return this._timerEndTime;
      }
      
      public function set endTime(t:int) : void
      {
         this._timerEndTime = t;
      }
      
      public function get timer() : int
      {
         var remainingTime:int = this._timerStartTime + this._timerDuration - getTimer();
         if(remainingTime > 0)
         {
            return remainingTime;
         }
         return 0;
      }
      
      public function set timerToStart(t:int) : void
      {
         this._timerDuration = t;
         this._timerStartTime = getTimer();
         this._slotDataHolderManager.refreshAll();
      }
      
      public function get active() : Boolean
      {
         var rpEmoticonFrame:EmoticonFrame = Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
         return rpEmoticonFrame.isKnownEmote(this.id);
      }
      
      public function get emote() : Emoticon
      {
         return Emoticon.getEmoticonById(this.id);
      }
      
      public function get emoteId() : uint
      {
         return this.id;
      }
      
      public function get isUsable() : Boolean
      {
         return true;
      }
      
      override flash_proxy function getProperty(name:*) : *
      {
         var l:* = undefined;
         var r:* = undefined;
         if(isAttribute(name))
         {
            return this[name];
         }
         l = this.emote;
         if(!l)
         {
            r = "";
         }
         try
         {
            return l[name];
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
         return "[EmoteWrapper#" + this.id + "]";
      }
      
      public function addHolder(h:ISlotDataHolder) : void
      {
         this._slotDataHolderManager.addHolder(h);
      }
      
      public function removeHolder(h:ISlotDataHolder) : void
      {
         this._slotDataHolderManager.removeHolder(h);
      }
      
      public function setLinkedSlotData(slotData:ISlotData) : void
      {
         this._slotDataHolderManager.setLinkedSlotData(slotData);
      }
      
      public function getIconUri(pngMode:Boolean = true) : Uri
      {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/emotes/").concat(this.id).concat(".png"));
         }
         return this._uri;
      }
   }
}
