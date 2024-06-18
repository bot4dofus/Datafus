package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ObjectAddedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6866;
       
      
      private var _isInitialized:Boolean = false;
      
      public var object:ObjectItem;
      
      public var origin:uint = 0;
      
      private var _objecttree:FuncTree;
      
      public function ObjectAddedMessage()
      {
         this.object = new ObjectItem();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6866;
      }
      
      public function initObjectAddedMessage(object:ObjectItem = null, origin:uint = 0) : ObjectAddedMessage
      {
         this.object = object;
         this.origin = origin;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.object = new ObjectItem();
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
         this.serializeAs_ObjectAddedMessage(output);
      }
      
      public function serializeAs_ObjectAddedMessage(output:ICustomDataOutput) : void
      {
         this.object.serializeAs_ObjectItem(output);
         output.writeByte(this.origin);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectAddedMessage(input);
      }
      
      public function deserializeAs_ObjectAddedMessage(input:ICustomDataInput) : void
      {
         this.object = new ObjectItem();
         this.object.deserialize(input);
         this._originFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectAddedMessage(tree);
      }
      
      public function deserializeAsyncAs_ObjectAddedMessage(tree:FuncTree) : void
      {
         this._objecttree = tree.addChild(this._objecttreeFunc);
         tree.addChild(this._originFunc);
      }
      
      private function _objecttreeFunc(input:ICustomDataInput) : void
      {
         this.object = new ObjectItem();
         this.object.deserializeAsync(this._objecttree);
      }
      
      private function _originFunc(input:ICustomDataInput) : void
      {
         this.origin = input.readByte();
         if(this.origin < 0)
         {
            throw new Error("Forbidden value (" + this.origin + ") on element of ObjectAddedMessage.origin.");
         }
      }
   }
}
