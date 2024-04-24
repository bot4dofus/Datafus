package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class IgnoredDeleteResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6419;
       
      
      private var _isInitialized:Boolean = false;
      
      public var success:Boolean = false;
      
      public var tag:AccountTagInformation;
      
      public var session:Boolean = false;
      
      private var _tagtree:FuncTree;
      
      public function IgnoredDeleteResultMessage()
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
         return 6419;
      }
      
      public function initIgnoredDeleteResultMessage(success:Boolean = false, tag:AccountTagInformation = null, session:Boolean = false) : IgnoredDeleteResultMessage
      {
         this.success = success;
         this.tag = tag;
         this.session = session;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.success = false;
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
         this.serializeAs_IgnoredDeleteResultMessage(output);
      }
      
      public function serializeAs_IgnoredDeleteResultMessage(output:ICustomDataOutput) : void
      {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.success);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.session);
         output.writeByte(_box0);
         this.tag.serializeAs_AccountTagInformation(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IgnoredDeleteResultMessage(input);
      }
      
      public function deserializeAs_IgnoredDeleteResultMessage(input:ICustomDataInput) : void
      {
         this.deserializeByteBoxes(input);
         this.tag = new AccountTagInformation();
         this.tag.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IgnoredDeleteResultMessage(tree);
      }
      
      public function deserializeAsyncAs_IgnoredDeleteResultMessage(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeByteBoxes);
         this._tagtree = tree.addChild(this._tagtreeFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.success = BooleanByteWrapper.getFlag(_box0,0);
         this.session = BooleanByteWrapper.getFlag(_box0,1);
      }
      
      private function _tagtreeFunc(input:ICustomDataInput) : void
      {
         this.tag = new AccountTagInformation();
         this.tag.deserializeAsync(this._tagtree);
      }
   }
}
