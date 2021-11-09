package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameMapSpeedMovementMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1105;
       
      
      private var _isInitialized:Boolean = false;
      
      public var speedMultiplier:int = 0;
      
      public function GameMapSpeedMovementMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1105;
      }
      
      public function initGameMapSpeedMovementMessage(speedMultiplier:int = 0) : GameMapSpeedMovementMessage
      {
         this.speedMultiplier = speedMultiplier;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.speedMultiplier = 0;
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
         this.serializeAs_GameMapSpeedMovementMessage(output);
      }
      
      public function serializeAs_GameMapSpeedMovementMessage(output:ICustomDataOutput) : void
      {
         output.writeInt(this.speedMultiplier);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameMapSpeedMovementMessage(input);
      }
      
      public function deserializeAs_GameMapSpeedMovementMessage(input:ICustomDataInput) : void
      {
         this._speedMultiplierFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameMapSpeedMovementMessage(tree);
      }
      
      public function deserializeAsyncAs_GameMapSpeedMovementMessage(tree:FuncTree) : void
      {
         tree.addChild(this._speedMultiplierFunc);
      }
      
      private function _speedMultiplierFunc(input:ICustomDataInput) : void
      {
         this.speedMultiplier = input.readInt();
      }
   }
}
