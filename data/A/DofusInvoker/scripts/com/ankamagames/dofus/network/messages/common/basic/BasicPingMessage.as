package com.ankamagames.dofus.network.messages.common.basic
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BasicPingMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8285;
       
      
      private var _isInitialized:Boolean = false;
      
      public var quiet:Boolean = false;
      
      public function BasicPingMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8285;
      }
      
      public function initBasicPingMessage(quiet:Boolean = false) : BasicPingMessage
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
         this.serializeAs_BasicPingMessage(output);
      }
      
      public function serializeAs_BasicPingMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.quiet);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BasicPingMessage(input);
      }
      
      public function deserializeAs_BasicPingMessage(input:ICustomDataInput) : void
      {
         this._quietFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BasicPingMessage(tree);
      }
      
      public function deserializeAsyncAs_BasicPingMessage(tree:FuncTree) : void
      {
         tree.addChild(this._quietFunc);
      }
      
      private function _quietFunc(input:ICustomDataInput) : void
      {
         this.quiet = input.readBoolean();
      }
   }
}
