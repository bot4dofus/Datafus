package com.ankamagames.dofus.network.types.game.interactive.skill
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SkillActionDescriptionTimed extends SkillActionDescription implements INetworkType
   {
      
      public static const protocolId:uint = 1078;
       
      
      public var time:uint = 0;
      
      public function SkillActionDescriptionTimed()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 1078;
      }
      
      public function initSkillActionDescriptionTimed(skillId:uint = 0, time:uint = 0) : SkillActionDescriptionTimed
      {
         super.initSkillActionDescription(skillId);
         this.time = time;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.time = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SkillActionDescriptionTimed(output);
      }
      
      public function serializeAs_SkillActionDescriptionTimed(output:ICustomDataOutput) : void
      {
         super.serializeAs_SkillActionDescription(output);
         if(this.time < 0 || this.time > 255)
         {
            throw new Error("Forbidden value (" + this.time + ") on element time.");
         }
         output.writeByte(this.time);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SkillActionDescriptionTimed(input);
      }
      
      public function deserializeAs_SkillActionDescriptionTimed(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._timeFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SkillActionDescriptionTimed(tree);
      }
      
      public function deserializeAsyncAs_SkillActionDescriptionTimed(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._timeFunc);
      }
      
      private function _timeFunc(input:ICustomDataInput) : void
      {
         this.time = input.readUnsignedByte();
         if(this.time < 0 || this.time > 255)
         {
            throw new Error("Forbidden value (" + this.time + ") on element of SkillActionDescriptionTimed.time.");
         }
      }
   }
}
