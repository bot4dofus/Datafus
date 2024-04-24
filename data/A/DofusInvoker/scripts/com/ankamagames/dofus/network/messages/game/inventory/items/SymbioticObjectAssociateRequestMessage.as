package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SymbioticObjectAssociateRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5354;
       
      
      private var _isInitialized:Boolean = false;
      
      public var symbioteUID:uint = 0;
      
      public var symbiotePos:uint = 0;
      
      public var hostUID:uint = 0;
      
      public var hostPos:uint = 0;
      
      public function SymbioticObjectAssociateRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5354;
      }
      
      public function initSymbioticObjectAssociateRequestMessage(symbioteUID:uint = 0, symbiotePos:uint = 0, hostUID:uint = 0, hostPos:uint = 0) : SymbioticObjectAssociateRequestMessage
      {
         this.symbioteUID = symbioteUID;
         this.symbiotePos = symbiotePos;
         this.hostUID = hostUID;
         this.hostPos = hostPos;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.symbioteUID = 0;
         this.symbiotePos = 0;
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
         this.serializeAs_SymbioticObjectAssociateRequestMessage(output);
      }
      
      public function serializeAs_SymbioticObjectAssociateRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.symbioteUID < 0)
         {
            throw new Error("Forbidden value (" + this.symbioteUID + ") on element symbioteUID.");
         }
         output.writeVarInt(this.symbioteUID);
         if(this.symbiotePos < 0 || this.symbiotePos > 255)
         {
            throw new Error("Forbidden value (" + this.symbiotePos + ") on element symbiotePos.");
         }
         output.writeByte(this.symbiotePos);
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
         this.deserializeAs_SymbioticObjectAssociateRequestMessage(input);
      }
      
      public function deserializeAs_SymbioticObjectAssociateRequestMessage(input:ICustomDataInput) : void
      {
         this._symbioteUIDFunc(input);
         this._symbiotePosFunc(input);
         this._hostUIDFunc(input);
         this._hostPosFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SymbioticObjectAssociateRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_SymbioticObjectAssociateRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._symbioteUIDFunc);
         tree.addChild(this._symbiotePosFunc);
         tree.addChild(this._hostUIDFunc);
         tree.addChild(this._hostPosFunc);
      }
      
      private function _symbioteUIDFunc(input:ICustomDataInput) : void
      {
         this.symbioteUID = input.readVarUhInt();
         if(this.symbioteUID < 0)
         {
            throw new Error("Forbidden value (" + this.symbioteUID + ") on element of SymbioticObjectAssociateRequestMessage.symbioteUID.");
         }
      }
      
      private function _symbiotePosFunc(input:ICustomDataInput) : void
      {
         this.symbiotePos = input.readUnsignedByte();
         if(this.symbiotePos < 0 || this.symbiotePos > 255)
         {
            throw new Error("Forbidden value (" + this.symbiotePos + ") on element of SymbioticObjectAssociateRequestMessage.symbiotePos.");
         }
      }
      
      private function _hostUIDFunc(input:ICustomDataInput) : void
      {
         this.hostUID = input.readVarUhInt();
         if(this.hostUID < 0)
         {
            throw new Error("Forbidden value (" + this.hostUID + ") on element of SymbioticObjectAssociateRequestMessage.hostUID.");
         }
      }
      
      private function _hostPosFunc(input:ICustomDataInput) : void
      {
         this.hostPos = input.readUnsignedByte();
         if(this.hostPos < 0 || this.hostPos > 255)
         {
            throw new Error("Forbidden value (" + this.hostPos + ") on element of SymbioticObjectAssociateRequestMessage.hostPos.");
         }
      }
   }
}
