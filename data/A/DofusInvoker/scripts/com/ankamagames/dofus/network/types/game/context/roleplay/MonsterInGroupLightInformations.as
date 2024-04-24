package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class MonsterInGroupLightInformations implements INetworkType
   {
      
      public static const protocolId:uint = 1902;
       
      
      public var genericId:int = 0;
      
      public var grade:uint = 0;
      
      public var level:uint = 0;
      
      public function MonsterInGroupLightInformations()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 1902;
      }
      
      public function initMonsterInGroupLightInformations(genericId:int = 0, grade:uint = 0, level:uint = 0) : MonsterInGroupLightInformations
      {
         this.genericId = genericId;
         this.grade = grade;
         this.level = level;
         return this;
      }
      
      public function reset() : void
      {
         this.genericId = 0;
         this.grade = 0;
         this.level = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_MonsterInGroupLightInformations(output);
      }
      
      public function serializeAs_MonsterInGroupLightInformations(output:ICustomDataOutput) : void
      {
         output.writeInt(this.genericId);
         if(this.grade < 0)
         {
            throw new Error("Forbidden value (" + this.grade + ") on element grade.");
         }
         output.writeByte(this.grade);
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeShort(this.level);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MonsterInGroupLightInformations(input);
      }
      
      public function deserializeAs_MonsterInGroupLightInformations(input:ICustomDataInput) : void
      {
         this._genericIdFunc(input);
         this._gradeFunc(input);
         this._levelFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MonsterInGroupLightInformations(tree);
      }
      
      public function deserializeAsyncAs_MonsterInGroupLightInformations(tree:FuncTree) : void
      {
         tree.addChild(this._genericIdFunc);
         tree.addChild(this._gradeFunc);
         tree.addChild(this._levelFunc);
      }
      
      private function _genericIdFunc(input:ICustomDataInput) : void
      {
         this.genericId = input.readInt();
      }
      
      private function _gradeFunc(input:ICustomDataInput) : void
      {
         this.grade = input.readByte();
         if(this.grade < 0)
         {
            throw new Error("Forbidden value (" + this.grade + ") on element of MonsterInGroupLightInformations.grade.");
         }
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readShort();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of MonsterInGroupLightInformations.level.");
         }
      }
   }
}
