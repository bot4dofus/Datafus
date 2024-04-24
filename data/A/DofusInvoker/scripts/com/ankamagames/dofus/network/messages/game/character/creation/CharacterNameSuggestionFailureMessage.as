package com.ankamagames.dofus.network.messages.game.character.creation
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CharacterNameSuggestionFailureMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7428;
       
      
      private var _isInitialized:Boolean = false;
      
      public var reason:uint = 1;
      
      public function CharacterNameSuggestionFailureMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7428;
      }
      
      public function initCharacterNameSuggestionFailureMessage(reason:uint = 1) : CharacterNameSuggestionFailureMessage
      {
         this.reason = reason;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.reason = 1;
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
         this.serializeAs_CharacterNameSuggestionFailureMessage(output);
      }
      
      public function serializeAs_CharacterNameSuggestionFailureMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.reason);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterNameSuggestionFailureMessage(input);
      }
      
      public function deserializeAs_CharacterNameSuggestionFailureMessage(input:ICustomDataInput) : void
      {
         this._reasonFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterNameSuggestionFailureMessage(tree);
      }
      
      public function deserializeAsyncAs_CharacterNameSuggestionFailureMessage(tree:FuncTree) : void
      {
         tree.addChild(this._reasonFunc);
      }
      
      private function _reasonFunc(input:ICustomDataInput) : void
      {
         this.reason = input.readByte();
         if(this.reason < 0)
         {
            throw new Error("Forbidden value (" + this.reason + ") on element of CharacterNameSuggestionFailureMessage.reason.");
         }
      }
   }
}
