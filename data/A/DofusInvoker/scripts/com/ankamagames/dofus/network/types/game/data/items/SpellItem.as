package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SpellItem extends Item implements INetworkType
   {
      
      public static const protocolId:uint = 9854;
       
      
      public var spellId:int = 0;
      
      public var spellLevel:int = 0;
      
      public function SpellItem()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 9854;
      }
      
      public function initSpellItem(spellId:int = 0, spellLevel:int = 0) : SpellItem
      {
         this.spellId = spellId;
         this.spellLevel = spellLevel;
         return this;
      }
      
      override public function reset() : void
      {
         this.spellId = 0;
         this.spellLevel = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SpellItem(output);
      }
      
      public function serializeAs_SpellItem(output:ICustomDataOutput) : void
      {
         super.serializeAs_Item(output);
         output.writeInt(this.spellId);
         if(this.spellLevel < 1 || this.spellLevel > 32767)
         {
            throw new Error("Forbidden value (" + this.spellLevel + ") on element spellLevel.");
         }
         output.writeShort(this.spellLevel);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SpellItem(input);
      }
      
      public function deserializeAs_SpellItem(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._spellIdFunc(input);
         this._spellLevelFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SpellItem(tree);
      }
      
      public function deserializeAsyncAs_SpellItem(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._spellIdFunc);
         tree.addChild(this._spellLevelFunc);
      }
      
      private function _spellIdFunc(input:ICustomDataInput) : void
      {
         this.spellId = input.readInt();
      }
      
      private function _spellLevelFunc(input:ICustomDataInput) : void
      {
         this.spellLevel = input.readShort();
         if(this.spellLevel < 1 || this.spellLevel > 32767)
         {
            throw new Error("Forbidden value (" + this.spellLevel + ") on element of SpellItem.spellLevel.");
         }
      }
   }
}
