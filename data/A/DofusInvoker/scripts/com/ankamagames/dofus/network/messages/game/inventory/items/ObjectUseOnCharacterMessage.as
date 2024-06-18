package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ObjectUseOnCharacterMessage extends ObjectUseMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2165;
       
      
      private var _isInitialized:Boolean = false;
      
      public var characterId:Number = 0;
      
      public function ObjectUseOnCharacterMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2165;
      }
      
      public function initObjectUseOnCharacterMessage(objectUID:uint = 0, characterId:Number = 0) : ObjectUseOnCharacterMessage
      {
         super.initObjectUseMessage(objectUID);
         this.characterId = characterId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.characterId = 0;
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
         this.serializeAs_ObjectUseOnCharacterMessage(output);
      }
      
      public function serializeAs_ObjectUseOnCharacterMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ObjectUseMessage(output);
         if(this.characterId < 0 || this.characterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element characterId.");
         }
         output.writeVarLong(this.characterId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectUseOnCharacterMessage(input);
      }
      
      public function deserializeAs_ObjectUseOnCharacterMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._characterIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectUseOnCharacterMessage(tree);
      }
      
      public function deserializeAsyncAs_ObjectUseOnCharacterMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._characterIdFunc);
      }
      
      private function _characterIdFunc(input:ICustomDataInput) : void
      {
         this.characterId = input.readVarUhLong();
         if(this.characterId < 0 || this.characterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element of ObjectUseOnCharacterMessage.characterId.");
         }
      }
   }
}
