package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightNewRoundMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9614;
       
      
      private var _isInitialized:Boolean = false;
      
      public var roundNumber:uint = 0;
      
      public function GameFightNewRoundMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9614;
      }
      
      public function initGameFightNewRoundMessage(roundNumber:uint = 0) : GameFightNewRoundMessage
      {
         this.roundNumber = roundNumber;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.roundNumber = 0;
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
         this.serializeAs_GameFightNewRoundMessage(output);
      }
      
      public function serializeAs_GameFightNewRoundMessage(output:ICustomDataOutput) : void
      {
         if(this.roundNumber < 0)
         {
            throw new Error("Forbidden value (" + this.roundNumber + ") on element roundNumber.");
         }
         output.writeVarInt(this.roundNumber);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightNewRoundMessage(input);
      }
      
      public function deserializeAs_GameFightNewRoundMessage(input:ICustomDataInput) : void
      {
         this._roundNumberFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightNewRoundMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightNewRoundMessage(tree:FuncTree) : void
      {
         tree.addChild(this._roundNumberFunc);
      }
      
      private function _roundNumberFunc(input:ICustomDataInput) : void
      {
         this.roundNumber = input.readVarUhInt();
         if(this.roundNumber < 0)
         {
            throw new Error("Forbidden value (" + this.roundNumber + ") on element of GameFightNewRoundMessage.roundNumber.");
         }
      }
   }
}
