package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MountInformationInPaddockRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7545;
       
      
      private var _isInitialized:Boolean = false;
      
      public var mapRideId:int = 0;
      
      public function MountInformationInPaddockRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7545;
      }
      
      public function initMountInformationInPaddockRequestMessage(mapRideId:int = 0) : MountInformationInPaddockRequestMessage
      {
         this.mapRideId = mapRideId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.mapRideId = 0;
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
         this.serializeAs_MountInformationInPaddockRequestMessage(output);
      }
      
      public function serializeAs_MountInformationInPaddockRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeVarInt(this.mapRideId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MountInformationInPaddockRequestMessage(input);
      }
      
      public function deserializeAs_MountInformationInPaddockRequestMessage(input:ICustomDataInput) : void
      {
         this._mapRideIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MountInformationInPaddockRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_MountInformationInPaddockRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._mapRideIdFunc);
      }
      
      private function _mapRideIdFunc(input:ICustomDataInput) : void
      {
         this.mapRideId = input.readVarInt();
      }
   }
}
