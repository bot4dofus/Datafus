package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorFightersInformation;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TaxCollectorListMessage extends AbstractTaxCollectorListMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5925;
       
      
      private var _isInitialized:Boolean = false;
      
      public var nbcollectorMax:uint = 0;
      
      public var fightersInformations:Vector.<TaxCollectorFightersInformation>;
      
      public var infoType:uint = 0;
      
      private var _fightersInformationstree:FuncTree;
      
      public function TaxCollectorListMessage()
      {
         this.fightersInformations = new Vector.<TaxCollectorFightersInformation>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5925;
      }
      
      public function initTaxCollectorListMessage(informations:Vector.<TaxCollectorInformations> = null, nbcollectorMax:uint = 0, fightersInformations:Vector.<TaxCollectorFightersInformation> = null, infoType:uint = 0) : TaxCollectorListMessage
      {
         super.initAbstractTaxCollectorListMessage(informations);
         this.nbcollectorMax = nbcollectorMax;
         this.fightersInformations = fightersInformations;
         this.infoType = infoType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.nbcollectorMax = 0;
         this.fightersInformations = new Vector.<TaxCollectorFightersInformation>();
         this.infoType = 0;
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
         this.serializeAs_TaxCollectorListMessage(output);
      }
      
      public function serializeAs_TaxCollectorListMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractTaxCollectorListMessage(output);
         if(this.nbcollectorMax < 0)
         {
            throw new Error("Forbidden value (" + this.nbcollectorMax + ") on element nbcollectorMax.");
         }
         output.writeByte(this.nbcollectorMax);
         output.writeShort(this.fightersInformations.length);
         for(var _i2:uint = 0; _i2 < this.fightersInformations.length; _i2++)
         {
            (this.fightersInformations[_i2] as TaxCollectorFightersInformation).serializeAs_TaxCollectorFightersInformation(output);
         }
         output.writeByte(this.infoType);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorListMessage(input);
      }
      
      public function deserializeAs_TaxCollectorListMessage(input:ICustomDataInput) : void
      {
         var _item2:TaxCollectorFightersInformation = null;
         super.deserialize(input);
         this._nbcollectorMaxFunc(input);
         var _fightersInformationsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _fightersInformationsLen; _i2++)
         {
            _item2 = new TaxCollectorFightersInformation();
            _item2.deserialize(input);
            this.fightersInformations.push(_item2);
         }
         this._infoTypeFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorListMessage(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorListMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._nbcollectorMaxFunc);
         this._fightersInformationstree = tree.addChild(this._fightersInformationstreeFunc);
         tree.addChild(this._infoTypeFunc);
      }
      
      private function _nbcollectorMaxFunc(input:ICustomDataInput) : void
      {
         this.nbcollectorMax = input.readByte();
         if(this.nbcollectorMax < 0)
         {
            throw new Error("Forbidden value (" + this.nbcollectorMax + ") on element of TaxCollectorListMessage.nbcollectorMax.");
         }
      }
      
      private function _fightersInformationstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._fightersInformationstree.addChild(this._fightersInformationsFunc);
         }
      }
      
      private function _fightersInformationsFunc(input:ICustomDataInput) : void
      {
         var _item:TaxCollectorFightersInformation = new TaxCollectorFightersInformation();
         _item.deserialize(input);
         this.fightersInformations.push(_item);
      }
      
      private function _infoTypeFunc(input:ICustomDataInput) : void
      {
         this.infoType = input.readByte();
         if(this.infoType < 0)
         {
            throw new Error("Forbidden value (" + this.infoType + ") on element of TaxCollectorListMessage.infoType.");
         }
      }
   }
}
