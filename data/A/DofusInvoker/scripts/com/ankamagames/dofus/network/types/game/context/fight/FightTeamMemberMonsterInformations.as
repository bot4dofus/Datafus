package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightTeamMemberMonsterInformations extends FightTeamMemberInformations implements INetworkType
   {
      
      public static const protocolId:uint = 7397;
       
      
      public var monsterId:int = 0;
      
      public var grade:uint = 0;
      
      public function FightTeamMemberMonsterInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7397;
      }
      
      public function initFightTeamMemberMonsterInformations(id:Number = 0, monsterId:int = 0, grade:uint = 0) : FightTeamMemberMonsterInformations
      {
         super.initFightTeamMemberInformations(id);
         this.monsterId = monsterId;
         this.grade = grade;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.monsterId = 0;
         this.grade = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightTeamMemberMonsterInformations(output);
      }
      
      public function serializeAs_FightTeamMemberMonsterInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_FightTeamMemberInformations(output);
         output.writeInt(this.monsterId);
         if(this.grade < 0)
         {
            throw new Error("Forbidden value (" + this.grade + ") on element grade.");
         }
         output.writeByte(this.grade);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightTeamMemberMonsterInformations(input);
      }
      
      public function deserializeAs_FightTeamMemberMonsterInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._monsterIdFunc(input);
         this._gradeFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightTeamMemberMonsterInformations(tree);
      }
      
      public function deserializeAsyncAs_FightTeamMemberMonsterInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._monsterIdFunc);
         tree.addChild(this._gradeFunc);
      }
      
      private function _monsterIdFunc(input:ICustomDataInput) : void
      {
         this.monsterId = input.readInt();
      }
      
      private function _gradeFunc(input:ICustomDataInput) : void
      {
         this.grade = input.readByte();
         if(this.grade < 0)
         {
            throw new Error("Forbidden value (" + this.grade + ") on element of FightTeamMemberMonsterInformations.grade.");
         }
      }
   }
}
