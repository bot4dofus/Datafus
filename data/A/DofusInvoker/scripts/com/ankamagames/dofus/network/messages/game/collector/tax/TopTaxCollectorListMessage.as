package com.ankamagames.dofus.network.messages.game.collector.tax
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.collector.tax.TaxCollectorInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TopTaxCollectorListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6626;
       
      
      private var _isInitialized:Boolean = false;
      
      public var dungeonTaxCollectorsInformation:Vector.<TaxCollectorInformations>;
      
      public var worldTaxCollectorsInformation:Vector.<TaxCollectorInformations>;
      
      private var _dungeonTaxCollectorsInformationtree:FuncTree;
      
      private var _worldTaxCollectorsInformationtree:FuncTree;
      
      public function TopTaxCollectorListMessage()
      {
         this.dungeonTaxCollectorsInformation = new Vector.<TaxCollectorInformations>();
         this.worldTaxCollectorsInformation = new Vector.<TaxCollectorInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6626;
      }
      
      public function initTopTaxCollectorListMessage(dungeonTaxCollectorsInformation:Vector.<TaxCollectorInformations> = null, worldTaxCollectorsInformation:Vector.<TaxCollectorInformations> = null) : TopTaxCollectorListMessage
      {
         this.dungeonTaxCollectorsInformation = dungeonTaxCollectorsInformation;
         this.worldTaxCollectorsInformation = worldTaxCollectorsInformation;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.dungeonTaxCollectorsInformation = new Vector.<TaxCollectorInformations>();
         this.worldTaxCollectorsInformation = new Vector.<TaxCollectorInformations>();
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
         this.serializeAs_TopTaxCollectorListMessage(output);
      }
      
      public function serializeAs_TopTaxCollectorListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.dungeonTaxCollectorsInformation.length);
         for(var _i1:uint = 0; _i1 < this.dungeonTaxCollectorsInformation.length; _i1++)
         {
            output.writeShort((this.dungeonTaxCollectorsInformation[_i1] as TaxCollectorInformations).getTypeId());
            (this.dungeonTaxCollectorsInformation[_i1] as TaxCollectorInformations).serialize(output);
         }
         output.writeShort(this.worldTaxCollectorsInformation.length);
         for(var _i2:uint = 0; _i2 < this.worldTaxCollectorsInformation.length; _i2++)
         {
            output.writeShort((this.worldTaxCollectorsInformation[_i2] as TaxCollectorInformations).getTypeId());
            (this.worldTaxCollectorsInformation[_i2] as TaxCollectorInformations).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TopTaxCollectorListMessage(input);
      }
      
      public function deserializeAs_TopTaxCollectorListMessage(input:ICustomDataInput) : void
      {
         var _id1:uint = 0;
         var _item1:TaxCollectorInformations = null;
         var _id2:uint = 0;
         var _item2:TaxCollectorInformations = null;
         var _dungeonTaxCollectorsInformationLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _dungeonTaxCollectorsInformationLen; _i1++)
         {
            _id1 = input.readUnsignedShort();
            _item1 = ProtocolTypeManager.getInstance(TaxCollectorInformations,_id1);
            _item1.deserialize(input);
            this.dungeonTaxCollectorsInformation.push(_item1);
         }
         var _worldTaxCollectorsInformationLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _worldTaxCollectorsInformationLen; _i2++)
         {
            _id2 = input.readUnsignedShort();
            _item2 = ProtocolTypeManager.getInstance(TaxCollectorInformations,_id2);
            _item2.deserialize(input);
            this.worldTaxCollectorsInformation.push(_item2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TopTaxCollectorListMessage(tree);
      }
      
      public function deserializeAsyncAs_TopTaxCollectorListMessage(tree:FuncTree) : void
      {
         this._dungeonTaxCollectorsInformationtree = tree.addChild(this._dungeonTaxCollectorsInformationtreeFunc);
         this._worldTaxCollectorsInformationtree = tree.addChild(this._worldTaxCollectorsInformationtreeFunc);
      }
      
      private function _dungeonTaxCollectorsInformationtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._dungeonTaxCollectorsInformationtree.addChild(this._dungeonTaxCollectorsInformationFunc);
         }
      }
      
      private function _dungeonTaxCollectorsInformationFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:TaxCollectorInformations = ProtocolTypeManager.getInstance(TaxCollectorInformations,_id);
         _item.deserialize(input);
         this.dungeonTaxCollectorsInformation.push(_item);
      }
      
      private function _worldTaxCollectorsInformationtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._worldTaxCollectorsInformationtree.addChild(this._worldTaxCollectorsInformationFunc);
         }
      }
      
      private function _worldTaxCollectorsInformationFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:TaxCollectorInformations = ProtocolTypeManager.getInstance(TaxCollectorInformations,_id);
         _item.deserialize(input);
         this.worldTaxCollectorsInformation.push(_item);
      }
   }
}
