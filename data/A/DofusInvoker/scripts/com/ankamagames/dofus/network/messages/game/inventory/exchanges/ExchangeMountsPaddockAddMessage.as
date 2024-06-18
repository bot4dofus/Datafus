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
   
   public class ExchangeMountsPaddockAddMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8350;
       
      
      private var _isInitialized:Boolean = false;
      
      public var mountDescription:Vector.<MountClientData>;
      
      private var _mountDescriptiontree:FuncTree;
      
      public function ExchangeMountsPaddockAddMessage()
      {
         this.mountDescription = new Vector.<MountClientData>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8350;
      }
      
      public function initExchangeMountsPaddockAddMessage(mountDescription:Vector.<MountClientData> = null) : ExchangeMountsPaddockAddMessage
      {
         this.mountDescription = mountDescription;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.mountDescription = new Vector.<MountClientData>();
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
         this.serializeAs_ExchangeMountsPaddockAddMessage(output);
      }
      
      public function serializeAs_ExchangeMountsPaddockAddMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.mountDescription.length);
         for(var _i1:uint = 0; _i1 < this.mountDescription.length; _i1++)
         {
            (this.mountDescription[_i1] as MountClientData).serializeAs_MountClientData(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeMountsPaddockAddMessage(input);
      }
      
      public function deserializeAs_ExchangeMountsPaddockAddMessage(input:ICustomDataInput) : void
      {
         var _item1:MountClientData = null;
         var _mountDescriptionLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _mountDescriptionLen; _i1++)
         {
            _item1 = new MountClientData();
            _item1.deserialize(input);
            this.mountDescription.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeMountsPaddockAddMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeMountsPaddockAddMessage(tree:FuncTree) : void
      {
         this._mountDescriptiontree = tree.addChild(this._mountDescriptiontreeFunc);
      }
      
      private function _mountDescriptiontreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._mountDescriptiontree.addChild(this._mountDescriptionFunc);
         }
      }
      
      private function _mountDescriptionFunc(input:ICustomDataInput) : void
      {
         var _item:MountClientData = new MountClientData();
         _item.deserialize(input);
         this.mountDescription.push(_item);
      }
   }
}
