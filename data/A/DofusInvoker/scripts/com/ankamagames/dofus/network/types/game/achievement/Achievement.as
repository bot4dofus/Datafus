package com.ankamagames.dofus.network.types.game.achievement
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class Achievement implements INetworkType
   {
      
      public static const protocolId:uint = 2764;
       
      
      public var id:uint = 0;
      
      public var finishedObjective:Vector.<AchievementObjective>;
      
      public var startedObjectives:Vector.<AchievementStartedObjective>;
      
      private var _finishedObjectivetree:FuncTree;
      
      private var _startedObjectivestree:FuncTree;
      
      public function Achievement()
      {
         this.finishedObjective = new Vector.<AchievementObjective>();
         this.startedObjectives = new Vector.<AchievementStartedObjective>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 2764;
      }
      
      public function initAchievement(id:uint = 0, finishedObjective:Vector.<AchievementObjective> = null, startedObjectives:Vector.<AchievementStartedObjective> = null) : Achievement
      {
         this.id = id;
         this.finishedObjective = finishedObjective;
         this.startedObjectives = startedObjectives;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.finishedObjective = new Vector.<AchievementObjective>();
         this.startedObjectives = new Vector.<AchievementStartedObjective>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_Achievement(output);
      }
      
      public function serializeAs_Achievement(output:ICustomDataOutput) : void
      {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeVarShort(this.id);
         output.writeShort(this.finishedObjective.length);
         for(var _i2:uint = 0; _i2 < this.finishedObjective.length; _i2++)
         {
            (this.finishedObjective[_i2] as AchievementObjective).serializeAs_AchievementObjective(output);
         }
         output.writeShort(this.startedObjectives.length);
         for(var _i3:uint = 0; _i3 < this.startedObjectives.length; _i3++)
         {
            (this.startedObjectives[_i3] as AchievementStartedObjective).serializeAs_AchievementStartedObjective(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_Achievement(input);
      }
      
      public function deserializeAs_Achievement(input:ICustomDataInput) : void
      {
         var _item2:AchievementObjective = null;
         var _item3:AchievementStartedObjective = null;
         this._idFunc(input);
         var _finishedObjectiveLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _finishedObjectiveLen; _i2++)
         {
            _item2 = new AchievementObjective();
            _item2.deserialize(input);
            this.finishedObjective.push(_item2);
         }
         var _startedObjectivesLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _startedObjectivesLen; _i3++)
         {
            _item3 = new AchievementStartedObjective();
            _item3.deserialize(input);
            this.startedObjectives.push(_item3);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_Achievement(tree);
      }
      
      public function deserializeAsyncAs_Achievement(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         this._finishedObjectivetree = tree.addChild(this._finishedObjectivetreeFunc);
         this._startedObjectivestree = tree.addChild(this._startedObjectivestreeFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhShort();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of Achievement.id.");
         }
      }
      
      private function _finishedObjectivetreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._finishedObjectivetree.addChild(this._finishedObjectiveFunc);
         }
      }
      
      private function _finishedObjectiveFunc(input:ICustomDataInput) : void
      {
         var _item:AchievementObjective = new AchievementObjective();
         _item.deserialize(input);
         this.finishedObjective.push(_item);
      }
      
      private function _startedObjectivestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._startedObjectivestree.addChild(this._startedObjectivesFunc);
         }
      }
      
      private function _startedObjectivesFunc(input:ICustomDataInput) : void
      {
         var _item:AchievementStartedObjective = new AchievementStartedObjective();
         _item.deserialize(input);
         this.startedObjectives.push(_item);
      }
   }
}
