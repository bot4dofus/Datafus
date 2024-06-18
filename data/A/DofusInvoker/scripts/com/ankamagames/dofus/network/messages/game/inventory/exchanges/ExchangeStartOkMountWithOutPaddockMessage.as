package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.dofus.network.types.game.mount.MountClientData;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeStartOkMountWithOutPaddockMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1232;
       
      
      private var _isInitialized:Boolean = false;
      
      public var stabledMountsDescription:Vector.<MountClientData>;
      
      private var _stabledMountsDescriptiontree:FuncTree;
      
      public function ExchangeStartOkMountWithOutPaddockMessage()
      {
         this.stabledMountsDescription = new Vector.<MountClientData>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1232;
      }
      
      public function initExchangeStartOkMountWithOutPaddockMessage(stabledMountsDescription:Vector.<MountClientData> = null) : ExchangeStartOkMountWithOutPaddockMessage
      {
         this.stabledMountsDescription = stabledMountsDescription;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.stabledMountsDescription = new Vector.<MountClientData>();
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
         this.serializeAs_ExchangeStartOkMountWithOutPaddockMessage(output);
      }
      
      public function serializeAs_ExchangeStartOkMountWithOutPaddockMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.stabledMountsDescription.length);
         for(var _i1:uint = 0; _i1 < this.stabledMountsDescription.length; _i1++)
         {
            (this.stabledMountsDescription[_i1] as MountClientData).serializeAs_MountClientData(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeStartOkMountWithOutPaddockMessage(input);
      }
      
      public function deserializeAs_ExchangeStartOkMountWithOutPaddockMessage(input:ICustomDataInput) : void
      {
         var _item1:MountClientData = null;
         var _stabledMountsDescriptionLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _stabledMountsDescriptionLen; _i1++)
         {
            _item1 = new MountClientData();
            _item1.deserialize(input);
            this.stabledMountsDescription.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeStartOkMountWithOutPaddockMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeStartOkMountWithOutPaddockMessage(tree:FuncTree) : void
      {
         this._stabledMountsDescriptiontree = tree.addChild(this._stabledMountsDescriptiontreeFunc);
      }
      
      private function _stabledMountsDescriptiontreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._stabledMountsDescriptiontree.addChild(this._stabledMountsDescriptionFunc);
         }
      }
      
      private function _stabledMountsDescriptionFunc(input:ICustomDataInput) : void
      {
         var _item:MountClientData = new MountClientData();
         _item.deserialize(input);
         this.stabledMountsDescription.push(_item);
      }
   }
}
