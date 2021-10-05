package Ankama_Fight.ui.items
{
   import Ankama_Fight.Api;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import flash.geom.ColorTransform;
   
   public class BuffItem
   {
       
      
      private var _key:String;
      
      private var _buffs:Vector.<BasicBuff>;
      
      private var _spell:Spell;
      
      private var _parentBoostUid:int = 0;
      
      private var _cooldown:int = 0;
      
      private var _ctr:Object;
      
      private var _size:int;
      
      private var tx_buff:Texture;
      
      private var lbl_cooldown_buff:Label;
      
      public var btn_buff:ButtonContainer;
      
      public function BuffItem(spellId:int, casterId:Number, parentBoostUid:uint, endDelay:int, size:uint, css:String, ctr:Object)
      {
         super();
         if(endDelay > 0)
         {
            this._key = spellId + "#" + casterId + "#" + parentBoostUid + "#" + endDelay;
         }
         else
         {
            this._key = spellId + "#" + casterId + "#" + parentBoostUid;
         }
         this._buffs = new Vector.<BasicBuff>();
         this._spell = Api.dataApi.getSpell(spellId);
         this._ctr = ctr;
         this._size = size;
         var spellwrapper:SpellWrapper = Api.dataApi.getSpellWrapper(spellId);
         var textureUri:String = spellwrapper.iconUri.toString();
         this.btn_buff = Api.uiApi.createContainer("ButtonContainer") as ButtonContainer;
         this.btn_buff.width = size;
         this.btn_buff.height = size;
         this.btn_buff.name = "buff_" + this.key;
         this.tx_buff = Api.uiApi.createComponent("Texture") as Texture;
         this.tx_buff.width = size;
         this.tx_buff.height = size;
         this.tx_buff.x = 0;
         this.tx_buff.y = 0;
         this.tx_buff.name = "tx_buff";
         this.tx_buff.uri = Api.uiApi.createUri(textureUri);
         if(spellwrapper.spell.typeId == 40)
         {
            this.tx_buff.transform.colorTransform = new ColorTransform(100,1,1,1,-76,-10,33,0);
         }
         this.tx_buff.finalize();
         this.lbl_cooldown_buff = Api.uiApi.createComponent("Label") as Label;
         this.lbl_cooldown_buff.height = 19;
         this.lbl_cooldown_buff.width = 19;
         this.lbl_cooldown_buff.fixedWidth = false;
         this.lbl_cooldown_buff.bgColor = Api.sysApi.getConfigEntry("colors.ui.shadow");
         this.lbl_cooldown_buff.bgAlpha = 0.6;
         this.lbl_cooldown_buff.x = 0;
         this.lbl_cooldown_buff.y = 0;
         this.lbl_cooldown_buff.css = Api.uiApi.createUri(css);
         this.lbl_cooldown_buff.cssClass = "quantity";
         this.lbl_cooldown_buff.text = "+";
         this.lbl_cooldown_buff.fullWidthAndHeight();
         this.cooldown = this._cooldown;
         this.btn_buff.addChild(this.tx_buff);
         this.btn_buff.addChild(this.lbl_cooldown_buff);
         var stateChangingProperties:Array = [];
         stateChangingProperties[StatesEnum.STATE_OVER] = [];
         stateChangingProperties[StatesEnum.STATE_OVER][this.tx_buff.name] = [];
         stateChangingProperties[StatesEnum.STATE_OVER][this.tx_buff.name]["luminosity"] = 1.5;
         this.btn_buff.changingStateData = stateChangingProperties;
         ctr.addChild(this.btn_buff);
      }
      
      public static function getKey(buff:BasicBuff, includeDelay:Boolean = false, delayOffset:int = 0) : String
      {
         var buffKey:String = buff.castingSpell.spell.id + "#" + buff.castingSpell.casterId + "#" + buff.parentBoostUid;
         if(includeDelay || buff.effect && buff.effect.delay > 0)
         {
            buffKey += "#" + (getEndDelayTurn(buff) + delayOffset);
         }
         return buffKey;
      }
      
      public static function getEndDelayTurn(buff:BasicBuff) : int
      {
         if(buff.effect && buff.effect.hasOwnProperty("delay"))
         {
            return Api.fightApi.getTurnsCount() + buff.effect.delay;
         }
         return Api.fightApi.getTurnsCount();
      }
      
      public function hasUid(boostUid:String) : Boolean
      {
         var buff:BasicBuff = null;
         for each(buff in this._buffs)
         {
            if(buff.uid == boostUid as uint)
            {
               return true;
            }
         }
         return false;
      }
      
      public function set cooldown(value:int) : void
      {
         this._cooldown = value;
         if(this.lbl_cooldown_buff)
         {
            if(this._cooldown == -1)
            {
               this.lbl_cooldown_buff.text = "+";
               this.lbl_cooldown_buff.visible = true;
            }
            else if(this._cooldown == 0 || this._cooldown == uint.MAX_VALUE)
            {
               this.lbl_cooldown_buff.text = "";
               this.lbl_cooldown_buff.visible = false;
            }
            else if(this._cooldown < -1)
            {
               this.lbl_cooldown_buff.text = "∞";
               this.lbl_cooldown_buff.visible = true;
            }
            else
            {
               this.lbl_cooldown_buff.text = this._cooldown.toString();
               this.lbl_cooldown_buff.visible = true;
            }
         }
      }
      
      public function get cooldown() : int
      {
         return this._cooldown;
      }
      
      public function get maxCooldown() : int
      {
         var buff:BasicBuff = null;
         if(this._cooldown != -1)
         {
            return this._cooldown;
         }
         var max:int = 0;
         for each(buff in this._buffs)
         {
            if(buff.duration > max || buff.duration < -1)
            {
               max = buff.duration;
            }
         }
         return max;
      }
      
      public function get delay() : int
      {
         var buff:BasicBuff = null;
         var delay:int = 0;
         for each(buff in this._buffs)
         {
            if(delay == 0 || buff.effect.delay < delay)
            {
               delay = buff.effect.delay;
            }
         }
         return delay;
      }
      
      public function get trigger() : Boolean
      {
         var buff:BasicBuff = null;
         for each(buff in this._buffs)
         {
            if(buff.trigger)
            {
               return true;
            }
         }
         return false;
      }
      
      public function set x(value:int) : void
      {
         this.btn_buff.x = value;
      }
      
      public function get x() : int
      {
         return this.btn_buff.x;
      }
      
      public function set y(value:int) : void
      {
         this.btn_buff.y = value;
      }
      
      public function get y() : int
      {
         return this.btn_buff.y;
      }
      
      public function get width() : int
      {
         return this.btn_buff.width;
      }
      
      public function get height() : int
      {
         return this.btn_buff.height;
      }
      
      public function get key() : String
      {
         return this._key;
      }
      
      public function get buffs() : Vector.<BasicBuff>
      {
         return this._buffs;
      }
      
      public function get spell() : Spell
      {
         return this._spell;
      }
      
      public function get unusableNextTurn() : Boolean
      {
         var buff:BasicBuff = null;
         for each(buff in this._buffs)
         {
            if(!buff.unusableNextTurn)
            {
               return false;
            }
         }
         return true;
      }
      
      public function addBuff(buff:BasicBuff) : void
      {
         this._buffs.push(buff);
         if(buff.parentBoostUid != 0)
         {
            this._parentBoostUid = buff.parentBoostUid;
         }
         this.updateCooldown();
      }
      
      public function get parentBoostUid() : int
      {
         return this._parentBoostUid;
      }
      
      public function update(buff:BasicBuff) : void
      {
         this.updateCooldown();
      }
      
      public function removeBuff(buff:BasicBuff) : void
      {
         var buffsCount:int = this._buffs.length;
         for(var i:int = 0; i < buffsCount; i++)
         {
            if(this._buffs[i] == buff)
            {
               this._buffs.splice(i,1);
               this.updateCooldown();
               break;
            }
         }
         if(this._buffs.length == 0)
         {
            this.remove();
         }
      }
      
      public function remove() : void
      {
         if(this.btn_buff && !this.btn_buff)
         {
            if(this._ctr.contains(this.btn_buff))
            {
               this._ctr.removeChild(this.btn_buff);
            }
            this.btn_buff.remove();
         }
      }
      
      public function updateCooldown() : void
      {
         var buff:BasicBuff = null;
         var last:int = 0;
         var isSet:Boolean = false;
         var delay:int = 0;
         for each(buff in this._buffs)
         {
            if(isSet && last != buff.duration)
            {
               this.cooldown = -1;
            }
            if(delay == 0 || buff.effect.delay < delay)
            {
               delay = buff.effect.delay;
            }
            last = buff.duration;
            isSet = true;
         }
         if(delay > 0)
         {
            this.cooldown = delay;
         }
         else
         {
            this.cooldown = last;
         }
         if(this.unusableNextTurn)
         {
            this.tx_buff.disabled = true;
         }
      }
   }
}
