package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildInfosUpgradeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1356;
       
      
      private var _isInitialized:Boolean = false;
      
      public var maxTaxCollectorsCount:uint = 0;
      
      public var taxCollectorsCount:uint = 0;
      
      public var taxCollectorLifePoints:uint = 0;
      
      public var taxCollectorDamagesBonuses:uint = 0;
      
      public var taxCollectorPods:uint = 0;
      
      public var taxCollectorProspecting:uint = 0;
      
      public var taxCollectorWisdom:uint = 0;
      
      public var boostPoints:uint = 0;
      
      public var spellId:Vector.<uint>;
      
      public var spellLevel:Vector.<int>;
      
      private var _spellIdtree:FuncTree;
      
      private var _spellLeveltree:FuncTree;
      
      public function GuildInfosUpgradeMessage()
      {
         this.spellId = new Vector.<uint>();
         this.spellLevel = new Vector.<int>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1356;
      }
      
      public function initGuildInfosUpgradeMessage(maxTaxCollectorsCount:uint = 0, taxCollectorsCount:uint = 0, taxCollectorLifePoints:uint = 0, taxCollectorDamagesBonuses:uint = 0, taxCollectorPods:uint = 0, taxCollectorProspecting:uint = 0, taxCollectorWisdom:uint = 0, boostPoints:uint = 0, spellId:Vector.<uint> = null, spellLevel:Vector.<int> = null) : GuildInfosUpgradeMessage
      {
         this.maxTaxCollectorsCount = maxTaxCollectorsCount;
         this.taxCollectorsCount = taxCollectorsCount;
         this.taxCollectorLifePoints = taxCollectorLifePoints;
         this.taxCollectorDamagesBonuses = taxCollectorDamagesBonuses;
         this.taxCollectorPods = taxCollectorPods;
         this.taxCollectorProspecting = taxCollectorProspecting;
         this.taxCollectorWisdom = taxCollectorWisdom;
         this.boostPoints = boostPoints;
         this.spellId = spellId;
         this.spellLevel = spellLevel;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.maxTaxCollectorsCount = 0;
         this.taxCollectorsCount = 0;
         this.taxCollectorLifePoints = 0;
         this.taxCollectorDamagesBonuses = 0;
         this.taxCollectorPods = 0;
         this.taxCollectorProspecting = 0;
         this.taxCollectorWisdom = 0;
         this.boostPoints = 0;
         this.spellId = new Vector.<uint>();
         this.spellLevel = new Vector.<int>();
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
         this.serializeAs_GuildInfosUpgradeMessage(output);
      }
      
      public function serializeAs_GuildInfosUpgradeMessage(output:ICustomDataOutput) : void
      {
         if(this.maxTaxCollectorsCount < 0)
         {
            throw new Error("Forbidden value (" + this.maxTaxCollectorsCount + ") on element maxTaxCollectorsCount.");
         }
         output.writeByte(this.maxTaxCollectorsCount);
         if(this.taxCollectorsCount < 0)
         {
            throw new Error("Forbidden value (" + this.taxCollectorsCount + ") on element taxCollectorsCount.");
         }
         output.writeByte(this.taxCollectorsCount);
         if(this.taxCollectorLifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.taxCollectorLifePoints + ") on element taxCollectorLifePoints.");
         }
         output.writeVarShort(this.taxCollectorLifePoints);
         if(this.taxCollectorDamagesBonuses < 0)
         {
            throw new Error("Forbidden value (" + this.taxCollectorDamagesBonuses + ") on element taxCollectorDamagesBonuses.");
         }
         output.writeVarShort(this.taxCollectorDamagesBonuses);
         if(this.taxCollectorPods < 0)
         {
            throw new Error("Forbidden value (" + this.taxCollectorPods + ") on element taxCollectorPods.");
         }
         output.writeVarShort(this.taxCollectorPods);
         if(this.taxCollectorProspecting < 0)
         {
            throw new Error("Forbidden value (" + this.taxCollectorProspecting + ") on element taxCollectorProspecting.");
         }
         output.writeVarShort(this.taxCollectorProspecting);
         if(this.taxCollectorWisdom < 0)
         {
            throw new Error("Forbidden value (" + this.taxCollectorWisdom + ") on element taxCollectorWisdom.");
         }
         output.writeVarShort(this.taxCollectorWisdom);
         if(this.boostPoints < 0)
         {
            throw new Error("Forbidden value (" + this.boostPoints + ") on element boostPoints.");
         }
         output.writeVarShort(this.boostPoints);
         output.writeShort(this.spellId.length);
         for(var _i9:uint = 0; _i9 < this.spellId.length; _i9++)
         {
            if(this.spellId[_i9] < 0)
            {
               throw new Error("Forbidden value (" + this.spellId[_i9] + ") on element 9 (starting at 1) of spellId.");
            }
            output.writeVarShort(this.spellId[_i9]);
         }
         output.writeShort(this.spellLevel.length);
         for(var _i10:uint = 0; _i10 < this.spellLevel.length; _i10++)
         {
            output.writeShort(this.spellLevel[_i10]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildInfosUpgradeMessage(input);
      }
      
      public function deserializeAs_GuildInfosUpgradeMessage(input:ICustomDataInput) : void
      {
         var _val9:uint = 0;
         var _val10:int = 0;
         this._maxTaxCollectorsCountFunc(input);
         this._taxCollectorsCountFunc(input);
         this._taxCollectorLifePointsFunc(input);
         this._taxCollectorDamagesBonusesFunc(input);
         this._taxCollectorPodsFunc(input);
         this._taxCollectorProspectingFunc(input);
         this._taxCollectorWisdomFunc(input);
         this._boostPointsFunc(input);
         var _spellIdLen:uint = input.readUnsignedShort();
         for(var _i9:uint = 0; _i9 < _spellIdLen; _i9++)
         {
            _val9 = input.readVarUhShort();
            if(_val9 < 0)
            {
               throw new Error("Forbidden value (" + _val9 + ") on elements of spellId.");
            }
            this.spellId.push(_val9);
         }
         var _spellLevelLen:uint = input.readUnsignedShort();
         for(var _i10:uint = 0; _i10 < _spellLevelLen; _i10++)
         {
            _val10 = input.readShort();
            this.spellLevel.push(_val10);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildInfosUpgradeMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildInfosUpgradeMessage(tree:FuncTree) : void
      {
         tree.addChild(this._maxTaxCollectorsCountFunc);
         tree.addChild(this._taxCollectorsCountFunc);
         tree.addChild(this._taxCollectorLifePointsFunc);
         tree.addChild(this._taxCollectorDamagesBonusesFunc);
         tree.addChild(this._taxCollectorPodsFunc);
         tree.addChild(this._taxCollectorProspectingFunc);
         tree.addChild(this._taxCollectorWisdomFunc);
         tree.addChild(this._boostPointsFunc);
         this._spellIdtree = tree.addChild(this._spellIdtreeFunc);
         this._spellLeveltree = tree.addChild(this._spellLeveltreeFunc);
      }
      
      private function _maxTaxCollectorsCountFunc(input:ICustomDataInput) : void
      {
         this.maxTaxCollectorsCount = input.readByte();
         if(this.maxTaxCollectorsCount < 0)
         {
            throw new Error("Forbidden value (" + this.maxTaxCollectorsCount + ") on element of GuildInfosUpgradeMessage.maxTaxCollectorsCount.");
         }
      }
      
      private function _taxCollectorsCountFunc(input:ICustomDataInput) : void
      {
         this.taxCollectorsCount = input.readByte();
         if(this.taxCollectorsCount < 0)
         {
            throw new Error("Forbidden value (" + this.taxCollectorsCount + ") on element of GuildInfosUpgradeMessage.taxCollectorsCount.");
         }
      }
      
      private function _taxCollectorLifePointsFunc(input:ICustomDataInput) : void
      {
         this.taxCollectorLifePoints = input.readVarUhShort();
         if(this.taxCollectorLifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.taxCollectorLifePoints + ") on element of GuildInfosUpgradeMessage.taxCollectorLifePoints.");
         }
      }
      
      private function _taxCollectorDamagesBonusesFunc(input:ICustomDataInput) : void
      {
         this.taxCollectorDamagesBonuses = input.readVarUhShort();
         if(this.taxCollectorDamagesBonuses < 0)
         {
            throw new Error("Forbidden value (" + this.taxCollectorDamagesBonuses + ") on element of GuildInfosUpgradeMessage.taxCollectorDamagesBonuses.");
         }
      }
      
      private function _taxCollectorPodsFunc(input:ICustomDataInput) : void
      {
         this.taxCollectorPods = input.readVarUhShort();
         if(this.taxCollectorPods < 0)
         {
            throw new Error("Forbidden value (" + this.taxCollectorPods + ") on element of GuildInfosUpgradeMessage.taxCollectorPods.");
         }
      }
      
      private function _taxCollectorProspectingFunc(input:ICustomDataInput) : void
      {
         this.taxCollectorProspecting = input.readVarUhShort();
         if(this.taxCollectorProspecting < 0)
         {
            throw new Error("Forbidden value (" + this.taxCollectorProspecting + ") on element of GuildInfosUpgradeMessage.taxCollectorProspecting.");
         }
      }
      
      private function _taxCollectorWisdomFunc(input:ICustomDataInput) : void
      {
         this.taxCollectorWisdom = input.readVarUhShort();
         if(this.taxCollectorWisdom < 0)
         {
            throw new Error("Forbidden value (" + this.taxCollectorWisdom + ") on element of GuildInfosUpgradeMessage.taxCollectorWisdom.");
         }
      }
      
      private function _boostPointsFunc(input:ICustomDataInput) : void
      {
         this.boostPoints = input.readVarUhShort();
         if(this.boostPoints < 0)
         {
            throw new Error("Forbidden value (" + this.boostPoints + ") on element of GuildInfosUpgradeMessage.boostPoints.");
         }
      }
      
      private function _spellIdtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._spellIdtree.addChild(this._spellIdFunc);
         }
      }
      
      private function _spellIdFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of spellId.");
         }
         this.spellId.push(_val);
      }
      
      private function _spellLeveltreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._spellLeveltree.addChild(this._spellLevelFunc);
         }
      }
      
      private function _spellLevelFunc(input:ICustomDataInput) : void
      {
         var _val:int = input.readShort();
         this.spellLevel.push(_val);
      }
   }
}
