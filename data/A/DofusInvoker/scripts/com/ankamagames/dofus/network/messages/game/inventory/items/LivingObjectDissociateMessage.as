package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class LivingObjectDissociateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6070;
       
      
      private var _isInitialized:Boolean = false;
      
      public var livingUID:uint = 0;
      
      public var livingPosition:uint = 0;
      
      public function LivingObjectDissociateMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6070;
      }
      
      public function initLivingObjectDissociateMessage(livingUID:uint = 0, livingPosition:uint = 0) : LivingObjectDissociateMessage
      {
         this.livingUID = livingUID;
         this.livingPosition = livingPosition;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.livingUID = 0;
         this.livingPosition = 0;
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
         this.serializeAs_LivingObjectDissociateMessage(output);
      }
      
      public function serializeAs_LivingObjectDissociateMessage(output:ICustomDataOutput) : void
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
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_LivingObjectDissociateMessage(input);
      }
      
      public function deserializeAs_LivingObjectDissociateMessage(input:ICustomDataInput) : void
      {
         this._livingUIDFunc(input);
         this._livingPositionFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_LivingObjectDissociateMessage(tree);
      }
      
      public function deserializeAsyncAs_LivingObjectDissociateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._livingUIDFunc);
         tree.addChild(this._livingPositionFunc);
      }
      
      private function _livingUIDFunc(input:ICustomDataInput) : void
      {
         this.livingUID = input.readVarUhInt();
         if(this.livingUID < 0)
         {
            throw new Error("Forbidden value (" + this.livingUID + ") on element of LivingObjectDissociateMessage.livingUID.");
         }
      }
      
      private function _livingPositionFunc(input:ICustomDataInput) : void
      {
         this.livingPosition = input.readUnsignedByte();
         if(this.livingPosition < 0 || this.livingPosition > 255)
         {
            throw new Error("Forbidden value (" + this.livingPosition + ") on element of LivingObjectDissociateMessage.livingPosition.");
         }
      }
   }
}
