package com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HouseGuildShareRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5369;
       
      
      private var _isInitialized:Boolean = false;
      
      public var houseId:uint = 0;
      
      public var instanceId:uint = 0;
      
      public var enable:Boolean = false;
      
      public var rights:uint = 0;
      
      public function HouseGuildShareRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5369;
      }
      
      public function initHouseGuildShareRequestMessage(houseId:uint = 0, instanceId:uint = 0, enable:Boolean = false, rights:uint = 0) : HouseGuildShareRequestMessage
      {
         this.houseId = houseId;
         this.instanceId = instanceId;
         this.enable = enable;
         this.rights = rights;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.houseId = 0;
         this.instanceId = 0;
         this.enable = false;
         this.rights = 0;
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
         this.serializeAs_HouseGuildShareRequestMessage(output);
      }
      
      public function serializeAs_HouseGuildShareRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         output.writeVarInt(this.houseId);
         if(this.instanceId < 0)
         {
            throw new Error("Forbidden value (" + this.instanceId + ") on element instanceId.");
         }
         output.writeInt(this.instanceId);
         output.writeBoolean(this.enable);
         if(this.rights < 0)
         {
            throw new Error("Forbidden value (" + this.rights + ") on element rights.");
         }
         output.writeVarInt(this.rights);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HouseGuildShareRequestMessage(input);
      }
      
      public function deserializeAs_HouseGuildShareRequestMessage(input:ICustomDataInput) : void
      {
         this._houseIdFunc(input);
         this._instanceIdFunc(input);
         this._enableFunc(input);
         this._rightsFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HouseGuildShareRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_HouseGuildShareRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._houseIdFunc);
         tree.addChild(this._instanceIdFunc);
         tree.addChild(this._enableFunc);
         tree.addChild(this._rightsFunc);
      }
      
      private function _houseIdFunc(input:ICustomDataInput) : void
      {
         this.houseId = input.readVarUhInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of HouseGuildShareRequestMessage.houseId.");
         }
      }
      
      private function _instanceIdFunc(input:ICustomDataInput) : void
      {
         this.instanceId = input.readInt();
         if(this.instanceId < 0)
         {
            throw new Error("Forbidden value (" + this.instanceId + ") on element of HouseGuildShareRequestMessage.instanceId.");
         }
      }
      
      private function _enableFunc(input:ICustomDataInput) : void
      {
         this.enable = input.readBoolean();
      }
      
      private function _rightsFunc(input:ICustomDataInput) : void
      {
         this.rights = input.readVarUhInt();
         if(this.rights < 0)
         {
            throw new Error("Forbidden value (" + this.rights + ") on element of HouseGuildShareRequestMessage.rights.");
         }
      }
   }
}
