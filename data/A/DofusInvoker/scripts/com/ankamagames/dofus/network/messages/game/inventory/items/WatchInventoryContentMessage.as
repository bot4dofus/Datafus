package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class WatchInventoryContentMessage extends InventoryContentMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4610;
       
      
      private var _isInitialized:Boolean = false;
      
      public function WatchInventoryContentMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4610;
      }
      
      public function initWatchInventoryContentMessage(objects:Vector.<ObjectItem> = null, kamas:Number = 0) : WatchInventoryContentMessage
      {
         super.initInventoryContentMessage(objects,kamas);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_WatchInventoryContentMessage(output);
      }
      
      public function serializeAs_WatchInventoryContentMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_InventoryContentMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_WatchInventoryContentMessage(input);
      }
      
      public function deserializeAs_WatchInventoryContentMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_WatchInventoryContentMessage(tree);
      }
      
      public function deserializeAsyncAs_WatchInventoryContentMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
