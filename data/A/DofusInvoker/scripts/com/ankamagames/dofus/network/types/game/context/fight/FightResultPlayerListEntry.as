package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightResultPlayerListEntry extends FightResultFighterListEntry implements INetworkType
   {
      
      public static const protocolId:uint = 6813;
       
      
      public var level:uint = 0;
      
      public var additional:Vector.<FightResultAdditionalData>;
      
      private var _additionaltree:FuncTree;
      
      public function FightResultPlayerListEntry()
      {
         this.additional = new Vector.<FightResultAdditionalData>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 6813;
      }
      
      public function initFightResultPlayerListEntry(outcome:uint = 0, wave:uint = 0, rewards:FightLoot = null, id:Number = 0, alive:Boolean = false, level:uint = 0, additional:Vector.<FightResultAdditionalData> = null) : FightResultPlayerListEntry
      {
         super.initFightResultFighterListEntry(outcome,wave,rewards,id,alive);
         this.level = level;
         this.additional = additional;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.level = 0;
         this.additional = new Vector.<FightResultAdditionalData>();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightResultPlayerListEntry(output);
      }
      
      public function serializeAs_FightResultPlayerListEntry(output:ICustomDataOutput) : void
      {
         super.serializeAs_FightResultFighterListEntry(output);
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeVarShort(this.level);
         output.writeShort(this.additional.length);
         for(var _i2:uint = 0; _i2 < this.additional.length; _i2++)
         {
            output.writeShort((this.additional[_i2] as FightResultAdditionalData).getTypeId());
            (this.additional[_i2] as FightResultAdditionalData).serialize(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightResultPlayerListEntry(input);
      }
      
      public function deserializeAs_FightResultPlayerListEntry(input:ICustomDataInput) : void
      {
         var _id2:uint = 0;
         var _item2:FightResultAdditionalData = null;
         super.deserialize(input);
         this._levelFunc(input);
         var _additionalLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _additionalLen; _i2++)
         {
            _id2 = input.readUnsignedShort();
            _item2 = ProtocolTypeManager.getInstance(FightResultAdditionalData,_id2);
            _item2.deserialize(input);
            this.additional.push(_item2);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightResultPlayerListEntry(tree);
      }
      
      public function deserializeAsyncAs_FightResultPlayerListEntry(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._levelFunc);
         this._additionaltree = tree.addChild(this._additionaltreeFunc);
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readVarUhShort();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of FightResultPlayerListEntry.level.");
         }
      }
      
      private function _additionaltreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._additionaltree.addChild(this._additionalFunc);
         }
      }
      
      private function _additionalFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:FightResultAdditionalData = ProtocolTypeManager.getInstance(FightResultAdditionalData,_id);
         _item.deserialize(input);
         this.additional.push(_item);
      }
   }
}
