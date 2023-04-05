package com.ankamagames.dofus.network.messages.security
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class RawDataMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6253;
       
      
      private var _isInitialized:Boolean = false;
      
      public var content:ByteArray;
      
      public function RawDataMessage()
      {
         this.content = new ByteArray();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6253;
      }
      
      public function initRawDataMessage(content:ByteArray = null) : RawDataMessage
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
         this.serializeAs_RawDataMessage(output);
      }
      
      public function serializeAs_RawDataMessage(output:ICustomDataOutput) : void
      {
         output.writeVarInt(this.content.length);
         for(var _i1:uint = 0; _i1 < this.content.length; _i1++)
         {
            output.writeByte(this.content[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_RawDataMessage(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_RawDataMessage(tree);
      }
      
      public function deserializeAs_RawDataMessage(input:ICustomDataInput) : void
      {
         var _contentLen:uint = input.readVarInt();
         input.readBytes(this.content,0,_contentLen);
      }
      
      public function deserializeAsyncAs_RawDataMessage(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeAs_RawDataMessage);
      }
   }
}
