package com.ankamagames.dofus.network.messages.game.interactive.zaap
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TeleportRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7069;
       
      
      private var _isInitialized:Boolean = false;
      
      public var sourceType:uint = 0;
      
      public var destinationType:uint = 0;
      
      public var mapId:Number = 0;
      
      public function TeleportRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7069;
      }
      
      public function initTeleportRequestMessage(sourceType:uint = 0, destinationType:uint = 0, mapId:Number = 0) : TeleportRequestMessage
      {
         this.sourceType = sourceType;
         this.destinationType = destinationType;
         this.mapId = mapId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.sourceType = 0;
         this.destinationType = 0;
         this.mapId = 0;
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
         this.serializeAs_TeleportRequestMessage(output);
      }
      
      public function serializeAs_TeleportRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.sourceType);
         output.writeByte(this.destinationType);
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         output.writeDouble(this.mapId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TeleportRequestMessage(input);
      }
      
      public function deserializeAs_TeleportRequestMessage(input:ICustomDataInput) : void
      {
         this._sourceTypeFunc(input);
         this._destinationTypeFunc(input);
         this._mapIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TeleportRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_TeleportRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._sourceTypeFunc);
         tree.addChild(this._destinationTypeFunc);
         tree.addChild(this._mapIdFunc);
      }
      
      private function _sourceTypeFunc(input:ICustomDataInput) : void
      {
         this.sourceType = input.readByte();
         if(this.sourceType < 0)
         {
            throw new Error("Forbidden value (" + this.sourceType + ") on element of TeleportRequestMessage.sourceType.");
         }
      }
      
      private function _destinationTypeFunc(input:ICustomDataInput) : void
      {
         this.destinationType = input.readByte();
         if(this.destinationType < 0)
         {
            throw new Error("Forbidden value (" + this.destinationType + ") on element of TeleportRequestMessage.destinationType.");
         }
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of TeleportRequestMessage.mapId.");
         }
      }
   }
}
