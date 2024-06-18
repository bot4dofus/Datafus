package com.ankamagames.dofus.network.messages.game.inventory
{
   import com.ankamagames.dofus.network.types.game.inventory.StorageTabInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MultiTabStorageMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7356;
       
      
      private var _isInitialized:Boolean = false;
      
      public var tabs:Vector.<StorageTabInformation>;
      
      private var _tabstree:FuncTree;
      
      public function MultiTabStorageMessage()
      {
         this.tabs = new Vector.<StorageTabInformation>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7356;
      }
      
      public function initMultiTabStorageMessage(tabs:Vector.<StorageTabInformation> = null) : MultiTabStorageMessage
      {
         this.tabs = tabs;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.tabs = new Vector.<StorageTabInformation>();
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
         this.serializeAs_MultiTabStorageMessage(output);
      }
      
      public function serializeAs_MultiTabStorageMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.tabs.length);
         for(var _i1:uint = 0; _i1 < this.tabs.length; _i1++)
         {
            (this.tabs[_i1] as StorageTabInformation).serializeAs_StorageTabInformation(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MultiTabStorageMessage(input);
      }
      
      public function deserializeAs_MultiTabStorageMessage(input:ICustomDataInput) : void
      {
         var _item1:StorageTabInformation = null;
         var _tabsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _tabsLen; _i1++)
         {
            _item1 = new StorageTabInformation();
            _item1.deserialize(input);
            this.tabs.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MultiTabStorageMessage(tree);
      }
      
      public function deserializeAsyncAs_MultiTabStorageMessage(tree:FuncTree) : void
      {
         this._tabstree = tree.addChild(this._tabstreeFunc);
      }
      
      private function _tabstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._tabstree.addChild(this._tabsFunc);
         }
      }
      
      private function _tabsFunc(input:ICustomDataInput) : void
      {
         var _item:StorageTabInformation = new StorageTabInformation();
         _item.deserialize(input);
         this.tabs.push(_item);
      }
   }
}
