package com.ankamagames.dofus.network.messages.game.chat.channel
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChannelEnablingChangeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7739;
       
      
      private var _isInitialized:Boolean = false;
      
      public var channel:uint = 0;
      
      public var enable:Boolean = false;
      
      public function ChannelEnablingChangeMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7739;
      }
      
      public function initChannelEnablingChangeMessage(channel:uint = 0, enable:Boolean = false) : ChannelEnablingChangeMessage
      {
         this.channel = channel;
         this.enable = enable;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.channel = 0;
         this.enable = false;
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
         this.serializeAs_ChannelEnablingChangeMessage(output);
      }
      
      public function serializeAs_ChannelEnablingChangeMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.channel);
         output.writeBoolean(this.enable);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChannelEnablingChangeMessage(input);
      }
      
      public function deserializeAs_ChannelEnablingChangeMessage(input:ICustomDataInput) : void
      {
         this._channelFunc(input);
         this._enableFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChannelEnablingChangeMessage(tree);
      }
      
      public function deserializeAsyncAs_ChannelEnablingChangeMessage(tree:FuncTree) : void
      {
         tree.addChild(this._channelFunc);
         tree.addChild(this._enableFunc);
      }
      
      private function _channelFunc(input:ICustomDataInput) : void
      {
         this.channel = input.readByte();
         if(this.channel < 0)
         {
            throw new Error("Forbidden value (" + this.channel + ") on element of ChannelEnablingChangeMessage.channel.");
         }
      }
      
      private function _enableFunc(input:ICustomDataInput) : void
      {
         this.enable = input.readBoolean();
      }
   }
}
