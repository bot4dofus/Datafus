package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GroupTeleportPlayerCloseMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5607;
       
      
      private var _isInitialized:Boolean = false;
      
      public var mapId:Number = 0;
      
      public var requesterId:Number = 0;
      
      public function GroupTeleportPlayerCloseMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5607;
      }
      
      public function initGroupTeleportPlayerCloseMessage(mapId:Number = 0, requesterId:Number = 0) : GroupTeleportPlayerCloseMessage
      {
         this.mapId = mapId;
         this.requesterId = requesterId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.mapId = 0;
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
         this.serializeAs_GroupTeleportPlayerCloseMessage(output);
      }
      
      public function serializeAs_GroupTeleportPlayerCloseMessage(output:ICustomDataOutput) : void
      {
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         output.writeDouble(this.mapId);
         if(this.requesterId < 0 || this.requesterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.requesterId + ") on element requesterId.");
         }
         output.writeVarLong(this.requesterId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GroupTeleportPlayerCloseMessage(input);
      }
      
      public function deserializeAs_GroupTeleportPlayerCloseMessage(input:ICustomDataInput) : void
      {
         this._mapIdFunc(input);
         this._requesterIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GroupTeleportPlayerCloseMessage(tree);
      }
      
      public function deserializeAsyncAs_GroupTeleportPlayerCloseMessage(tree:FuncTree) : void
      {
         tree.addChild(this._mapIdFunc);
         tree.addChild(this._requesterIdFunc);
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of GroupTeleportPlayerCloseMessage.mapId.");
         }
      }
      
      private function _requesterIdFunc(input:ICustomDataInput) : void
      {
         this.requesterId = input.readVarUhLong();
         if(this.requesterId < 0 || this.requesterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.requesterId + ") on element of GroupTeleportPlayerCloseMessage.requesterId.");
         }
      }
   }
}
