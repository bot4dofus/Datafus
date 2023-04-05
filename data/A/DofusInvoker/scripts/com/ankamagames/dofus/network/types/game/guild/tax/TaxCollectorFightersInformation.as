package com.ankamagames.dofus.network.types.game.guild.tax
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class TaxCollectorFightersInformation implements INetworkType
   {
      
      public static const protocolId:uint = 755;
       
      
      public var collectorId:Number = 0;
      
      public var allyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations>;
      
      public var enemyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations>;
      
      private var _allyCharactersInformationstree:FuncTree;
      
      private var _enemyCharactersInformationstree:FuncTree;
      
      public function TaxCollectorFightersInformation()
      {
         this.allyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>();
         this.enemyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 755;
      }
      
      public function initTaxCollectorFightersInformation(collectorId:Number = 0, allyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations> = null, enemyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations> = null) : TaxCollectorFightersInformation
      {
         this.collectorId = collectorId;
         this.allyCharactersInformations = allyCharactersInformations;
         this.enemyCharactersInformations = enemyCharactersInformations;
         return this;
      }
      
      public function reset() : void
      {
         this.collectorId = 0;
         this.allyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>();
         this.enemyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_TaxCollectorFightersInformation(output);
      }
      
      public function serializeAs_TaxCollectorFightersInformation(output:ICustomDataOutput) : void
      {
         if(this.collectorId < 0 || this.collectorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.collectorId + ") on element collectorId.");
         }
         output.writeDouble(this.collectorId);
         output.writeShort(this.allyCharactersInformations.length);
         for(var _i2:uint = 0; _i2 < this.allyCharactersInformations.length; _i2++)
         {
            output.writeShort((this.allyCharactersInformations[_i2] as CharacterMinimalPlusLookInformations).getTypeId());
            (this.allyCharactersInformations[_i2] as CharacterMinimalPlusLookInformations).serialize(output);
         }
         output.writeShort(this.enemyCharactersInformations.length);
         for(var _i3:uint = 0; _i3 < this.enemyCharactersInformations.length; _i3++)
         {
            output.writeShort((this.enemyCharactersInformations[_i3] as CharacterMinimalPlusLookInformations).getTypeId());
            (this.enemyCharactersInformations[_i3] as CharacterMinimalPlusLookInformations).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorFightersInformation(input);
      }
      
      public function deserializeAs_TaxCollectorFightersInformation(input:ICustomDataInput) : void
      {
         var _id2:uint = 0;
         var _item2:CharacterMinimalPlusLookInformations = null;
         var _id3:uint = 0;
         var _item3:CharacterMinimalPlusLookInformations = null;
         this._collectorIdFunc(input);
         var _allyCharactersInformationsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _allyCharactersInformationsLen; _i2++)
         {
            _id2 = input.readUnsignedShort();
            _item2 = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations,_id2);
            _item2.deserialize(input);
            this.allyCharactersInformations.push(_item2);
         }
         var _enemyCharactersInformationsLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _enemyCharactersInformationsLen; _i3++)
         {
            _id3 = input.readUnsignedShort();
            _item3 = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations,_id3);
            _item3.deserialize(input);
            this.enemyCharactersInformations.push(_item3);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorFightersInformation(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorFightersInformation(tree:FuncTree) : void
      {
         tree.addChild(this._collectorIdFunc);
         this._allyCharactersInformationstree = tree.addChild(this._allyCharactersInformationstreeFunc);
         this._enemyCharactersInformationstree = tree.addChild(this._enemyCharactersInformationstreeFunc);
      }
      
      private function _collectorIdFunc(input:ICustomDataInput) : void
      {
         this.collectorId = input.readDouble();
         if(this.collectorId < 0 || this.collectorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.collectorId + ") on element of TaxCollectorFightersInformation.collectorId.");
         }
      }
      
      private function _allyCharactersInformationstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._allyCharactersInformationstree.addChild(this._allyCharactersInformationsFunc);
         }
      }
      
      private function _allyCharactersInformationsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:CharacterMinimalPlusLookInformations = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations,_id);
         _item.deserialize(input);
         this.allyCharactersInformations.push(_item);
      }
      
      private function _enemyCharactersInformationstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._enemyCharactersInformationstree.addChild(this._enemyCharactersInformationsFunc);
         }
      }
      
      private function _enemyCharactersInformationsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:CharacterMinimalPlusLookInformations = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations,_id);
         _item.deserialize(input);
         this.enemyCharactersInformations.push(_item);
      }
   }
}
