package com.ankamagames.dofus.network.messages.game.character.deletion
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CharacterDeletionPrepareMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5348;
       
      
      private var _isInitialized:Boolean = false;
      
      public var characterId:Number = 0;
      
      public var characterName:String = "";
      
      public var secretQuestion:String = "";
      
      public var needSecretAnswer:Boolean = false;
      
      public function CharacterDeletionPrepareMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5348;
      }
      
      public function initCharacterDeletionPrepareMessage(characterId:Number = 0, characterName:String = "", secretQuestion:String = "", needSecretAnswer:Boolean = false) : CharacterDeletionPrepareMessage
      {
         this.characterId = characterId;
         this.characterName = characterName;
         this.secretQuestion = secretQuestion;
         this.needSecretAnswer = needSecretAnswer;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.characterId = 0;
         this.characterName = "";
         this.secretQuestion = "";
         this.needSecretAnswer = false;
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
         this.serializeAs_CharacterDeletionPrepareMessage(output);
      }
      
      public function serializeAs_CharacterDeletionPrepareMessage(output:ICustomDataOutput) : void
      {
         if(this.characterId < 0 || this.characterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element characterId.");
         }
         output.writeVarLong(this.characterId);
         output.writeUTF(this.characterName);
         output.writeUTF(this.secretQuestion);
         output.writeBoolean(this.needSecretAnswer);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterDeletionPrepareMessage(input);
      }
      
      public function deserializeAs_CharacterDeletionPrepareMessage(input:ICustomDataInput) : void
      {
         this._characterIdFunc(input);
         this._characterNameFunc(input);
         this._secretQuestionFunc(input);
         this._needSecretAnswerFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterDeletionPrepareMessage(tree);
      }
      
      public function deserializeAsyncAs_CharacterDeletionPrepareMessage(tree:FuncTree) : void
      {
         tree.addChild(this._characterIdFunc);
         tree.addChild(this._characterNameFunc);
         tree.addChild(this._secretQuestionFunc);
         tree.addChild(this._needSecretAnswerFunc);
      }
      
      private function _characterIdFunc(input:ICustomDataInput) : void
      {
         this.characterId = input.readVarUhLong();
         if(this.characterId < 0 || this.characterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element of CharacterDeletionPrepareMessage.characterId.");
         }
      }
      
      private function _characterNameFunc(input:ICustomDataInput) : void
      {
         this.characterName = input.readUTF();
      }
      
      private function _secretQuestionFunc(input:ICustomDataInput) : void
      {
         this.secretQuestion = input.readUTF();
      }
      
      private function _needSecretAnswerFunc(input:ICustomDataInput) : void
      {
         this.needSecretAnswer = input.readBoolean();
      }
   }
}
