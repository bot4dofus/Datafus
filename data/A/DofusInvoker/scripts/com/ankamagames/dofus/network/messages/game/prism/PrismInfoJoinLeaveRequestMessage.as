package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PrismInfoJoinLeaveRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9586;
       
      
      private var _isInitialized:Boolean = false;
      
      public var join:Boolean = false;
      
      public function PrismInfoJoinLeaveRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9586;
      }
      
      public function initPrismInfoJoinLeaveRequestMessage(join:Boolean = false) : PrismInfoJoinLeaveRequestMessage
      {
         this.join = join;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.join = false;
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
         this.serializeAs_PrismInfoJoinLeaveRequestMessage(output);
      }
      
      public function serializeAs_PrismInfoJoinLeaveRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.join);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PrismInfoJoinLeaveRequestMessage(input);
      }
      
      public function deserializeAs_PrismInfoJoinLeaveRequestMessage(input:ICustomDataInput) : void
      {
         this._joinFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PrismInfoJoinLeaveRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_PrismInfoJoinLeaveRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._joinFunc);
      }
      
      private function _joinFunc(input:ICustomDataInput) : void
      {
         this.join = input.readBoolean();
      }
   }
}
