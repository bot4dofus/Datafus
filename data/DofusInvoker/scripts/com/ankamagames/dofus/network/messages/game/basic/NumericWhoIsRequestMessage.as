package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class NumericWhoIsRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5829;
       
      
      private var _isInitialized:Boolean = false;
      
      public var playerId:Number = 0;
      
      public function NumericWhoIsRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5829;
      }
      
      public function initNumericWhoIsRequestMessage(playerId:Number = 0) : NumericWhoIsRequestMessage
      {
         this.playerId = playerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.playerId = 0;
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
         this.serializeAs_NumericWhoIsRequestMessage(output);
      }
      
      public function serializeAs_NumericWhoIsRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_NumericWhoIsRequestMessage(input);
      }
      
      public function deserializeAs_NumericWhoIsRequestMessage(input:ICustomDataInput) : void
      {
         this._playerIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_NumericWhoIsRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_NumericWhoIsRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._playerIdFunc);
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of NumericWhoIsRequestMessage.playerId.");
         }
      }
   }
}
