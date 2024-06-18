package com.ankamagames.dofus.network.messages.game.startup
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionItemConsumedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5525;
       
      
      private var _isInitialized:Boolean = false;
      
      public var success:Boolean = false;
      
      public var actionId:uint = 0;
      
      public var automaticAction:Boolean = false;
      
      public function GameActionItemConsumedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5525;
      }
      
      public function initGameActionItemConsumedMessage(success:Boolean = false, actionId:uint = 0, automaticAction:Boolean = false) : GameActionItemConsumedMessage
      {
         this.success = success;
         this.actionId = actionId;
         this.automaticAction = automaticAction;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.success = false;
         this.actionId = 0;
         this.automaticAction = false;
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
         this.serializeAs_GameActionItemConsumedMessage(output);
      }
      
      public function serializeAs_GameActionItemConsumedMessage(output:ICustomDataOutput) : void
      {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.success);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.automaticAction);
         output.writeByte(_box0);
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element actionId.");
         }
         output.writeInt(this.actionId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionItemConsumedMessage(input);
      }
      
      public function deserializeAs_GameActionItemConsumedMessage(input:ICustomDataInput) : void
      {
         this.deserializeByteBoxes(input);
         this._actionIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionItemConsumedMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionItemConsumedMessage(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._actionIdFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.success = BooleanByteWrapper.getFlag(_box0,0);
         this.automaticAction = BooleanByteWrapper.getFlag(_box0,1);
      }
      
      private function _actionIdFunc(input:ICustomDataInput) : void
      {
         this.actionId = input.readInt();
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element of GameActionItemConsumedMessage.actionId.");
         }
      }
   }
}
