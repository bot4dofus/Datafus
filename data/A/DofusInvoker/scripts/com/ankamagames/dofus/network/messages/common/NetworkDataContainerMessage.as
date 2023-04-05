package com.ankamagames.dofus.network.messages.common
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkDataContainerMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class NetworkDataContainerMessage extends NetworkMessage implements INetworkMessage, INetworkDataContainerMessage
   {
      
      public static const protocolId:uint = 2;
       
      
      private var _content:ByteArray;
      
      private var _isInitialized:Boolean = false;
      
      public function NetworkDataContainerMessage()
      {
         super();
      }
      
      public function get content() : ByteArray
      {
         return this._content;
      }
      
      public function set content(value:ByteArray) : void
      {
         this._content = value;
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2;
      }
      
      public function initNetworkDataContainerMessage(content:ByteArray = null) : NetworkDataContainerMessage
      {
         this.content = content;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.content = new ByteArray();
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
         this.serializeAs_NetworkDataContainerMessage(output);
      }
      
      public function serializeAs_NetworkDataContainerMessage(output:ICustomDataOutput) : void
      {
         output.writeBytes(this.content);
         throw new Error("Not implemented");
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_NetworkDataContainerMessage(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_RawDataMessage(tree);
      }
      
      public function deserializeAs_NetworkDataContainerMessage(input:ICustomDataInput) : void
      {
         var _contentLen:uint = input.readVarInt();
         var tmpBuffer:ByteArray = new ByteArray();
         input.readBytes(tmpBuffer,0,_contentLen);
         tmpBuffer.uncompress();
         this.content = tmpBuffer;
      }
      
      public function deserializeAsyncAs_RawDataMessage(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeAs_NetworkDataContainerMessage);
      }
   }
}
