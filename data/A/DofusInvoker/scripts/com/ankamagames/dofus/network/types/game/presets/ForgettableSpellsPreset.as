package com.ankamagames.dofus.network.types.game.presets
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ForgettableSpellsPreset extends Preset implements INetworkType
   {
      
      public static const protocolId:uint = 6253;
       
      
      public var baseSpellsPreset:SpellsPreset;
      
      public var forgettableSpells:Vector.<SpellForPreset>;
      
      private var _baseSpellsPresettree:FuncTree;
      
      private var _forgettableSpellstree:FuncTree;
      
      public function ForgettableSpellsPreset()
      {
         this.baseSpellsPreset = new SpellsPreset();
         this.forgettableSpells = new Vector.<SpellForPreset>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 6253;
      }
      
      public function initForgettableSpellsPreset(id:int = 0, baseSpellsPreset:SpellsPreset = null, forgettableSpells:Vector.<SpellForPreset> = null) : ForgettableSpellsPreset
      {
         super.initPreset(id);
         this.baseSpellsPreset = baseSpellsPreset;
         this.forgettableSpells = forgettableSpells;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.baseSpellsPreset = new SpellsPreset();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ForgettableSpellsPreset(output);
      }
      
      public function serializeAs_ForgettableSpellsPreset(output:ICustomDataOutput) : void
      {
         super.serializeAs_Preset(output);
         this.baseSpellsPreset.serializeAs_SpellsPreset(output);
         output.writeShort(this.forgettableSpells.length);
         for(var _i2:uint = 0; _i2 < this.forgettableSpells.length; _i2++)
         {
            (this.forgettableSpells[_i2] as SpellForPreset).serializeAs_SpellForPreset(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ForgettableSpellsPreset(input);
      }
      
      public function deserializeAs_ForgettableSpellsPreset(input:ICustomDataInput) : void
      {
         var _item2:SpellForPreset = null;
         super.deserialize(input);
         this.baseSpellsPreset = new SpellsPreset();
         this.baseSpellsPreset.deserialize(input);
         var _forgettableSpellsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _forgettableSpellsLen; _i2++)
         {
            _item2 = new SpellForPreset();
            _item2.deserialize(input);
            this.forgettableSpells.push(_item2);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ForgettableSpellsPreset(tree);
      }
      
      public function deserializeAsyncAs_ForgettableSpellsPreset(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._baseSpellsPresettree = tree.addChild(this._baseSpellsPresettreeFunc);
         this._forgettableSpellstree = tree.addChild(this._forgettableSpellstreeFunc);
      }
      
      private function _baseSpellsPresettreeFunc(input:ICustomDataInput) : void
      {
         this.baseSpellsPreset = new SpellsPreset();
         this.baseSpellsPreset.deserializeAsync(this._baseSpellsPresettree);
      }
      
      private function _forgettableSpellstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._forgettableSpellstree.addChild(this._forgettableSpellsFunc);
         }
      }
      
      private function _forgettableSpellsFunc(input:ICustomDataInput) : void
      {
         var _item:SpellForPreset = new SpellForPreset();
         _item.deserialize(input);
         this.forgettableSpells.push(_item);
      }
   }
}
