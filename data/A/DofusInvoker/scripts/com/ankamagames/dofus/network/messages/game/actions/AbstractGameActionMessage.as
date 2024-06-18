package com.ankamagames.dofus.network.messages.game.actions
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AbstractGameActionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9631;
       
      
      private var _isInitialized:Boolean = false;
      
      public var actionId:uint = 0;
      
      public var sourceId:Number = 0;
      
      public function AbstractGameActionMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9631;
      }
      
      public function initAbstractGameActionMessage(actionId:uint = 0, sourceId:Number = 0) : AbstractGameActionMessage
      {
         this.actionId = actionId;
         this.sourceId = sourceId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.actionId = 0;
         this.sourceId = 0;
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
         this.serializeAs_AbstractGameActionMessage(output);
      }
      
      public function serializeAs_AbstractGameActionMessage(output:ICustomDataOutput) : void
      {
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element actionId.");
         }
         output.writeVarShort(this.actionId);
         if(this.sourceId < -9007199254740992 || this.sourceId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.sourceId + ") on element sourceId.");
         }
         output.writeDouble(this.sourceId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AbstractGameActionMessage(input);
      }
      
      public function deserializeAs_AbstractGameActionMessage(input:ICustomDataInput) : void
      {
         this._actionIdFunc(input);
         this._sourceIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AbstractGameActionMessage(tree);
      }
      
      public function deserializeAsyncAs_AbstractGameActionMessage(tree:FuncTree) : void
      {
         tree.addChild(this._actionIdFunc);
         tree.addChild(this._sourceIdFunc);
      }
      
      private function _actionIdFunc(input:ICustomDataInput) : void
      {
         this.actionId = input.readVarUhShort();
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element of AbstractGameActionMessage.actionId.");
         }
      }
      
      private function _sourceIdFunc(input:ICustomDataInput) : void
      {
         this.sourceId = input.readDouble();
         if(this.sourceId < -9007199254740992 || this.sourceId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.sourceId + ") on element of AbstractGameActionMessage.sourceId.");
         }
      }
   }
}
