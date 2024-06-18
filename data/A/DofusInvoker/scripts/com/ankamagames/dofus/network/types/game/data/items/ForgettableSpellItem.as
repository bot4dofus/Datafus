package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ForgettableSpellItem extends SpellItem implements INetworkType
   {
      
      public static const protocolId:uint = 2798;
       
      
      public var available:Boolean = false;
      
      public function ForgettableSpellItem()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 2798;
      }
      
      public function initForgettableSpellItem(spellId:int = 0, spellLevel:int = 0, available:Boolean = false) : ForgettableSpellItem
      {
         super.initSpellItem(spellId,spellLevel);
         this.available = available;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.available = false;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ForgettableSpellItem(output);
      }
      
      public function serializeAs_ForgettableSpellItem(output:ICustomDataOutput) : void
      {
         super.serializeAs_SpellItem(output);
         output.writeBoolean(this.available);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ForgettableSpellItem(input);
      }
      
      public function deserializeAs_ForgettableSpellItem(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._availableFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ForgettableSpellItem(tree);
      }
      
      public function deserializeAsyncAs_ForgettableSpellItem(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._availableFunc);
      }
      
      private function _availableFunc(input:ICustomDataInput) : void
      {
         this.available = input.readBoolean();
      }
   }
}
