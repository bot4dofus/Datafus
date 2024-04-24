package com.ankamagames.dofus.network.types.game.character.alignment
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ActorAlignmentInformations implements INetworkType
   {
      
      public static const protocolId:uint = 7770;
       
      
      public var alignmentSide:int = 0;
      
      public var alignmentValue:uint = 0;
      
      public var alignmentGrade:uint = 0;
      
      public var characterPower:Number = 0;
      
      public function ActorAlignmentInformations()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 7770;
      }
      
      public function initActorAlignmentInformations(alignmentSide:int = 0, alignmentValue:uint = 0, alignmentGrade:uint = 0, characterPower:Number = 0) : ActorAlignmentInformations
      {
         this.alignmentSide = alignmentSide;
         this.alignmentValue = alignmentValue;
         this.alignmentGrade = alignmentGrade;
         this.characterPower = characterPower;
         return this;
      }
      
      public function reset() : void
      {
         this.alignmentSide = 0;
         this.alignmentValue = 0;
         this.alignmentGrade = 0;
         this.characterPower = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ActorAlignmentInformations(output);
      }
      
      public function serializeAs_ActorAlignmentInformations(output:ICustomDataOutput) : void
      {
         output.writeByte(this.alignmentSide);
         if(this.alignmentValue < 0)
         {
            throw new Error("Forbidden value (" + this.alignmentValue + ") on element alignmentValue.");
         }
         output.writeByte(this.alignmentValue);
         if(this.alignmentGrade < 0)
         {
            throw new Error("Forbidden value (" + this.alignmentGrade + ") on element alignmentGrade.");
         }
         output.writeByte(this.alignmentGrade);
         if(this.characterPower < -9007199254740992 || this.characterPower > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.characterPower + ") on element characterPower.");
         }
         output.writeDouble(this.characterPower);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ActorAlignmentInformations(input);
      }
      
      public function deserializeAs_ActorAlignmentInformations(input:ICustomDataInput) : void
      {
         this._alignmentSideFunc(input);
         this._alignmentValueFunc(input);
         this._alignmentGradeFunc(input);
         this._characterPowerFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ActorAlignmentInformations(tree);
      }
      
      public function deserializeAsyncAs_ActorAlignmentInformations(tree:FuncTree) : void
      {
         tree.addChild(this._alignmentSideFunc);
         tree.addChild(this._alignmentValueFunc);
         tree.addChild(this._alignmentGradeFunc);
         tree.addChild(this._characterPowerFunc);
      }
      
      private function _alignmentSideFunc(input:ICustomDataInput) : void
      {
         this.alignmentSide = input.readByte();
      }
      
      private function _alignmentValueFunc(input:ICustomDataInput) : void
      {
         this.alignmentValue = input.readByte();
         if(this.alignmentValue < 0)
         {
            throw new Error("Forbidden value (" + this.alignmentValue + ") on element of ActorAlignmentInformations.alignmentValue.");
         }
      }
      
      private function _alignmentGradeFunc(input:ICustomDataInput) : void
      {
         this.alignmentGrade = input.readByte();
         if(this.alignmentGrade < 0)
         {
            throw new Error("Forbidden value (" + this.alignmentGrade + ") on element of ActorAlignmentInformations.alignmentGrade.");
         }
      }
      
      private function _characterPowerFunc(input:ICustomDataInput) : void
      {
         this.characterPower = input.readDouble();
         if(this.characterPower < -9007199254740992 || this.characterPower > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.characterPower + ") on element of ActorAlignmentInformations.characterPower.");
         }
      }
   }
}
