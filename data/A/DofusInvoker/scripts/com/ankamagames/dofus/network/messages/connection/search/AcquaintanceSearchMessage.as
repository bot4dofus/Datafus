package com.ankamagames.dofus.network.messages.connection.search
{
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AcquaintanceSearchMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1642;
       
      
      private var _isInitialized:Boolean = false;
      
      public var tag:AccountTagInformation;
      
      private var _tagtree:FuncTree;
      
      public function AcquaintanceSearchMessage()
      {
         this.tag = new AccountTagInformation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1642;
      }
      
      public function initAcquaintanceSearchMessage(tag:AccountTagInformation = null) : AcquaintanceSearchMessage
      {
         this.tag = tag;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.tag = new AccountTagInformation();
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
         this.serializeAs_AcquaintanceSearchMessage(output);
      }
      
      public function serializeAs_AcquaintanceSearchMessage(output:ICustomDataOutput) : void
      {
         this.tag.serializeAs_AccountTagInformation(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AcquaintanceSearchMessage(input);
      }
      
      public function deserializeAs_AcquaintanceSearchMessage(input:ICustomDataInput) : void
      {
         this.tag = new AccountTagInformation();
         this.tag.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AcquaintanceSearchMessage(tree);
      }
      
      public function deserializeAsyncAs_AcquaintanceSearchMessage(tree:FuncTree) : void
      {
         this._tagtree = tree.addChild(this._tagtreeFunc);
      }
      
      private function _tagtreeFunc(input:ICustomDataInput) : void
      {
         this.tag = new AccountTagInformation();
         this.tag.deserializeAsync(this._tagtree);
      }
   }
}
