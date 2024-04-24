package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightPlacementSwapPositionsRequestMessage extends GameFightPlacementPositionRequestMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3586;
       
      
      private var _isInitialized:Boolean = false;
      
      public var requestedId:Number = 0;
      
      public function GameFightPlacementSwapPositionsRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3586;
      }
      
      public function initGameFightPlacementSwapPositionsRequestMessage(cellId:uint = 0, requestedId:Number = 0) : GameFightPlacementSwapPositionsRequestMessage
      {
         super.initGameFightPlacementPositionRequestMessage(cellId);
         this.requestedId = requestedId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.requestedId = 0;
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightPlacementSwapPositionsRequestMessage(output);
      }
      
      public function serializeAs_GameFightPlacementSwapPositionsRequestMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightPlacementPositionRequestMessage(output);
         if(this.requestedId < -9007199254740992 || this.requestedId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.requestedId + ") on element requestedId.");
         }
         output.writeDouble(this.requestedId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightPlacementSwapPositionsRequestMessage(input);
      }
      
      public function deserializeAs_GameFightPlacementSwapPositionsRequestMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._requestedIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightPlacementSwapPositionsRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightPlacementSwapPositionsRequestMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._requestedIdFunc);
      }
      
      private function _requestedIdFunc(input:ICustomDataInput) : void
      {
         this.requestedId = input.readDouble();
         if(this.requestedId < -9007199254740992 || this.requestedId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.requestedId + ") on element of GameFightPlacementSwapPositionsRequestMessage.requestedId.");
         }
      }
   }
}
