package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SubareaRewardRateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1743;
       
      
      private var _isInitialized:Boolean = false;
      
      public var subAreaRate:int = 0;
      
      public function SubareaRewardRateMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1743;
      }
      
      public function initSubareaRewardRateMessage(subAreaRate:int = 0) : SubareaRewardRateMessage
      {
         this.subAreaRate = subAreaRate;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.subAreaRate = 0;
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
         this.serializeAs_SubareaRewardRateMessage(output);
      }
      
      public function serializeAs_SubareaRewardRateMessage(output:ICustomDataOutput) : void
      {
         output.writeVarShort(this.subAreaRate);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SubareaRewardRateMessage(input);
      }
      
      public function deserializeAs_SubareaRewardRateMessage(input:ICustomDataInput) : void
      {
         this._subAreaRateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SubareaRewardRateMessage(tree);
      }
      
      public function deserializeAsyncAs_SubareaRewardRateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._subAreaRateFunc);
      }
      
      private function _subAreaRateFunc(input:ICustomDataInput) : void
      {
         this.subAreaRate = input.readVarShort();
      }
   }
}
