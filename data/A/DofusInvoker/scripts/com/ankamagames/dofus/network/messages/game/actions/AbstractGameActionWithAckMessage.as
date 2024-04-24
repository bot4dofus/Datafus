package com.ankamagames.dofus.network.messages.game.actions
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AbstractGameActionWithAckMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2943;
       
      
      private var _isInitialized:Boolean = false;
      
      public var waitAckId:int = 0;
      
      public function AbstractGameActionWithAckMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2943;
      }
      
      public function initAbstractGameActionWithAckMessage(actionId:uint = 0, sourceId:Number = 0, waitAckId:int = 0) : AbstractGameActionWithAckMessage
      {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.waitAckId = waitAckId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.waitAckId = 0;
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
         this.serializeAs_AbstractGameActionWithAckMessage(output);
      }
      
      public function serializeAs_AbstractGameActionWithAckMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeShort(this.waitAckId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AbstractGameActionWithAckMessage(input);
      }
      
      public function deserializeAs_AbstractGameActionWithAckMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._waitAckIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AbstractGameActionWithAckMessage(tree);
      }
      
      public function deserializeAsyncAs_AbstractGameActionWithAckMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._waitAckIdFunc);
      }
      
      private function _waitAckIdFunc(input:ICustomDataInput) : void
      {
         this.waitAckId = input.readShort();
      }
   }
}
