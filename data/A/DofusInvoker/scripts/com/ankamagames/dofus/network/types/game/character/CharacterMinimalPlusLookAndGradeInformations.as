package com.ankamagames.dofus.network.types.game.character
{
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class CharacterMinimalPlusLookAndGradeInformations extends CharacterMinimalPlusLookInformations implements INetworkType
   {
      
      public static const protocolId:uint = 9686;
       
      
      public var grade:uint = 0;
      
      public function CharacterMinimalPlusLookAndGradeInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 9686;
      }
      
      public function initCharacterMinimalPlusLookAndGradeInformations(id:Number = 0, name:String = "", level:uint = 0, entityLook:EntityLook = null, breed:int = 0, grade:uint = 0) : CharacterMinimalPlusLookAndGradeInformations
      {
         super.initCharacterMinimalPlusLookInformations(id,name,level,entityLook,breed);
         this.grade = grade;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.grade = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterMinimalPlusLookAndGradeInformations(output);
      }
      
      public function serializeAs_CharacterMinimalPlusLookAndGradeInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterMinimalPlusLookInformations(output);
         if(this.grade < 0)
         {
            throw new Error("Forbidden value (" + this.grade + ") on element grade.");
         }
         output.writeVarInt(this.grade);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterMinimalPlusLookAndGradeInformations(input);
      }
      
      public function deserializeAs_CharacterMinimalPlusLookAndGradeInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._gradeFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterMinimalPlusLookAndGradeInformations(tree);
      }
      
      public function deserializeAsyncAs_CharacterMinimalPlusLookAndGradeInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._gradeFunc);
      }
      
      private function _gradeFunc(input:ICustomDataInput) : void
      {
         this.grade = input.readVarUhInt();
         if(this.grade < 0)
         {
            throw new Error("Forbidden value (" + this.grade + ") on element of CharacterMinimalPlusLookAndGradeInformations.grade.");
         }
      }
   }
}
