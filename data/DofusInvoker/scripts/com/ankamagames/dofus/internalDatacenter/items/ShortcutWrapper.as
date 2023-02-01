package com.ankamagames.dofus.internalDatacenter.items
{
   import com.ankamagames.dofus.datacenter.communication.Smiley;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.communication.EmoteWrapper;
   import com.ankamagames.dofus.internalDatacenter.communication.SmileyWrapper;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.EmoticonFrame;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Uri;
   import flash.system.LoaderContext;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   import flash.utils.getQualifiedClassName;
   
   public class ShortcutWrapper extends Proxy implements ISlotData, IDataCenter
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(ShortcutWrapper));
      
      private static const TYPE_ITEM_WRAPPER:int = 0;
      
      private static const TYPE_BUILD_WRAPPER:int = 1;
      
      private static const TYPE_SPELL_WRAPPER:int = 2;
      
      private static const TYPE_SMILEY_WRAPPER:int = 3;
      
      private static const TYPE_EMOTE_WRAPPER:int = 4;
      
      private static const TYPE_IDOLS_PRESET_WRAPPER:int = 5;
      
      private static var _errorIconUri:Uri;
      
      private static var _uriLoaderContext:LoaderContext;
      
      private static var _properties:Array;
       
      
      private var _uri:Uri;
      
      private var _uriFullsize:Uri;
      
      private var _backGroundIconUri:Uri;
      
      private var _active:Boolean = true;
      
      private var _setCount:int = 0;
      
      public var slot:uint = 0;
      
      public var id:int = 0;
      
      public var gid:int = 0;
      
      public var type:int = 0;
      
      public var quantity:int = 0;
      
      public function ShortcutWrapper()
      {
         super();
      }
      
      public static function create(slot:uint, id:uint, type:uint = 0, gid:uint = 0) : ShortcutWrapper
      {
         var itemWrapper:ItemWrapper = null;
         var emoteWrapper:EmoteWrapper = null;
         var rpEmoteFrame:EmoticonFrame = null;
         var smiley:Smiley = null;
         var smileyWrapper:SmileyWrapper = null;
         var item:ShortcutWrapper = new ShortcutWrapper();
         item.slot = slot;
         item.id = id;
         item.type = type;
         item.gid = gid;
         if(type == DataEnum.SHORTCUT_TYPE_ITEM)
         {
            if(id != 0)
            {
               itemWrapper = InventoryManager.getInstance().inventory.getItem(id);
            }
            else
            {
               itemWrapper = ItemWrapper.create(0,0,gid,0,null,false);
            }
            if(itemWrapper)
            {
               item.quantity = itemWrapper.quantity;
            }
            if(item.quantity == 0)
            {
               item.active = false;
            }
            else
            {
               item.active = true;
            }
         }
         if(type == DataEnum.SHORTCUT_TYPE_EMOTE)
         {
            emoteWrapper = EmoteWrapper.create(item.id,item.slot);
            rpEmoteFrame = Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
            if(rpEmoteFrame.isKnownEmote(item.id))
            {
               item.active = true;
            }
            else
            {
               item.active = false;
            }
         }
         if(type == DataEnum.SHORTCUT_TYPE_SMILEY && !SmileyWrapper.getSmileyWrapperById(id))
         {
            smiley = Smiley.getSmileyById(id);
            if(smiley)
            {
               smileyWrapper = SmileyWrapper.create(smiley.id,smiley.gfxId,0,smiley.categoryId);
            }
         }
         return item;
      }
      
      public function get iconUri() : Uri
      {
         return this.getIconUri(true);
      }
      
      public function get fullSizeIconUri() : Uri
      {
         return this.getIconUri(false);
      }
      
      public function get backGroundIconUri() : Uri
      {
         if(!this._backGroundIconUri)
         {
            this._backGroundIconUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("texture/slot/emptySlot.png"));
         }
         return this._backGroundIconUri;
      }
      
      public function set backGroundIconUri(bgUri:Uri) : void
      {
         this._backGroundIconUri = bgUri;
      }
      
      public function get errorIconUri() : Uri
      {
         if(!_errorIconUri)
         {
            _errorIconUri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.bitmap").concat("error.png"));
         }
         return _errorIconUri;
      }
      
      public function get info1() : String
      {
         var spellWrapper:SpellWrapper = null;
         if(this.type == TYPE_ITEM_WRAPPER)
         {
            return this.quantity.toString();
         }
         if(this.type == TYPE_SPELL_WRAPPER)
         {
            spellWrapper = SpellWrapper.getSpellWrapperById(this.id,this.getCharaId());
            return !!spellWrapper ? spellWrapper.info1 : "";
         }
         return "";
      }
      
      public function get startTime() : int
      {
         var emoteWrapper:EmoteWrapper = null;
         if(this.type == TYPE_EMOTE_WRAPPER)
         {
            emoteWrapper = EmoteWrapper.getEmoteWrapperById(this.id);
            return !!emoteWrapper ? int(emoteWrapper.startTime) : 0;
         }
         return 0;
      }
      
      public function get endTime() : int
      {
         var emoteWrapper:EmoteWrapper = null;
         if(this.type == TYPE_EMOTE_WRAPPER)
         {
            emoteWrapper = EmoteWrapper.getEmoteWrapperById(this.id);
            return !!emoteWrapper ? int(emoteWrapper.endTime) : 0;
         }
         return 0;
      }
      
      public function set endTime(t:int) : void
      {
         var emoteWrapper:EmoteWrapper = null;
         if(this.type == TYPE_EMOTE_WRAPPER)
         {
            emoteWrapper = EmoteWrapper.getEmoteWrapperById(this.id);
            if(emoteWrapper)
            {
               emoteWrapper.endTime = t;
            }
         }
      }
      
      public function get timer() : int
      {
         var emoteWrapper:EmoteWrapper = null;
         if(this.type == TYPE_EMOTE_WRAPPER)
         {
            emoteWrapper = EmoteWrapper.getEmoteWrapperById(this.id);
            return !!emoteWrapper ? int(emoteWrapper.timer) : 0;
         }
         return 0;
      }
      
      public function get active() : Boolean
      {
         var spellWrapper:SpellWrapper = null;
         var rpEmoticonFrame:EmoticonFrame = null;
         if(this.type == TYPE_SPELL_WRAPPER)
         {
            spellWrapper = SpellWrapper.getSpellWrapperById(this.id,this.getCharaId());
            return !!spellWrapper ? Boolean(spellWrapper.active) : false;
         }
         if(this.type == TYPE_EMOTE_WRAPPER)
         {
            rpEmoticonFrame = Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
            return rpEmoticonFrame.isKnownEmote(this.id);
         }
         return this._active;
      }
      
      public function set active(b:Boolean) : void
      {
         this._active = b;
      }
      
      public function get realItem() : ISlotData
      {
         var itemWrapper:ItemWrapper = null;
         var builds:Array = null;
         var build:BuildWrapper = null;
         var idolsPresets:Vector.<IdolsPresetWrapper> = null;
         var idolPreset:IdolsPresetWrapper = null;
         if(this.type == TYPE_ITEM_WRAPPER)
         {
            if(this.id != 0)
            {
               itemWrapper = InventoryManager.getInstance().inventory.getItem(this.id);
            }
            else
            {
               itemWrapper = ItemWrapper.create(0,0,this.gid,0,null,false);
            }
            return itemWrapper;
         }
         if(this.type == TYPE_BUILD_WRAPPER)
         {
            builds = InventoryManager.getInstance().builds;
            for each(build in builds)
            {
               if(build.id == this.id)
               {
                  return build;
               }
            }
         }
         else
         {
            if(this.type == TYPE_SPELL_WRAPPER)
            {
               return SpellWrapper.getSpellWrapperById(this.id,this.getCharaId());
            }
            if(this.type == TYPE_EMOTE_WRAPPER)
            {
               return EmoteWrapper.getEmoteWrapperById(this.id);
            }
            if(this.type == TYPE_SMILEY_WRAPPER)
            {
               return SmileyWrapper.getSmileyWrapperById(this.id);
            }
            if(this.type == TYPE_IDOLS_PRESET_WRAPPER)
            {
               idolsPresets = PlayedCharacterManager.getInstance().idolsPresets;
               for each(idolPreset in idolsPresets)
               {
                  if(idolPreset.id == this.id)
                  {
                     return idolPreset;
                  }
               }
            }
         }
         return null;
      }
      
      override flash_proxy function getProperty(name:*) : *
      {
         var itemWrapper:ItemWrapper = null;
         var builds:Array = null;
         var buildWrapper:BuildWrapper = null;
         var emoteWrapper:EmoteWrapper = null;
         var spellWrapper:SpellWrapper = null;
         if(isAttribute(name))
         {
            return this[name];
         }
         if(this.type == TYPE_ITEM_WRAPPER)
         {
            if(this.id != 0)
            {
               itemWrapper = InventoryManager.getInstance().inventory.getItem(this.id);
            }
            else
            {
               itemWrapper = ItemWrapper.create(0,0,this.gid,0,null,false);
            }
            if(!itemWrapper)
            {
               _log.debug("Null item " + this.id + " - " + this.gid);
            }
            else
            {
               try
               {
                  return itemWrapper[name];
               }
               catch(e:Error)
               {
                  if(e.getStackTrace())
                  {
                     _log.error("Item " + id + " " + gid + " " + name + " : " + e.getStackTrace());
                  }
                  return "Error_on_item_" + name;
               }
            }
         }
         else if(this.type == TYPE_BUILD_WRAPPER)
         {
            builds = InventoryManager.getInstance().builds;
            for each(buildWrapper in builds)
            {
               if(buildWrapper.id == this.id)
               {
                  break;
               }
            }
            if(!buildWrapper)
            {
               _log.debug("Null build " + this.id + " - " + this.gid);
            }
            else
            {
               try
               {
                  return buildWrapper[name];
               }
               catch(e:Error)
               {
                  if(e.getStackTrace())
                  {
                     _log.error("Build " + id + " " + name + " : " + e.getStackTrace());
                  }
                  return "Error_on_build_" + name;
               }
            }
         }
         else if(this.type == TYPE_EMOTE_WRAPPER)
         {
            emoteWrapper = EmoteWrapper.getEmoteWrapperById(this.id);
            if(!emoteWrapper)
            {
               _log.debug("Null emote " + this.id);
            }
            else
            {
               try
               {
                  return emoteWrapper[name];
               }
               catch(e:Error)
               {
                  if(e.getStackTrace())
                  {
                     _log.error("Emote " + id + " " + name + " : " + e.getStackTrace());
                  }
                  return "Error_on_emote_" + name;
               }
            }
         }
         else if(this.type == TYPE_SPELL_WRAPPER)
         {
            spellWrapper = SpellWrapper.getSpellWrapperById(this.id,this.getCharaId());
            if(!spellWrapper)
            {
               _log.debug("Null preset " + this.id + " - " + this.gid);
            }
            else
            {
               try
               {
                  return spellWrapper[name];
               }
               catch(e:Error)
               {
                  if(e.getStackTrace())
                  {
                     _log.error("Spell " + id + " " + name + " : " + e.getStackTrace());
                  }
                  return "Error_on_spell_" + name;
               }
            }
         }
         return "Error on getProperty " + name;
      }
      
      override flash_proxy function callProperty(name:*, ... rest) : *
      {
         var res:* = undefined;
         switch(QName(name).localName)
         {
            case "toString":
               res = "[ShortcutWrapper : type " + this.type + ", id " + this.id + ", slot " + this.slot + ", gid " + this.gid + ", quantity " + this.quantity + "]";
               break;
            case "hasOwnProperty":
               res = this.hasProperty(name);
         }
         return res;
      }
      
      override flash_proxy function nextNameIndex(index:int) : int
      {
         return 0;
      }
      
      override flash_proxy function nextName(index:int) : String
      {
         return "nextName";
      }
      
      override flash_proxy function hasProperty(name:*) : Boolean
      {
         return false;
      }
      
      public function update(slot:uint, id:uint, type:uint = 0, gid:uint = 0) : void
      {
         var itemWrapper:ItemWrapper = null;
         var rpEmoteFrame:EmoticonFrame = null;
         if(this.id != id || this.type != type)
         {
            this._uri = this._uriFullsize = null;
         }
         this.slot = slot;
         this.id = id;
         this.type = type;
         this.gid = gid;
         this.active = true;
         if(this.type == TYPE_ITEM_WRAPPER)
         {
            if(this.id != 0)
            {
               itemWrapper = InventoryManager.getInstance().inventory.getItem(this.id);
               if(this._uri && itemWrapper.iconUri != this._uri)
               {
                  this._uri = this._uriFullsize = null;
               }
            }
            else
            {
               itemWrapper = ItemWrapper.create(0,0,this.gid,0,null,false);
            }
            if(itemWrapper)
            {
               this.quantity = itemWrapper.quantity;
            }
            if(this.quantity == 0)
            {
               this.active = false;
            }
         }
         if(this.type == TYPE_BUILD_WRAPPER || this.type == TYPE_IDOLS_PRESET_WRAPPER)
         {
            this._uri = this._uriFullsize = null;
         }
         if(type == TYPE_EMOTE_WRAPPER)
         {
            rpEmoteFrame = Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
            if(!rpEmoteFrame.isKnownEmote(id))
            {
               this.active = false;
            }
         }
      }
      
      public function getIconUri(pngMode:Boolean = true) : Uri
      {
         var itemWrapper:ItemWrapper = null;
         var fakeItemWrapper:ItemWrapper = null;
         var builds:Array = null;
         var buildWrapper:BuildWrapper = null;
         var spellWrapper:SpellWrapper = null;
         var smileyWrapper:SmileyWrapper = null;
         var emoteWrapper:EmoteWrapper = null;
         var idolsPresets:Vector.<IdolsPresetWrapper> = null;
         var idolsPreset:IdolsPresetWrapper = null;
         var idolsPresetExists:Boolean = false;
         if(this.type != TYPE_SPELL_WRAPPER || this.id != 0)
         {
            if(pngMode && this._uri)
            {
               return this._uri;
            }
            if(!pngMode && this._uriFullsize)
            {
               return this._uriFullsize;
            }
         }
         if(this.type == TYPE_ITEM_WRAPPER)
         {
            if(this.id != 0)
            {
               itemWrapper = InventoryManager.getInstance().inventory.getItem(this.id);
               if(itemWrapper)
               {
                  this._uri = itemWrapper.iconUri;
                  this._uriFullsize = itemWrapper.fullSizeIconUri;
               }
               else
               {
                  this._uri = this._uriFullsize = null;
               }
            }
            else
            {
               fakeItemWrapper = ItemWrapper.create(0,0,this.gid,0,null,false);
               if(fakeItemWrapper)
               {
                  this._uri = fakeItemWrapper.iconUri;
                  this._uriFullsize = fakeItemWrapper.fullSizeIconUri;
               }
               else
               {
                  this._uri = this._uriFullsize = null;
               }
            }
         }
         else if(this.type == TYPE_BUILD_WRAPPER)
         {
            builds = InventoryManager.getInstance().builds;
            for each(buildWrapper in builds)
            {
               if(buildWrapper.id == this.id)
               {
                  break;
               }
            }
            if(buildWrapper)
            {
               this._uri = buildWrapper.iconUri;
               this._uriFullsize = buildWrapper.fullSizeIconUri;
            }
            else
            {
               this._uri = this._uriFullsize = null;
            }
         }
         else if(this.type == TYPE_SPELL_WRAPPER)
         {
            spellWrapper = SpellWrapper.getSpellWrapperById(this.id,this.getCharaId(),true);
            if(spellWrapper)
            {
               this._uri = spellWrapper.iconUri;
               this._uriFullsize = spellWrapper.fullSizeIconUri;
            }
            else
            {
               this._uri = this._uriFullsize = null;
            }
         }
         else if(this.type == TYPE_SMILEY_WRAPPER)
         {
            smileyWrapper = SmileyWrapper.getSmileyWrapperById(this.id);
            if(smileyWrapper)
            {
               this._uri = smileyWrapper.iconUri;
               this._uriFullsize = smileyWrapper.fullSizeIconUri;
            }
            else
            {
               this._uri = this._uriFullsize = null;
            }
         }
         else if(this.type == TYPE_EMOTE_WRAPPER)
         {
            emoteWrapper = EmoteWrapper.getEmoteWrapperById(this.id);
            if(emoteWrapper)
            {
               this._uri = emoteWrapper.iconUri;
               this._uriFullsize = emoteWrapper.fullSizeIconUri;
            }
            else
            {
               this._uri = this._uriFullsize = null;
            }
         }
         else if(this.type == TYPE_IDOLS_PRESET_WRAPPER)
         {
            idolsPresets = PlayedCharacterManager.getInstance().idolsPresets;
            for each(idolsPreset in idolsPresets)
            {
               if(idolsPreset.id == this.id)
               {
                  idolsPresetExists = true;
                  this._uri = idolsPreset.iconUri;
                  this._uriFullsize = idolsPreset.fullSizeIconUri;
                  break;
               }
            }
            if(!idolsPresetExists)
            {
               this._uri = this._uriFullsize = null;
            }
         }
         if(pngMode && this._uri)
         {
            return this._uri;
         }
         if(!pngMode && this._uriFullsize)
         {
            return this._uriFullsize;
         }
         return null;
      }
      
      public function clone() : ShortcutWrapper
      {
         var shortcut:ShortcutWrapper = new ShortcutWrapper();
         shortcut.slot = this.slot;
         shortcut.id = this.id;
         shortcut.type = this.type;
         shortcut.gid = this.gid;
         shortcut.quantity = this.quantity;
         return shortcut;
      }
      
      public function addHolder(h:ISlotDataHolder) : void
      {
         var spellWrapper:SpellWrapper = null;
         var emoteWrapper:EmoteWrapper = null;
         if(this.type == TYPE_SPELL_WRAPPER)
         {
            spellWrapper = SpellWrapper.getSpellWrapperById(this.id,this.getCharaId());
            if(spellWrapper)
            {
               spellWrapper.addHolder(h);
               spellWrapper.setLinkedSlotData(this);
            }
         }
         else if(this.type == TYPE_EMOTE_WRAPPER)
         {
            emoteWrapper = EmoteWrapper.getEmoteWrapperById(this.id);
            if(emoteWrapper)
            {
               emoteWrapper.addHolder(h);
               emoteWrapper.setLinkedSlotData(this);
            }
         }
      }
      
      public function removeHolder(h:ISlotDataHolder) : void
      {
      }
      
      private function getCharaId() : Number
      {
         if(CurrentPlayedFighterManager.getInstance().currentFighterId != 0)
         {
            return CurrentPlayedFighterManager.getInstance().currentFighterId;
         }
         return PlayedCharacterManager.getInstance().id;
      }
   }
}
