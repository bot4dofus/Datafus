package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.DecraftedItemStackInfo;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class DecraftResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3985;
       
      
      private var _isInitialized:Boolean = false;
      
      public var results:Vector.<DecraftedItemStackInfo>;
      
      private var _resultstree:FuncTree;
      
      public function DecraftResultMessage()
      {
         this.results = new Vector.<DecraftedItemStackInfo>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3985;
      }
      
      public function initDecraftResultMessage(results:Vector.<DecraftedItemStackInfo> = null) : DecraftResultMessage
      {
         this.results = results;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.results = new Vector.<DecraftedItemStackInfo>();
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
         this.serializeAs_DecraftResultMessage(output);
      }
      
      public function serializeAs_DecraftResultMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.results.length);
         for(var _i1:uint = 0; _i1 < this.results.length; _i1++)
         {
            (this.results[_i1] as DecraftedItemStackInfo).serializeAs_DecraftedItemStackInfo(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_DecraftResultMessage(input);
      }
      
      public function deserializeAs_DecraftResultMessage(input:ICustomDataInput) : void
      {
         var _item1:DecraftedItemStackInfo = null;
         var _resultsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _resultsLen; _i1++)
         {
            _item1 = new DecraftedItemStackInfo();
            _item1.deserialize(input);
            this.results.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_DecraftResultMessage(tree);
      }
      
      public function deserializeAsyncAs_DecraftResultMessage(tree:FuncTree) : void
      {
         this._resultstree = tree.addChild(this._resultstreeFunc);
      }
      
      private function _resultstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._resultstree.addChild(this._resultsFunc);
         }
      }
      
      private function _resultsFunc(input:ICustomDataInput) : void
      {
         var _item:DecraftedItemStackInfo = new DecraftedItemStackInfo();
         _item.deserialize(input);
         this.results.push(_item);
      }
   }
}
