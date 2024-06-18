package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightPlacementSwapPositionsAcceptMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 870;
       
      
      private var _isInitialized:Boolean = false;
      
      public var requestId:uint = 0;
      
      public function GameFightPlacementSwapPositionsAcceptMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 870;
      }
      
      public function initGameFightPlacementSwapPositionsAcceptMessage(requestId:uint = 0) : GameFightPlacementSwapPositionsAcceptMessage
      {
         this.requestId = requestId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.requestId = 0;
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
         this.serializeAs_GameFightPlacementSwapPositionsAcceptMessage(output);
      }
      
      public function serializeAs_GameFightPlacementSwapPositionsAcceptMessage(output:ICustomDataOutput) : void
      {
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element requestId.");
         }
         output.writeInt(this.requestId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightPlacementSwapPositionsAcceptMessage(input);
      }
      
      public function deserializeAs_GameFightPlacementSwapPositionsAcceptMessage(input:ICustomDataInput) : void
      {
         this._requestIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightPlacementSwapPositionsAcceptMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightPlacementSwapPositionsAcceptMessage(tree:FuncTree) : void
      {
         tree.addChild(this._requestIdFunc);
      }
      
      private function _requestIdFunc(input:ICustomDataInput) : void
      {
         this.requestId = input.readInt();
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element of GameFightPlacementSwapPositionsAcceptMessage.requestId.");
         }
      }
   }
}
