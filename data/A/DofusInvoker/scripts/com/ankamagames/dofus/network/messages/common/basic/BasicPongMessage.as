package com.ankamagames.dofus.network.messages.common.basic
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BasicPongMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4877;
       
      
      private var _isInitialized:Boolean = false;
      
      public var quiet:Boolean = false;
      
      public function BasicPongMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4877;
      }
      
      public function initBasicPongMessage(quiet:Boolean = false) : BasicPongMessage
      {
         this.quiet = quiet;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.quiet = false;
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
         this.serializeAs_BasicPongMessage(output);
      }
      
      public function serializeAs_BasicPongMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.quiet);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BasicPongMessage(input);
      }
      
      public function deserializeAs_BasicPongMessage(input:ICustomDataInput) : void
      {
         this._quietFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BasicPongMessage(tree);
      }
      
      public function deserializeAsyncAs_BasicPongMessage(tree:FuncTree) : void
      {
         tree.addChild(this._quietFunc);
      }
      
      private function _quietFunc(input:ICustomDataInput) : void
      {
         this.quiet = input.readBoolean();
      }
   }
}
