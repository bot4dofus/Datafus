package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class HumanOptionSkillUse extends HumanOption implements INetworkType
   {
      
      public static const protocolId:uint = 2036;
       
      
      public var elementId:uint = 0;
      
      public var skillId:uint = 0;
      
      public var skillEndTime:Number = 0;
      
      public function HumanOptionSkillUse()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 2036;
      }
      
      public function initHumanOptionSkillUse(elementId:uint = 0, skillId:uint = 0, skillEndTime:Number = 0) : HumanOptionSkillUse
      {
         this.elementId = elementId;
         this.skillId = skillId;
         this.skillEndTime = skillEndTime;
         return this;
      }
      
      override public function reset() : void
      {
         this.elementId = 0;
         this.skillId = 0;
         this.skillEndTime = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_HumanOptionSkillUse(output);
      }
      
      public function serializeAs_HumanOptionSkillUse(output:ICustomDataOutput) : void
      {
         super.serializeAs_HumanOption(output);
         if(this.elementId < 0)
         {
            throw new Error("Forbidden value (" + this.elementId + ") on element elementId.");
         }
         output.writeVarInt(this.elementId);
         if(this.skillId < 0)
         {
            throw new Error("Forbidden value (" + this.skillId + ") on element skillId.");
         }
         output.writeVarShort(this.skillId);
         if(this.skillEndTime < -9007199254740992 || this.skillEndTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.skillEndTime + ") on element skillEndTime.");
         }
         output.writeDouble(this.skillEndTime);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HumanOptionSkillUse(input);
      }
      
      public function deserializeAs_HumanOptionSkillUse(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._elementIdFunc(input);
         this._skillIdFunc(input);
         this._skillEndTimeFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HumanOptionSkillUse(tree);
      }
      
      public function deserializeAsyncAs_HumanOptionSkillUse(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._elementIdFunc);
         tree.addChild(this._skillIdFunc);
         tree.addChild(this._skillEndTimeFunc);
      }
      
      private function _elementIdFunc(input:ICustomDataInput) : void
      {
         this.elementId = input.readVarUhInt();
         if(this.elementId < 0)
         {
            throw new Error("Forbidden value (" + this.elementId + ") on element of HumanOptionSkillUse.elementId.");
         }
      }
      
      private function _skillIdFunc(input:ICustomDataInput) : void
      {
         this.skillId = input.readVarUhShort();
         if(this.skillId < 0)
         {
            throw new Error("Forbidden value (" + this.skillId + ") on element of HumanOptionSkillUse.skillId.");
         }
      }
      
      private function _skillEndTimeFunc(input:ICustomDataInput) : void
      {
         this.skillEndTime = input.readDouble();
         if(this.skillEndTime < -9007199254740992 || this.skillEndTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.skillEndTime + ") on element of HumanOptionSkillUse.skillEndTime.");
         }
      }
   }
}
