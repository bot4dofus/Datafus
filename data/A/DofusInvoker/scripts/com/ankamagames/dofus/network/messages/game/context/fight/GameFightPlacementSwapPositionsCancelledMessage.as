package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightPlacementSwapPositionsCancelledMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1579;
       
      
      private var _isInitialized:Boolean = false;
      
      public var requestId:uint = 0;
      
      public var cancellerId:Number = 0;
      
      public function GameFightPlacementSwapPositionsCancelledMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1579;
      }
      
      public function initGameFightPlacementSwapPositionsCancelledMessage(requestId:uint = 0, cancellerId:Number = 0) : GameFightPlacementSwapPositionsCancelledMessage
      {
         this.requestId = requestId;
         this.cancellerId = cancellerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.requestId = 0;
         this.cancellerId = 0;
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
         this.serializeAs_GameFightPlacementSwapPositionsCancelledMessage(output);
      }
      
      public function serializeAs_GameFightPlacementSwapPositionsCancelledMessage(output:ICustomDataOutput) : void
      {
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element requestId.");
         }
         output.writeInt(this.requestId);
         if(this.cancellerId < -9007199254740992 || this.cancellerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.cancellerId + ") on element cancellerId.");
         }
         output.writeDouble(this.cancellerId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightPlacementSwapPositionsCancelledMessage(input);
      }
      
      public function deserializeAs_GameFightPlacementSwapPositionsCancelledMessage(input:ICustomDataInput) : void
      {
         this._requestIdFunc(input);
         this._cancellerIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightPlacementSwapPositionsCancelledMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightPlacementSwapPositionsCancelledMessage(tree:FuncTree) : void
      {
         tree.addChild(this._requestIdFunc);
         tree.addChild(this._cancellerIdFunc);
      }
      
      private function _requestIdFunc(input:ICustomDataInput) : void
      {
         this.requestId = input.readInt();
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element of GameFightPlacementSwapPositionsCancelledMessage.requestId.");
         }
      }
      
      private function _cancellerIdFunc(input:ICustomDataInput) : void
      {
         this.cancellerId = input.readDouble();
         if(this.cancellerId < -9007199254740992 || this.cancellerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.cancellerId + ") on element of GameFightPlacementSwapPositionsCancelledMessage.cancellerId.");
         }
      }
   }
}
