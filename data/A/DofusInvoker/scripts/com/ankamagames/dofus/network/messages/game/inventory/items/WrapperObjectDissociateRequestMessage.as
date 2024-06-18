package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class WrapperObjectDissociateRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5244;
       
      
      private var _isInitialized:Boolean = false;
      
      public var hostUID:uint = 0;
      
      public var hostPos:uint = 0;
      
      public function WrapperObjectDissociateRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5244;
      }
      
      public function initWrapperObjectDissociateRequestMessage(hostUID:uint = 0, hostPos:uint = 0) : WrapperObjectDissociateRequestMessage
      {
         this.hostUID = hostUID;
         this.hostPos = hostPos;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.hostUID = 0;
         this.hostPos = 0;
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
         this.serializeAs_WrapperObjectDissociateRequestMessage(output);
      }
      
      public function serializeAs_WrapperObjectDissociateRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.hostUID < 0)
         {
            throw new Error("Forbidden value (" + this.hostUID + ") on element hostUID.");
         }
         output.writeVarInt(this.hostUID);
         if(this.hostPos < 0 || this.hostPos > 255)
         {
            throw new Error("Forbidden value (" + this.hostPos + ") on element hostPos.");
         }
         output.writeByte(this.hostPos);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_WrapperObjectDissociateRequestMessage(input);
      }
      
      public function deserializeAs_WrapperObjectDissociateRequestMessage(input:ICustomDataInput) : void
      {
         this._hostUIDFunc(input);
         this._hostPosFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_WrapperObjectDissociateRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_WrapperObjectDissociateRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._hostUIDFunc);
         tree.addChild(this._hostPosFunc);
      }
      
      private function _hostUIDFunc(input:ICustomDataInput) : void
      {
         this.hostUID = input.readVarUhInt();
         if(this.hostUID < 0)
         {
            throw new Error("Forbidden value (" + this.hostUID + ") on element of WrapperObjectDissociateRequestMessage.hostUID.");
         }
      }
      
      private function _hostPosFunc(input:ICustomDataInput) : void
      {
         this.hostPos = input.readUnsignedByte();
         if(this.hostPos < 0 || this.hostPos > 255)
         {
            throw new Error("Forbidden value (" + this.hostPos + ") on element of WrapperObjectDissociateRequestMessage.hostPos.");
         }
      }
   }
}
