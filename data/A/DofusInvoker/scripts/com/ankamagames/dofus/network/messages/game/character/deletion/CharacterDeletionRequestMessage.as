package com.ankamagames.dofus.network.messages.game.character.deletion
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CharacterDeletionRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5964;
       
      
      private var _isInitialized:Boolean = false;
      
      public var characterId:Number = 0;
      
      public var secretAnswerHash:String = "";
      
      public function CharacterDeletionRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5964;
      }
      
      public function initCharacterDeletionRequestMessage(characterId:Number = 0, secretAnswerHash:String = "") : CharacterDeletionRequestMessage
      {
         this.characterId = characterId;
         this.secretAnswerHash = secretAnswerHash;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.characterId = 0;
         this.secretAnswerHash = "";
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
         this.serializeAs_CharacterDeletionRequestMessage(output);
      }
      
      public function serializeAs_CharacterDeletionRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.characterId < 0 || this.characterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element characterId.");
         }
         output.writeVarLong(this.characterId);
         output.writeUTF(this.secretAnswerHash);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterDeletionRequestMessage(input);
      }
      
      public function deserializeAs_CharacterDeletionRequestMessage(input:ICustomDataInput) : void
      {
         this._characterIdFunc(input);
         this._secretAnswerHashFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterDeletionRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_CharacterDeletionRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._characterIdFunc);
         tree.addChild(this._secretAnswerHashFunc);
      }
      
      private function _characterIdFunc(input:ICustomDataInput) : void
      {
         this.characterId = input.readVarUhLong();
         if(this.characterId < 0 || this.characterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element of CharacterDeletionRequestMessage.characterId.");
         }
      }
      
      private function _secretAnswerHashFunc(input:ICustomDataInput) : void
      {
         this.secretAnswerHash = input.readUTF();
      }
   }
}
