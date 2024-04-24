package com.ankamagames.dofus.network.types.game.character.spellmodifier
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SpellModifierMessage implements INetworkType
   {
      
      public static const protocolId:uint = 2352;
       
      
      public var spellId:uint = 0;
      
      public var actionType:uint = 0;
      
      public var modifierType:uint = 0;
      
      public var context:int = 0;
      
      public var equipment:int = 0;
      
      public function SpellModifierMessage()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 2352;
      }
      
      public function initSpellModifierMessage(spellId:uint = 0, actionType:uint = 0, modifierType:uint = 0, context:int = 0, equipment:int = 0) : SpellModifierMessage
      {
         this.spellId = spellId;
         this.actionType = actionType;
         this.modifierType = modifierType;
         this.context = context;
         this.equipment = equipment;
         return this;
      }
      
      public function reset() : void
      {
         this.spellId = 0;
         this.actionType = 0;
         this.modifierType = 0;
         this.context = 0;
         this.equipment = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SpellModifierMessage(output);
      }
      
      public function serializeAs_SpellModifierMessage(output:ICustomDataOutput) : void
      {
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         output.writeVarShort(this.spellId);
         output.writeByte(this.actionType);
         output.writeByte(this.modifierType);
         output.writeInt(this.context);
         output.writeInt(this.equipment);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SpellModifierMessage(input);
      }
      
      public function deserializeAs_SpellModifierMessage(input:ICustomDataInput) : void
      {
         this._spellIdFunc(input);
         this._actionTypeFunc(input);
         this._modifierTypeFunc(input);
         this._contextFunc(input);
         this._equipmentFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SpellModifierMessage(tree);
      }
      
      public function deserializeAsyncAs_SpellModifierMessage(tree:FuncTree) : void
      {
         tree.addChild(this._spellIdFunc);
         tree.addChild(this._actionTypeFunc);
         tree.addChild(this._modifierTypeFunc);
         tree.addChild(this._contextFunc);
         tree.addChild(this._equipmentFunc);
      }
      
      private function _spellIdFunc(input:ICustomDataInput) : void
      {
         this.spellId = input.readVarUhShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of SpellModifierMessage.spellId.");
         }
      }
      
      private function _actionTypeFunc(input:ICustomDataInput) : void
      {
         this.actionType = input.readByte();
         if(this.actionType < 0)
         {
            throw new Error("Forbidden value (" + this.actionType + ") on element of SpellModifierMessage.actionType.");
         }
      }
      
      private function _modifierTypeFunc(input:ICustomDataInput) : void
      {
         this.modifierType = input.readByte();
         if(this.modifierType < 0)
         {
            throw new Error("Forbidden value (" + this.modifierType + ") on element of SpellModifierMessage.modifierType.");
         }
      }
      
      private function _contextFunc(input:ICustomDataInput) : void
      {
         this.context = input.readInt();
      }
      
      private function _equipmentFunc(input:ICustomDataInput) : void
      {
         this.equipment = input.readInt();
      }
   }
}
