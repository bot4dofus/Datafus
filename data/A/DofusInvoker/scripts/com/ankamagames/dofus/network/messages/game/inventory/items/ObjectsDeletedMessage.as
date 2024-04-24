package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ObjectsDeletedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2538;
       
      
      private var _isInitialized:Boolean = false;
      
      public var objectUID:Vector.<uint>;
      
      private var _objectUIDtree:FuncTree;
      
      public function ObjectsDeletedMessage()
      {
         this.objectUID = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2538;
      }
      
      public function initObjectsDeletedMessage(objectUID:Vector.<uint> = null) : ObjectsDeletedMessage
      {
         this.objectUID = objectUID;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectUID = new Vector.<uint>();
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
         this.serializeAs_ObjectsDeletedMessage(output);
      }
      
      public function serializeAs_ObjectsDeletedMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.objectUID.length);
         for(var _i1:uint = 0; _i1 < this.objectUID.length; _i1++)
         {
            if(this.objectUID[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.objectUID[_i1] + ") on element 1 (starting at 1) of objectUID.");
            }
            output.writeVarInt(this.objectUID[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectsDeletedMessage(input);
      }
      
      public function deserializeAs_ObjectsDeletedMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _objectUIDLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _objectUIDLen; _i1++)
         {
            _val1 = input.readVarUhInt();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of objectUID.");
            }
            this.objectUID.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectsDeletedMessage(tree);
      }
      
      public function deserializeAsyncAs_ObjectsDeletedMessage(tree:FuncTree) : void
      {
         this._objectUIDtree = tree.addChild(this._objectUIDtreeFunc);
      }
      
      private function _objectUIDtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._objectUIDtree.addChild(this._objectUIDFunc);
         }
      }
      
      private function _objectUIDFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of objectUID.");
         }
         this.objectUID.push(_val);
      }
   }
}
