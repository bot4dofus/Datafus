package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GroupTeleportPlayerOfferMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3076;
       
      
      private var _isInitialized:Boolean = false;
      
      public var mapId:Number = 0;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var timeLeft:uint = 0;
      
      public var requesterId:Number = 0;
      
      public var requesterName:String = "";
      
      public function GroupTeleportPlayerOfferMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3076;
      }
      
      public function initGroupTeleportPlayerOfferMessage(mapId:Number = 0, worldX:int = 0, worldY:int = 0, timeLeft:uint = 0, requesterId:Number = 0, requesterName:String = "") : GroupTeleportPlayerOfferMessage
      {
         this.mapId = mapId;
         this.worldX = worldX;
         this.worldY = worldY;
         this.timeLeft = timeLeft;
         this.requesterId = requesterId;
         this.requesterName = requesterName;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.mapId = 0;
         this.worldX = 0;
         this.worldY = 0;
         this.timeLeft = 0;
         this.requesterId = 0;
         this.requesterName = "";
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
         this.serializeAs_GroupTeleportPlayerOfferMessage(output);
      }
      
      public function serializeAs_GroupTeleportPlayerOfferMessage(output:ICustomDataOutput) : void
      {
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         output.writeDouble(this.mapId);
         output.writeShort(this.worldX);
         output.writeShort(this.worldY);
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
         output.writeUTF(this.requesterName);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GroupTeleportPlayerOfferMessage(input);
      }
      
      public function deserializeAs_GroupTeleportPlayerOfferMessage(input:ICustomDataInput) : void
      {
         this._mapIdFunc(input);
         this._worldXFunc(input);
         this._worldYFunc(input);
         this._timeLeftFunc(input);
         this._requesterIdFunc(input);
         this._requesterNameFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GroupTeleportPlayerOfferMessage(tree);
      }
      
      public function deserializeAsyncAs_GroupTeleportPlayerOfferMessage(tree:FuncTree) : void
      {
         tree.addChild(this._mapIdFunc);
         tree.addChild(this._worldXFunc);
         tree.addChild(this._worldYFunc);
         tree.addChild(this._timeLeftFunc);
         tree.addChild(this._requesterIdFunc);
         tree.addChild(this._requesterNameFunc);
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of GroupTeleportPlayerOfferMessage.mapId.");
         }
      }
      
      private function _worldXFunc(input:ICustomDataInput) : void
      {
         this.worldX = input.readShort();
      }
      
      private function _worldYFunc(input:ICustomDataInput) : void
      {
         this.worldY = input.readShort();
      }
      
      private function _timeLeftFunc(input:ICustomDataInput) : void
      {
         this.timeLeft = input.readVarUhInt();
         if(this.timeLeft < 0)
         {
            throw new Error("Forbidden value (" + this.timeLeft + ") on element of GroupTeleportPlayerOfferMessage.timeLeft.");
         }
      }
      
      private function _requesterIdFunc(input:ICustomDataInput) : void
      {
         this.requesterId = input.readVarUhLong();
         if(this.requesterId < 0 || this.requesterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.requesterId + ") on element of GroupTeleportPlayerOfferMessage.requesterId.");
         }
      }
      
      private function _requesterNameFunc(input:ICustomDataInput) : void
      {
         this.requesterName = input.readUTF();
      }
   }
}
