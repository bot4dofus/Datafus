package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TeleportPlayerOfferMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9777;
       
      
      private var _isInitialized:Boolean = false;
      
      public var mapId:Number = 0;
      
      public var message:String = "";
      
      public var timeLeft:uint = 0;
      
      public var requesterId:Number = 0;
      
      public function TeleportPlayerOfferMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9777;
      }
      
      public function initTeleportPlayerOfferMessage(mapId:Number = 0, message:String = "", timeLeft:uint = 0, requesterId:Number = 0) : TeleportPlayerOfferMessage
      {
         this.mapId = mapId;
         this.message = message;
         this.timeLeft = timeLeft;
         this.requesterId = requesterId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.mapId = 0;
         this.message = "";
         this.timeLeft = 0;
         this.requesterId = 0;
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
         this.serializeAs_TeleportPlayerOfferMessage(output);
      }
      
      public function serializeAs_TeleportPlayerOfferMessage(output:ICustomDataOutput) : void
      {
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         output.writeDouble(this.mapId);
         output.writeUTF(this.message);
         if(this.timeLeft < 0)
         {
            throw new Error("Forbidden value (" + this.timeLeft + ") on element timeLeft.");
         }
         output.writeVarInt(this.timeLeft);
         if(this.requesterId < 0 || this.requesterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.requesterId + ") on element requesterId.");
         }
         output.writeVarLong(this.requesterId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TeleportPlayerOfferMessage(input);
      }
      
      public function deserializeAs_TeleportPlayerOfferMessage(input:ICustomDataInput) : void
      {
         this._mapIdFunc(input);
         this._messageFunc(input);
         this._timeLeftFunc(input);
         this._requesterIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TeleportPlayerOfferMessage(tree);
      }
      
      public function deserializeAsyncAs_TeleportPlayerOfferMessage(tree:FuncTree) : void
      {
         tree.addChild(this._mapIdFunc);
         tree.addChild(this._messageFunc);
         tree.addChild(this._timeLeftFunc);
         tree.addChild(this._requesterIdFunc);
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of TeleportPlayerOfferMessage.mapId.");
         }
      }
      
      private function _messageFunc(input:ICustomDataInput) : void
      {
         this.message = input.readUTF();
      }
      
      private function _timeLeftFunc(input:ICustomDataInput) : void
      {
         this.timeLeft = input.readVarUhInt();
         if(this.timeLeft < 0)
         {
            throw new Error("Forbidden value (" + this.timeLeft + ") on element of TeleportPlayerOfferMessage.timeLeft.");
         }
      }
      
      private function _requesterIdFunc(input:ICustomDataInput) : void
      {
         this.requesterId = input.readVarUhLong();
         if(this.requesterId < 0 || this.requesterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.requesterId + ") on element of TeleportPlayerOfferMessage.requesterId.");
         }
      }
   }
}
