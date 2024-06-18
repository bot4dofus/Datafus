package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class LivingObjectMessageMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6015;
       
      
      private var _isInitialized:Boolean = false;
      
      public var msgId:uint = 0;
      
      public var timeStamp:uint = 0;
      
      public var owner:String = "";
      
      public var objectGenericId:uint = 0;
      
      public function LivingObjectMessageMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6015;
      }
      
      public function initLivingObjectMessageMessage(msgId:uint = 0, timeStamp:uint = 0, owner:String = "", objectGenericId:uint = 0) : LivingObjectMessageMessage
      {
         this.msgId = msgId;
         this.timeStamp = timeStamp;
         this.owner = owner;
         this.objectGenericId = objectGenericId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.msgId = 0;
         this.timeStamp = 0;
         this.owner = "";
         this.objectGenericId = 0;
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
         this.serializeAs_LivingObjectMessageMessage(output);
      }
      
      public function serializeAs_LivingObjectMessageMessage(output:ICustomDataOutput) : void
      {
         if(this.msgId < 0)
         {
            throw new Error("Forbidden value (" + this.msgId + ") on element msgId.");
         }
         output.writeVarShort(this.msgId);
         if(this.timeStamp < 0)
         {
            throw new Error("Forbidden value (" + this.timeStamp + ") on element timeStamp.");
         }
         output.writeInt(this.timeStamp);
         output.writeUTF(this.owner);
         if(this.objectGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.objectGenericId + ") on element objectGenericId.");
         }
         output.writeVarInt(this.objectGenericId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_LivingObjectMessageMessage(input);
      }
      
      public function deserializeAs_LivingObjectMessageMessage(input:ICustomDataInput) : void
      {
         this._msgIdFunc(input);
         this._timeStampFunc(input);
         this._ownerFunc(input);
         this._objectGenericIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_LivingObjectMessageMessage(tree);
      }
      
      public function deserializeAsyncAs_LivingObjectMessageMessage(tree:FuncTree) : void
      {
         tree.addChild(this._msgIdFunc);
         tree.addChild(this._timeStampFunc);
         tree.addChild(this._ownerFunc);
         tree.addChild(this._objectGenericIdFunc);
      }
      
      private function _msgIdFunc(input:ICustomDataInput) : void
      {
         this.msgId = input.readVarUhShort();
         if(this.msgId < 0)
         {
            throw new Error("Forbidden value (" + this.msgId + ") on element of LivingObjectMessageMessage.msgId.");
         }
      }
      
      private function _timeStampFunc(input:ICustomDataInput) : void
      {
         this.timeStamp = input.readInt();
         if(this.timeStamp < 0)
         {
            throw new Error("Forbidden value (" + this.timeStamp + ") on element of LivingObjectMessageMessage.timeStamp.");
         }
      }
      
      private function _ownerFunc(input:ICustomDataInput) : void
      {
         this.owner = input.readUTF();
      }
      
      private function _objectGenericIdFunc(input:ICustomDataInput) : void
      {
         this.objectGenericId = input.readVarUhInt();
         if(this.objectGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.objectGenericId + ") on element of LivingObjectMessageMessage.objectGenericId.");
         }
      }
   }
}
