package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightTurnReadyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9655;
       
      
      private var _isInitialized:Boolean = false;
      
      public var isReady:Boolean = false;
      
      public function GameFightTurnReadyMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9655;
      }
      
      public function initGameFightTurnReadyMessage(isReady:Boolean = false) : GameFightTurnReadyMessage
      {
         this.isReady = isReady;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.isReady = false;
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
         this.serializeAs_GameFightTurnReadyMessage(output);
      }
      
      public function serializeAs_GameFightTurnReadyMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.isReady);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightTurnReadyMessage(input);
      }
      
      public function deserializeAs_GameFightTurnReadyMessage(input:ICustomDataInput) : void
      {
         this._isReadyFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightTurnReadyMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightTurnReadyMessage(tree:FuncTree) : void
      {
         tree.addChild(this._isReadyFunc);
      }
      
      private function _isReadyFunc(input:ICustomDataInput) : void
      {
         this.isReady = input.readBoolean();
      }
   }
}
