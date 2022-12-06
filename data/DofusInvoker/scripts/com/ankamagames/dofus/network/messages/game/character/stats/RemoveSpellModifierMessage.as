package com.ankamagames.dofus.network.messages.game.character.stats
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class RemoveSpellModifierMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2668;
       
      
      private var _isInitialized:Boolean = false;
      
      public var actorId:Number = 0;
      
      public var modificationType:uint = 0;
      
      public var spellId:uint = 0;
      
      public function RemoveSpellModifierMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2668;
      }
      
      public function initRemoveSpellModifierMessage(actorId:Number = 0, modificationType:uint = 0, spellId:uint = 0) : RemoveSpellModifierMessage
      {
         this.actorId = actorId;
         this.modificationType = modificationType;
         this.spellId = spellId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.actorId = 0;
         this.modificationType = 0;
         this.spellId = 0;
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
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_RemoveSpellModifierMessage(output);
      }
      
      public function serializeAs_RemoveSpellModifierMessage(output:ICustomDataOutput) : void
      {
         if(this.actorId < -9007199254740992 || this.actorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.actorId + ") on element actorId.");
         }
         output.writeDouble(this.actorId);
         output.writeByte(this.modificationType);
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         output.writeVarShort(this.spellId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_RemoveSpellModifierMessage(input);
      }
      
      public function deserializeAs_RemoveSpellModifierMessage(input:ICustomDataInput) : void
      {
         this._actorIdFunc(input);
         this._modificationTypeFunc(input);
         this._spellIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_RemoveSpellModifierMessage(tree);
      }
      
      public function deserializeAsyncAs_RemoveSpellModifierMessage(tree:FuncTree) : void
      {
         tree.addChild(this._actorIdFunc);
         tree.addChild(this._modificationTypeFunc);
         tree.addChild(this._spellIdFunc);
      }
      
      private function _actorIdFunc(input:ICustomDataInput) : void
      {
         this.actorId = input.readDouble();
         if(this.actorId < -9007199254740992 || this.actorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.actorId + ") on element of RemoveSpellModifierMessage.actorId.");
         }
      }
      
      private function _modificationTypeFunc(input:ICustomDataInput) : void
      {
         this.modificationType = input.readByte();
         if(this.modificationType < 0)
         {
            throw new Error("Forbidden value (" + this.modificationType + ") on element of RemoveSpellModifierMessage.modificationType.");
         }
      }
      
      private function _spellIdFunc(input:ICustomDataInput) : void
      {
         this.spellId = input.readVarUhShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of RemoveSpellModifierMessage.spellId.");
         }
      }
   }
}
