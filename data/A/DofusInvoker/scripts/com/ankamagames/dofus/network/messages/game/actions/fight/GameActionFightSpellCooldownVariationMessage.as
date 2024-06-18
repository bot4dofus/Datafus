package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightSpellCooldownVariationMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 766;
       
      
      private var _isInitialized:Boolean = false;
      
      public var targetId:Number = 0;
      
      public var spellId:uint = 0;
      
      public var value:int = 0;
      
      public function GameActionFightSpellCooldownVariationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 766;
      }
      
      public function initGameActionFightSpellCooldownVariationMessage(actionId:uint = 0, sourceId:Number = 0, targetId:Number = 0, spellId:uint = 0, value:int = 0) : GameActionFightSpellCooldownVariationMessage
      {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.targetId = targetId;
         this.spellId = spellId;
         this.value = value;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.targetId = 0;
         this.spellId = 0;
         this.value = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:ICustomDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      override public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         var tree:FuncTree = new FuncTree();
         tree.setRoot(input);
         this.deserializeAsync(tree);
         return tree;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameActionFightSpellCooldownVariationMessage(output);
      }
      
      public function serializeAs_GameActionFightSpellCooldownVariationMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionMessage(output);
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         output.writeDouble(this.targetId);
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         output.writeVarShort(this.spellId);
         output.writeVarShort(this.value);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightSpellCooldownVariationMessage(input);
      }
      
      public function deserializeAs_GameActionFightSpellCooldownVariationMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._targetIdFunc(input);
         this._spellIdFunc(input);
         this._valueFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightSpellCooldownVariationMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightSpellCooldownVariationMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._targetIdFunc);
         tree.addChild(this._spellIdFunc);
         tree.addChild(this._valueFunc);
      }
      
      private function _targetIdFunc(input:ICustomDataInput) : void
      {
         this.targetId = input.readDouble();
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of GameActionFightSpellCooldownVariationMessage.targetId.");
         }
      }
      
      private function _spellIdFunc(input:ICustomDataInput) : void
      {
         this.spellId = input.readVarUhShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of GameActionFightSpellCooldownVariationMessage.spellId.");
         }
      }
      
      private function _valueFunc(input:ICustomDataInput) : void
      {
         this.value = input.readVarShort();
      }
   }
}
