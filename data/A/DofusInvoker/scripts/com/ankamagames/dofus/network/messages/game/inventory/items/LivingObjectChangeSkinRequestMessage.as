package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class LivingObjectChangeSkinRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9449;
       
      
      private var _isInitialized:Boolean = false;
      
      public var livingUID:uint = 0;
      
      public var livingPosition:uint = 0;
      
      public var skinId:uint = 0;
      
      public function LivingObjectChangeSkinRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9449;
      }
      
      public function initLivingObjectChangeSkinRequestMessage(livingUID:uint = 0, livingPosition:uint = 0, skinId:uint = 0) : LivingObjectChangeSkinRequestMessage
      {
         this.livingUID = livingUID;
         this.livingPosition = livingPosition;
         this.skinId = skinId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.livingUID = 0;
         this.livingPosition = 0;
         this.skinId = 0;
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
         this.serializeAs_LivingObjectChangeSkinRequestMessage(output);
      }
      
      public function serializeAs_LivingObjectChangeSkinRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.livingUID < 0)
         {
            throw new Error("Forbidden value (" + this.livingUID + ") on element livingUID.");
         }
         output.writeVarInt(this.livingUID);
         if(this.livingPosition < 0 || this.livingPosition > 255)
         {
            throw new Error("Forbidden value (" + this.livingPosition + ") on element livingPosition.");
         }
         output.writeByte(this.livingPosition);
         if(this.skinId < 0)
         {
            throw new Error("Forbidden value (" + this.skinId + ") on element skinId.");
         }
         output.writeVarInt(this.skinId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_LivingObjectChangeSkinRequestMessage(input);
      }
      
      public function deserializeAs_LivingObjectChangeSkinRequestMessage(input:ICustomDataInput) : void
      {
         this._livingUIDFunc(input);
         this._livingPositionFunc(input);
         this._skinIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_LivingObjectChangeSkinRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_LivingObjectChangeSkinRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._livingUIDFunc);
         tree.addChild(this._livingPositionFunc);
         tree.addChild(this._skinIdFunc);
      }
      
      private function _livingUIDFunc(input:ICustomDataInput) : void
      {
         this.livingUID = input.readVarUhInt();
         if(this.livingUID < 0)
         {
            throw new Error("Forbidden value (" + this.livingUID + ") on element of LivingObjectChangeSkinRequestMessage.livingUID.");
         }
      }
      
      private function _livingPositionFunc(input:ICustomDataInput) : void
      {
         this.livingPosition = input.readUnsignedByte();
         if(this.livingPosition < 0 || this.livingPosition > 255)
         {
            throw new Error("Forbidden value (" + this.livingPosition + ") on element of LivingObjectChangeSkinRequestMessage.livingPosition.");
         }
      }
      
      private function _skinIdFunc(input:ICustomDataInput) : void
      {
         this.skinId = input.readVarUhInt();
         if(this.skinId < 0)
         {
            throw new Error("Forbidden value (" + this.skinId + ") on element of LivingObjectChangeSkinRequestMessage.skinId.");
         }
      }
   }
}
