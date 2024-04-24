package com.ankamagames.dofus.network.types.game.character.alignment
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ActorExtendedAlignmentInformations extends ActorAlignmentInformations implements INetworkType
   {
      
      public static const protocolId:uint = 83;
       
      
      public var honor:uint = 0;
      
      public var honorGradeFloor:uint = 0;
      
      public var honorNextGradeFloor:uint = 0;
      
      public var aggressable:uint = 0;
      
      public function ActorExtendedAlignmentInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 83;
      }
      
      public function initActorExtendedAlignmentInformations(alignmentSide:int = 0, alignmentValue:uint = 0, alignmentGrade:uint = 0, characterPower:Number = 0, honor:uint = 0, honorGradeFloor:uint = 0, honorNextGradeFloor:uint = 0, aggressable:uint = 0) : ActorExtendedAlignmentInformations
      {
         super.initActorAlignmentInformations(alignmentSide,alignmentValue,alignmentGrade,characterPower);
         this.honor = honor;
         this.honorGradeFloor = honorGradeFloor;
         this.honorNextGradeFloor = honorNextGradeFloor;
         this.aggressable = aggressable;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.honor = 0;
         this.honorGradeFloor = 0;
         this.honorNextGradeFloor = 0;
         this.aggressable = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ActorExtendedAlignmentInformations(output);
      }
      
      public function serializeAs_ActorExtendedAlignmentInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_ActorAlignmentInformations(output);
         if(this.honor < 0 || this.honor > 20000)
         {
            throw new Error("Forbidden value (" + this.honor + ") on element honor.");
         }
         output.writeVarShort(this.honor);
         if(this.honorGradeFloor < 0 || this.honorGradeFloor > 20000)
         {
            throw new Error("Forbidden value (" + this.honorGradeFloor + ") on element honorGradeFloor.");
         }
         output.writeVarShort(this.honorGradeFloor);
         if(this.honorNextGradeFloor < 0 || this.honorNextGradeFloor > 20000)
         {
            throw new Error("Forbidden value (" + this.honorNextGradeFloor + ") on element honorNextGradeFloor.");
         }
         output.writeVarShort(this.honorNextGradeFloor);
         output.writeByte(this.aggressable);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ActorExtendedAlignmentInformations(input);
      }
      
      public function deserializeAs_ActorExtendedAlignmentInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._honorFunc(input);
         this._honorGradeFloorFunc(input);
         this._honorNextGradeFloorFunc(input);
         this._aggressableFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ActorExtendedAlignmentInformations(tree);
      }
      
      public function deserializeAsyncAs_ActorExtendedAlignmentInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._honorFunc);
         tree.addChild(this._honorGradeFloorFunc);
         tree.addChild(this._honorNextGradeFloorFunc);
         tree.addChild(this._aggressableFunc);
      }
      
      private function _honorFunc(input:ICustomDataInput) : void
      {
         this.honor = input.readVarUhShort();
         if(this.honor < 0 || this.honor > 20000)
         {
            throw new Error("Forbidden value (" + this.honor + ") on element of ActorExtendedAlignmentInformations.honor.");
         }
      }
      
      private function _honorGradeFloorFunc(input:ICustomDataInput) : void
      {
         this.honorGradeFloor = input.readVarUhShort();
         if(this.honorGradeFloor < 0 || this.honorGradeFloor > 20000)
         {
            throw new Error("Forbidden value (" + this.honorGradeFloor + ") on element of ActorExtendedAlignmentInformations.honorGradeFloor.");
         }
      }
      
      private function _honorNextGradeFloorFunc(input:ICustomDataInput) : void
      {
         this.honorNextGradeFloor = input.readVarUhShort();
         if(this.honorNextGradeFloor < 0 || this.honorNextGradeFloor > 20000)
         {
            throw new Error("Forbidden value (" + this.honorNextGradeFloor + ") on element of ActorExtendedAlignmentInformations.honorNextGradeFloor.");
         }
      }
      
      private function _aggressableFunc(input:ICustomDataInput) : void
      {
         this.aggressable = input.readByte();
         if(this.aggressable < 0)
         {
            throw new Error("Forbidden value (" + this.aggressable + ") on element of ActorExtendedAlignmentInformations.aggressable.");
         }
      }
   }
}
