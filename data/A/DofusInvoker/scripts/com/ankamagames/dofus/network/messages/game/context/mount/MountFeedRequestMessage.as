package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MountFeedRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5031;
       
      
      private var _isInitialized:Boolean = false;
      
      public var mountUid:uint = 0;
      
      public var mountLocation:int = 0;
      
      public var mountFoodUid:uint = 0;
      
      public var quantity:uint = 0;
      
      public function MountFeedRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5031;
      }
      
      public function initMountFeedRequestMessage(mountUid:uint = 0, mountLocation:int = 0, mountFoodUid:uint = 0, quantity:uint = 0) : MountFeedRequestMessage
      {
         this.mountUid = mountUid;
         this.mountLocation = mountLocation;
         this.mountFoodUid = mountFoodUid;
         this.quantity = quantity;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.mountUid = 0;
         this.mountLocation = 0;
         this.mountFoodUid = 0;
         this.quantity = 0;
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
         this.serializeAs_MountFeedRequestMessage(output);
      }
      
      public function serializeAs_MountFeedRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.mountUid < 0)
         {
            throw new Error("Forbidden value (" + this.mountUid + ") on element mountUid.");
         }
         output.writeVarInt(this.mountUid);
         output.writeByte(this.mountLocation);
         if(this.mountFoodUid < 0)
         {
            throw new Error("Forbidden value (" + this.mountFoodUid + ") on element mountFoodUid.");
         }
         output.writeVarInt(this.mountFoodUid);
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
         }
         output.writeVarInt(this.quantity);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MountFeedRequestMessage(input);
      }
      
      public function deserializeAs_MountFeedRequestMessage(input:ICustomDataInput) : void
      {
         this._mountUidFunc(input);
         this._mountLocationFunc(input);
         this._mountFoodUidFunc(input);
         this._quantityFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MountFeedRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_MountFeedRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._mountUidFunc);
         tree.addChild(this._mountLocationFunc);
         tree.addChild(this._mountFoodUidFunc);
         tree.addChild(this._quantityFunc);
      }
      
      private function _mountUidFunc(input:ICustomDataInput) : void
      {
         this.mountUid = input.readVarUhInt();
         if(this.mountUid < 0)
         {
            throw new Error("Forbidden value (" + this.mountUid + ") on element of MountFeedRequestMessage.mountUid.");
         }
      }
      
      private function _mountLocationFunc(input:ICustomDataInput) : void
      {
         this.mountLocation = input.readByte();
      }
      
      private function _mountFoodUidFunc(input:ICustomDataInput) : void
      {
         this.mountFoodUid = input.readVarUhInt();
         if(this.mountFoodUid < 0)
         {
            throw new Error("Forbidden value (" + this.mountFoodUid + ") on element of MountFeedRequestMessage.mountFoodUid.");
         }
      }
      
      private function _quantityFunc(input:ICustomDataInput) : void
      {
         this.quantity = input.readVarUhInt();
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element of MountFeedRequestMessage.quantity.");
         }
      }
   }
}
