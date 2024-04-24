package com.ankamagames.dofus.network.messages.common.basic
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BasicStatMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5844;
       
      
      private var _isInitialized:Boolean = false;
      
      public var timeSpent:Number = 0;
      
      public var statId:uint = 0;
      
      public function BasicStatMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5844;
      }
      
      public function initBasicStatMessage(timeSpent:Number = 0, statId:uint = 0) : BasicStatMessage
      {
         this.timeSpent = timeSpent;
         this.statId = statId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.timeSpent = 0;
         this.statId = 0;
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
         this.serializeAs_BasicStatMessage(output);
      }
      
      public function serializeAs_BasicStatMessage(output:ICustomDataOutput) : void
      {
         if(this.timeSpent < 0 || this.timeSpent > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.timeSpent + ") on element timeSpent.");
         }
         output.writeDouble(this.timeSpent);
         output.writeVarShort(this.statId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BasicStatMessage(input);
      }
      
      public function deserializeAs_BasicStatMessage(input:ICustomDataInput) : void
      {
         this._timeSpentFunc(input);
         this._statIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BasicStatMessage(tree);
      }
      
      public function deserializeAsyncAs_BasicStatMessage(tree:FuncTree) : void
      {
         tree.addChild(this._timeSpentFunc);
         tree.addChild(this._statIdFunc);
      }
      
      private function _timeSpentFunc(input:ICustomDataInput) : void
      {
         this.timeSpent = input.readDouble();
         if(this.timeSpent < 0 || this.timeSpent > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.timeSpent + ") on element of BasicStatMessage.timeSpent.");
         }
      }
      
      private function _statIdFunc(input:ICustomDataInput) : void
      {
         this.statId = input.readVarUhShort();
         if(this.statId < 0)
         {
            throw new Error("Forbidden value (" + this.statId + ") on element of BasicStatMessage.statId.");
         }
      }
   }
}
