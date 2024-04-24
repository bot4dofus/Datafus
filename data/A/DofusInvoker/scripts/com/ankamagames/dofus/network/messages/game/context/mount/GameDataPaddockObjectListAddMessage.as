package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.dofus.network.types.game.paddock.PaddockItem;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameDataPaddockObjectListAddMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4187;
       
      
      private var _isInitialized:Boolean = false;
      
      public var paddockItemDescription:Vector.<PaddockItem>;
      
      private var _paddockItemDescriptiontree:FuncTree;
      
      public function GameDataPaddockObjectListAddMessage()
      {
         this.paddockItemDescription = new Vector.<PaddockItem>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4187;
      }
      
      public function initGameDataPaddockObjectListAddMessage(paddockItemDescription:Vector.<PaddockItem> = null) : GameDataPaddockObjectListAddMessage
      {
         this.paddockItemDescription = paddockItemDescription;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.paddockItemDescription = new Vector.<PaddockItem>();
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
         this.serializeAs_GameDataPaddockObjectListAddMessage(output);
      }
      
      public function serializeAs_GameDataPaddockObjectListAddMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.paddockItemDescription.length);
         for(var _i1:uint = 0; _i1 < this.paddockItemDescription.length; _i1++)
         {
            (this.paddockItemDescription[_i1] as PaddockItem).serializeAs_PaddockItem(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameDataPaddockObjectListAddMessage(input);
      }
      
      public function deserializeAs_GameDataPaddockObjectListAddMessage(input:ICustomDataInput) : void
      {
         var _item1:PaddockItem = null;
         var _paddockItemDescriptionLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _paddockItemDescriptionLen; _i1++)
         {
            _item1 = new PaddockItem();
            _item1.deserialize(input);
            this.paddockItemDescription.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameDataPaddockObjectListAddMessage(tree);
      }
      
      public function deserializeAsyncAs_GameDataPaddockObjectListAddMessage(tree:FuncTree) : void
      {
         this._paddockItemDescriptiontree = tree.addChild(this._paddockItemDescriptiontreeFunc);
      }
      
      private function _paddockItemDescriptiontreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._paddockItemDescriptiontree.addChild(this._paddockItemDescriptionFunc);
         }
      }
      
      private function _paddockItemDescriptionFunc(input:ICustomDataInput) : void
      {
         var _item:PaddockItem = new PaddockItem();
         _item.deserialize(input);
         this.paddockItemDescription.push(_item);
      }
   }
}
