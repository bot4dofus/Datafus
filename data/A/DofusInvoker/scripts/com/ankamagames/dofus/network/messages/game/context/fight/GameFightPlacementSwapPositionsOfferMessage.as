package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightPlacementSwapPositionsOfferMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3056;
       
      
      private var _isInitialized:Boolean = false;
      
      public var requestId:uint = 0;
      
      public var requesterId:Number = 0;
      
      public var requesterCellId:uint = 0;
      
      public var requestedId:Number = 0;
      
      public var requestedCellId:uint = 0;
      
      public function GameFightPlacementSwapPositionsOfferMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3056;
      }
      
      public function initGameFightPlacementSwapPositionsOfferMessage(requestId:uint = 0, requesterId:Number = 0, requesterCellId:uint = 0, requestedId:Number = 0, requestedCellId:uint = 0) : GameFightPlacementSwapPositionsOfferMessage
      {
         this.requestId = requestId;
         this.requesterId = requesterId;
         this.requesterCellId = requesterCellId;
         this.requestedId = requestedId;
         this.requestedCellId = requestedCellId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.requestId = 0;
         this.requesterId = 0;
         this.requesterCellId = 0;
         this.requestedId = 0;
         this.requestedCellId = 0;
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
         this.serializeAs_GameFightPlacementSwapPositionsOfferMessage(output);
      }
      
      public function serializeAs_GameFightPlacementSwapPositionsOfferMessage(output:ICustomDataOutput) : void
      {
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element requestId.");
         }
         output.writeInt(this.requestId);
         if(this.requesterId < -9007199254740992 || this.requesterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.requesterId + ") on element requesterId.");
         }
         output.writeDouble(this.requesterId);
         if(this.requesterCellId < 0 || this.requesterCellId > 559)
         {
            throw new Error("Forbidden value (" + this.requesterCellId + ") on element requesterCellId.");
         }
         output.writeVarShort(this.requesterCellId);
         if(this.requestedId < -9007199254740992 || this.requestedId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.requestedId + ") on element requestedId.");
         }
         output.writeDouble(this.requestedId);
         if(this.requestedCellId < 0 || this.requestedCellId > 559)
         {
            throw new Error("Forbidden value (" + this.requestedCellId + ") on element requestedCellId.");
         }
         output.writeVarShort(this.requestedCellId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightPlacementSwapPositionsOfferMessage(input);
      }
      
      public function deserializeAs_GameFightPlacementSwapPositionsOfferMessage(input:ICustomDataInput) : void
      {
         this._requestIdFunc(input);
         this._requesterIdFunc(input);
         this._requesterCellIdFunc(input);
         this._requestedIdFunc(input);
         this._requestedCellIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightPlacementSwapPositionsOfferMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightPlacementSwapPositionsOfferMessage(tree:FuncTree) : void
      {
         tree.addChild(this._requestIdFunc);
         tree.addChild(this._requesterIdFunc);
         tree.addChild(this._requesterCellIdFunc);
         tree.addChild(this._requestedIdFunc);
         tree.addChild(this._requestedCellIdFunc);
      }
      
      private function _requestIdFunc(input:ICustomDataInput) : void
      {
         this.requestId = input.readInt();
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element of GameFightPlacementSwapPositionsOfferMessage.requestId.");
         }
      }
      
      private function _requesterIdFunc(input:ICustomDataInput) : void
      {
         this.requesterId = input.readDouble();
         if(this.requesterId < -9007199254740992 || this.requesterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.requesterId + ") on element of GameFightPlacementSwapPositionsOfferMessage.requesterId.");
         }
      }
      
      private function _requesterCellIdFunc(input:ICustomDataInput) : void
      {
         this.requesterCellId = input.readVarUhShort();
         if(this.requesterCellId < 0 || this.requesterCellId > 559)
         {
            throw new Error("Forbidden value (" + this.requesterCellId + ") on element of GameFightPlacementSwapPositionsOfferMessage.requesterCellId.");
         }
      }
      
      private function _requestedIdFunc(input:ICustomDataInput) : void
      {
         this.requestedId = input.readDouble();
         if(this.requestedId < -9007199254740992 || this.requestedId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.requestedId + ") on element of GameFightPlacementSwapPositionsOfferMessage.requestedId.");
         }
      }
      
      private function _requestedCellIdFunc(input:ICustomDataInput) : void
      {
         this.requestedCellId = input.readVarUhShort();
         if(this.requestedCellId < 0 || this.requestedCellId > 559)
         {
            throw new Error("Forbidden value (" + this.requestedCellId + ") on element of GameFightPlacementSwapPositionsOfferMessage.requestedCellId.");
         }
      }
   }
}
