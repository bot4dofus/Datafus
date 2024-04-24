package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightTurnFinishMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7713;
       
      
      private var _isInitialized:Boolean = false;
      
      public var isAfk:Boolean = false;
      
      public function GameFightTurnFinishMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7713;
      }
      
      public function initGameFightTurnFinishMessage(isAfk:Boolean = false) : GameFightTurnFinishMessage
      {
         this.isAfk = isAfk;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.isAfk = false;
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
         this.serializeAs_GameFightTurnFinishMessage(output);
      }
      
      public function serializeAs_GameFightTurnFinishMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.isAfk);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightTurnFinishMessage(input);
      }
      
      public function deserializeAs_GameFightTurnFinishMessage(input:ICustomDataInput) : void
      {
         this._isAfkFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightTurnFinishMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightTurnFinishMessage(tree:FuncTree) : void
      {
         tree.addChild(this._isAfkFunc);
      }
      
      private function _isAfkFunc(input:ICustomDataInput) : void
      {
         this.isAfk = input.readBoolean();
      }
   }
}
