package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AbstractTaxCollectorListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5610;
       
      
      private var _isInitialized:Boolean = false;
      
      public var informations:Vector.<TaxCollectorInformations>;
      
      private var _informationstree:FuncTree;
      
      public function AbstractTaxCollectorListMessage()
      {
         this.informations = new Vector.<TaxCollectorInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5610;
      }
      
      public function initAbstractTaxCollectorListMessage(informations:Vector.<TaxCollectorInformations> = null) : AbstractTaxCollectorListMessage
      {
         this.informations = informations;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.informations = new Vector.<TaxCollectorInformations>();
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
         this.serializeAs_AbstractTaxCollectorListMessage(output);
      }
      
      public function serializeAs_AbstractTaxCollectorListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.informations.length);
         for(var _i1:uint = 0; _i1 < this.informations.length; _i1++)
         {
            output.writeShort((this.informations[_i1] as TaxCollectorInformations).getTypeId());
            (this.informations[_i1] as TaxCollectorInformations).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AbstractTaxCollectorListMessage(input);
      }
      
      public function deserializeAs_AbstractTaxCollectorListMessage(input:ICustomDataInput) : void
      {
         var _id1:uint = 0;
         var _item1:TaxCollectorInformations = null;
         var _informationsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _informationsLen; _i1++)
         {
            _id1 = input.readUnsignedShort();
            _item1 = ProtocolTypeManager.getInstance(TaxCollectorInformations,_id1);
            _item1.deserialize(input);
            this.informations.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AbstractTaxCollectorListMessage(tree);
      }
      
      public function deserializeAsyncAs_AbstractTaxCollectorListMessage(tree:FuncTree) : void
      {
         this._informationstree = tree.addChild(this._informationstreeFunc);
      }
      
      private function _informationstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._informationstree.addChild(this._informationsFunc);
         }
      }
      
      private function _informationsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:TaxCollectorInformations = ProtocolTypeManager.getInstance(TaxCollectorInformations,_id);
         _item.deserialize(input);
         this.informations.push(_item);
      }
   }
}
