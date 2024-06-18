package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightPauseMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1045;
       
      
      private var _isInitialized:Boolean = false;
      
      public var isPaused:Boolean = false;
      
      public function GameFightPauseMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1045;
      }
      
      public function initGameFightPauseMessage(isPaused:Boolean = false) : GameFightPauseMessage
      {
         this.isPaused = isPaused;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.isPaused = false;
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
         this.serializeAs_GameFightPauseMessage(output);
      }
      
      public function serializeAs_GameFightPauseMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.isPaused);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightPauseMessage(input);
      }
      
      public function deserializeAs_GameFightPauseMessage(input:ICustomDataInput) : void
      {
         this._isPausedFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightPauseMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightPauseMessage(tree:FuncTree) : void
      {
         tree.addChild(this._isPausedFunc);
      }
      
      private function _isPausedFunc(input:ICustomDataInput) : void
      {
         this.isPaused = input.readBoolean();
      }
   }
}
