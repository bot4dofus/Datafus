package com.ankamagames.dofus.network.types.game.presets
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SpellsPreset extends Preset implements INetworkType
   {
      
      public static const protocolId:uint = 7774;
       
      
      public var spells:Vector.<SpellForPreset>;
      
      private var _spellstree:FuncTree;
      
      public function SpellsPreset()
      {
         this.spells = new Vector.<SpellForPreset>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7774;
      }
      
      public function initSpellsPreset(id:int = 0, spells:Vector.<SpellForPreset> = null) : SpellsPreset
      {
         super.initPreset(id);
         this.spells = spells;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.spells = new Vector.<SpellForPreset>();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SpellsPreset(output);
      }
      
      public function serializeAs_SpellsPreset(output:ICustomDataOutput) : void
      {
         super.serializeAs_Preset(output);
         output.writeShort(this.spells.length);
         for(var _i1:uint = 0; _i1 < this.spells.length; _i1++)
         {
            (this.spells[_i1] as SpellForPreset).serializeAs_SpellForPreset(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SpellsPreset(input);
      }
      
      public function deserializeAs_SpellsPreset(input:ICustomDataInput) : void
      {
         var _item1:SpellForPreset = null;
         super.deserialize(input);
         var _spellsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _spellsLen; _i1++)
         {
            _item1 = new SpellForPreset();
            _item1.deserialize(input);
            this.spells.push(_item1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SpellsPreset(tree);
      }
      
      public function deserializeAsyncAs_SpellsPreset(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._spellstree = tree.addChild(this._spellstreeFunc);
      }
      
      private function _spellstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._spellstree.addChild(this._spellsFunc);
         }
      }
      
      private function _spellsFunc(input:ICustomDataInput) : void
      {
         var _item:SpellForPreset = new SpellForPreset();
         _item.deserialize(input);
         this.spells.push(_item);
      }
   }
}
