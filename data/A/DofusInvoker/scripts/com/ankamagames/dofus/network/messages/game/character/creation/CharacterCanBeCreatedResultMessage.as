package com.ankamagames.dofus.network.messages.game.character.creation
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CharacterCanBeCreatedResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7317;
       
      
      private var _isInitialized:Boolean = false;
      
      public var yesYouCan:Boolean = false;
      
      public function CharacterCanBeCreatedResultMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7317;
      }
      
      public function initCharacterCanBeCreatedResultMessage(yesYouCan:Boolean = false) : CharacterCanBeCreatedResultMessage
      {
         this.yesYouCan = yesYouCan;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.yesYouCan = false;
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
         this.serializeAs_CharacterCanBeCreatedResultMessage(output);
      }
      
      public function serializeAs_CharacterCanBeCreatedResultMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.yesYouCan);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterCanBeCreatedResultMessage(input);
      }
      
      public function deserializeAs_CharacterCanBeCreatedResultMessage(input:ICustomDataInput) : void
      {
         this._yesYouCanFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterCanBeCreatedResultMessage(tree);
      }
      
      public function deserializeAsyncAs_CharacterCanBeCreatedResultMessage(tree:FuncTree) : void
      {
         tree.addChild(this._yesYouCanFunc);
      }
      
      private function _yesYouCanFunc(input:ICustomDataInput) : void
      {
         this.yesYouCan = input.readBoolean();
      }
   }
}
