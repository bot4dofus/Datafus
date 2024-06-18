package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ObjectUseMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1372;
       
      
      private var _isInitialized:Boolean = false;
      
      public var objectUID:uint = 0;
      
      public function ObjectUseMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1372;
      }
      
      public function initObjectUseMessage(objectUID:uint = 0) : ObjectUseMessage
      {
         this.objectUID = objectUID;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectUID = 0;
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
         this.serializeAs_ObjectUseMessage(output);
      }
      
      public function serializeAs_ObjectUseMessage(output:ICustomDataOutput) : void
      {
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         output.writeVarInt(this.objectUID);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectUseMessage(input);
      }
      
      public function deserializeAs_ObjectUseMessage(input:ICustomDataInput) : void
      {
         this._objectUIDFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectUseMessage(tree);
      }
      
      public function deserializeAsyncAs_ObjectUseMessage(tree:FuncTree) : void
      {
         tree.addChild(this._objectUIDFunc);
      }
      
      private function _objectUIDFunc(input:ICustomDataInput) : void
      {
         this.objectUID = input.readVarUhInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of ObjectUseMessage.objectUID.");
         }
      }
   }
}
