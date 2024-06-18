package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ObjectMovementMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4510;
       
      
      private var _isInitialized:Boolean = false;
      
      public var objectUID:uint = 0;
      
      public var position:uint = 63;
      
      public function ObjectMovementMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4510;
      }
      
      public function initObjectMovementMessage(objectUID:uint = 0, position:uint = 63) : ObjectMovementMessage
      {
         this.objectUID = objectUID;
         this.position = position;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectUID = 0;
         this.position = 63;
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
         this.serializeAs_ObjectMovementMessage(output);
      }
      
      public function serializeAs_ObjectMovementMessage(output:ICustomDataOutput) : void
      {
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         output.writeVarInt(this.objectUID);
         output.writeShort(this.position);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectMovementMessage(input);
      }
      
      public function deserializeAs_ObjectMovementMessage(input:ICustomDataInput) : void
      {
         this._objectUIDFunc(input);
         this._positionFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectMovementMessage(tree);
      }
      
      public function deserializeAsyncAs_ObjectMovementMessage(tree:FuncTree) : void
      {
         tree.addChild(this._objectUIDFunc);
         tree.addChild(this._positionFunc);
      }
      
      private function _objectUIDFunc(input:ICustomDataInput) : void
      {
         this.objectUID = input.readVarUhInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of ObjectMovementMessage.objectUID.");
         }
      }
      
      private function _positionFunc(input:ICustomDataInput) : void
      {
         this.position = input.readShort();
         if(this.position < 0)
         {
            throw new Error("Forbidden value (" + this.position + ") on element of ObjectMovementMessage.position.");
         }
      }
   }
}
