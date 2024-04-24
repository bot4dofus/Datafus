package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightResultPvpData extends FightResultAdditionalData implements INetworkType
   {
      
      public static const protocolId:uint = 192;
       
      
      public var grade:uint = 0;
      
      public var minHonorForGrade:uint = 0;
      
      public var maxHonorForGrade:uint = 0;
      
      public var honor:uint = 0;
      
      public var honorDelta:int = 0;
      
      public function FightResultPvpData()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 192;
      }
      
      public function initFightResultPvpData(grade:uint = 0, minHonorForGrade:uint = 0, maxHonorForGrade:uint = 0, honor:uint = 0, honorDelta:int = 0) : FightResultPvpData
      {
         this.grade = grade;
         this.minHonorForGrade = minHonorForGrade;
         this.maxHonorForGrade = maxHonorForGrade;
         this.honor = honor;
         this.honorDelta = honorDelta;
         return this;
      }
      
      override public function reset() : void
      {
         this.grade = 0;
         this.minHonorForGrade = 0;
         this.maxHonorForGrade = 0;
         this.honor = 0;
         this.honorDelta = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightResultPvpData(output);
      }
      
      public function serializeAs_FightResultPvpData(output:ICustomDataOutput) : void
      {
         super.serializeAs_FightResultAdditionalData(output);
         if(this.grade < 0 || this.grade > 255)
         {
            throw new Error("Forbidden value (" + this.grade + ") on element grade.");
         }
         output.writeByte(this.grade);
         if(this.minHonorForGrade < 0 || this.minHonorForGrade > 20000)
         {
            throw new Error("Forbidden value (" + this.minHonorForGrade + ") on element minHonorForGrade.");
         }
         output.writeVarShort(this.minHonorForGrade);
         if(this.maxHonorForGrade < 0 || this.maxHonorForGrade > 20000)
         {
            throw new Error("Forbidden value (" + this.maxHonorForGrade + ") on element maxHonorForGrade.");
         }
         output.writeVarShort(this.maxHonorForGrade);
         if(this.honor < 0 || this.honor > 20000)
         {
            throw new Error("Forbidden value (" + this.honor + ") on element honor.");
         }
         output.writeVarShort(this.honor);
         output.writeVarShort(this.honorDelta);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightResultPvpData(input);
      }
      
      public function deserializeAs_FightResultPvpData(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._gradeFunc(input);
         this._minHonorForGradeFunc(input);
         this._maxHonorForGradeFunc(input);
         this._honorFunc(input);
         this._honorDeltaFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightResultPvpData(tree);
      }
      
      public function deserializeAsyncAs_FightResultPvpData(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._gradeFunc);
         tree.addChild(this._minHonorForGradeFunc);
         tree.addChild(this._maxHonorForGradeFunc);
         tree.addChild(this._honorFunc);
         tree.addChild(this._honorDeltaFunc);
      }
      
      private function _gradeFunc(input:ICustomDataInput) : void
      {
         this.grade = input.readUnsignedByte();
         if(this.grade < 0 || this.grade > 255)
         {
            throw new Error("Forbidden value (" + this.grade + ") on element of FightResultPvpData.grade.");
         }
      }
      
      private function _minHonorForGradeFunc(input:ICustomDataInput) : void
      {
         this.minHonorForGrade = input.readVarUhShort();
         if(this.minHonorForGrade < 0 || this.minHonorForGrade > 20000)
         {
            throw new Error("Forbidden value (" + this.minHonorForGrade + ") on element of FightResultPvpData.minHonorForGrade.");
         }
      }
      
      private function _maxHonorForGradeFunc(input:ICustomDataInput) : void
      {
         this.maxHonorForGrade = input.readVarUhShort();
         if(this.maxHonorForGrade < 0 || this.maxHonorForGrade > 20000)
         {
            throw new Error("Forbidden value (" + this.maxHonorForGrade + ") on element of FightResultPvpData.maxHonorForGrade.");
         }
      }
      
      private function _honorFunc(input:ICustomDataInput) : void
      {
         this.honor = input.readVarUhShort();
         if(this.honor < 0 || this.honor > 20000)
         {
            throw new Error("Forbidden value (" + this.honor + ") on element of FightResultPvpData.honor.");
         }
      }
      
      private function _honorDeltaFunc(input:ICustomDataInput) : void
      {
         this.honorDelta = input.readVarShort();
      }
   }
}
