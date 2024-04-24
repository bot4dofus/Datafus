package com.ankamagames.dofus.network.types.game.presets
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SpellForPreset implements INetworkType
   {
      
      public static const protocolId:uint = 7902;
       
      
      public var spellId:uint = 0;
      
      public var shortcuts:Vector.<int>;
      
      private var _shortcutstree:FuncTree;
      
      public function SpellForPreset()
      {
         this.shortcuts = new Vector.<int>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 7902;
      }
      
      public function initSpellForPreset(spellId:uint = 0, shortcuts:Vector.<int> = null) : SpellForPreset
      {
         this.spellId = spellId;
         this.shortcuts = shortcuts;
         return this;
      }
      
      public function reset() : void
      {
         this.spellId = 0;
         this.shortcuts = new Vector.<int>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SpellForPreset(output);
      }
      
      public function serializeAs_SpellForPreset(output:ICustomDataOutput) : void
      {
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         output.writeVarShort(this.spellId);
         output.writeShort(this.shortcuts.length);
         for(var _i2:uint = 0; _i2 < this.shortcuts.length; _i2++)
         {
            output.writeShort(this.shortcuts[_i2]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SpellForPreset(input);
      }
      
      public function deserializeAs_SpellForPreset(input:ICustomDataInput) : void
      {
         var _val2:int = 0;
         this._spellIdFunc(input);
         var _shortcutsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _shortcutsLen; _i2++)
         {
            _val2 = input.readShort();
            this.shortcuts.push(_val2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SpellForPreset(tree);
      }
      
      public function deserializeAsyncAs_SpellForPreset(tree:FuncTree) : void
      {
         tree.addChild(this._spellIdFunc);
         this._shortcutstree = tree.addChild(this._shortcutstreeFunc);
      }
      
      private function _spellIdFunc(input:ICustomDataInput) : void
      {
         this.spellId = input.readVarUhShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of SpellForPreset.spellId.");
         }
      }
      
      private function _shortcutstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._shortcutstree.addChild(this._shortcutsFunc);
         }
      }
      
      private function _shortcutsFunc(input:ICustomDataInput) : void
      {
         var _val:int = input.readShort();
         this.shortcuts.push(_val);
      }
   }
}
