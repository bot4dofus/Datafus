package com.ankamagames.dofus.network.messages.game.character.creation
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CharacterCreationResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2193;
       
      
      private var _isInitialized:Boolean = false;
      
      public var result:uint = 1;
      
      public var reason:uint = 1;
      
      public function CharacterCreationResultMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2193;
      }
      
      public function initCharacterCreationResultMessage(result:uint = 1, reason:uint = 1) : CharacterCreationResultMessage
      {
         this.result = result;
         this.reason = reason;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.result = 1;
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
         this.serializeAs_CharacterCreationResultMessage(output);
      }
      
      public function serializeAs_CharacterCreationResultMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.result);
         output.writeByte(this.reason);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterCreationResultMessage(input);
      }
      
      public function deserializeAs_CharacterCreationResultMessage(input:ICustomDataInput) : void
      {
         this._resultFunc(input);
         this._reasonFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterCreationResultMessage(tree);
      }
      
      public function deserializeAsyncAs_CharacterCreationResultMessage(tree:FuncTree) : void
      {
         tree.addChild(this._resultFunc);
         tree.addChild(this._reasonFunc);
      }
      
      private function _resultFunc(input:ICustomDataInput) : void
      {
         this.result = input.readByte();
         if(this.result < 0)
         {
            throw new Error("Forbidden value (" + this.result + ") on element of CharacterCreationResultMessage.result.");
         }
      }
      
      private function _reasonFunc(input:ICustomDataInput) : void
      {
         this.reason = input.readByte();
         if(this.reason < 0)
         {
            throw new Error("Forbidden value (" + this.reason + ") on element of CharacterCreationResultMessage.reason.");
         }
      }
   }
}
