package com.ankamagames.dofus.network.types.game.interactive.skill
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SkillActionDescriptionCollect extends SkillActionDescriptionTimed implements INetworkType
   {
      
      public static const protocolId:uint = 4561;
       
      
      public var min:uint = 0;
      
      public var max:uint = 0;
      
      public function SkillActionDescriptionCollect()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 4561;
      }
      
      public function initSkillActionDescriptionCollect(skillId:uint = 0, time:uint = 0, min:uint = 0, max:uint = 0) : SkillActionDescriptionCollect
      {
         super.initSkillActionDescriptionTimed(skillId,time);
         this.min = min;
         this.max = max;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.min = 0;
         this.max = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SkillActionDescriptionCollect(output);
      }
      
      public function serializeAs_SkillActionDescriptionCollect(output:ICustomDataOutput) : void
      {
         super.serializeAs_SkillActionDescriptionTimed(output);
         if(this.min < 0)
         {
            throw new Error("Forbidden value (" + this.min + ") on element min.");
         }
         output.writeVarShort(this.min);
         if(this.max < 0)
         {
            throw new Error("Forbidden value (" + this.max + ") on element max.");
         }
         output.writeVarShort(this.max);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SkillActionDescriptionCollect(input);
      }
      
      public function deserializeAs_SkillActionDescriptionCollect(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._minFunc(input);
         this._maxFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SkillActionDescriptionCollect(tree);
      }
      
      public function deserializeAsyncAs_SkillActionDescriptionCollect(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._minFunc);
         tree.addChild(this._maxFunc);
      }
      
      private function _minFunc(input:ICustomDataInput) : void
      {
         this.min = input.readVarUhShort();
         if(this.min < 0)
         {
            throw new Error("Forbidden value (" + this.min + ") on element of SkillActionDescriptionCollect.min.");
         }
      }
      
      private function _maxFunc(input:ICustomDataInput) : void
      {
         this.max = input.readVarUhShort();
         if(this.max < 0)
         {
            throw new Error("Forbidden value (" + this.max + ") on element of SkillActionDescriptionCollect.max.");
         }
      }
   }
}
