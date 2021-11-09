package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MapRewardRateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9264;
       
      
      private var _isInitialized:Boolean = false;
      
      public var mapRate:int = 0;
      
      public var subAreaRate:int = 0;
      
      public var totalRate:int = 0;
      
      public function MapRewardRateMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9264;
      }
      
      public function initMapRewardRateMessage(mapRate:int = 0, subAreaRate:int = 0, totalRate:int = 0) : MapRewardRateMessage
      {
         this.mapRate = mapRate;
         this.subAreaRate = subAreaRate;
         this.totalRate = totalRate;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.mapRate = 0;
         this.subAreaRate = 0;
         this.totalRate = 0;
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
         this.serializeAs_MapRewardRateMessage(output);
      }
      
      public function serializeAs_MapRewardRateMessage(output:ICustomDataOutput) : void
      {
         output.writeVarShort(this.mapRate);
         output.writeVarShort(this.subAreaRate);
         output.writeVarShort(this.totalRate);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MapRewardRateMessage(input);
      }
      
      public function deserializeAs_MapRewardRateMessage(input:ICustomDataInput) : void
      {
         this._mapRateFunc(input);
         this._subAreaRateFunc(input);
         this._totalRateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MapRewardRateMessage(tree);
      }
      
      public function deserializeAsyncAs_MapRewardRateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._mapRateFunc);
         tree.addChild(this._subAreaRateFunc);
         tree.addChild(this._totalRateFunc);
      }
      
      private function _mapRateFunc(input:ICustomDataInput) : void
      {
         this.mapRate = input.readVarShort();
      }
      
      private function _subAreaRateFunc(input:ICustomDataInput) : void
      {
         this.subAreaRate = input.readVarShort();
      }
      
      private function _totalRateFunc(input:ICustomDataInput) : void
      {
         this.totalRate = input.readVarShort();
      }
   }
}
