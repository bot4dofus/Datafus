package com.ankamagames.dofus.network.types.game.interactive.skill
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SkillActionDescriptionCraft extends SkillActionDescription implements INetworkType
   {
      
      public static const protocolId:uint = 5905;
       
      
      public var probability:uint = 0;
      
      public function SkillActionDescriptionCraft()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 5905;
      }
      
      public function initSkillActionDescriptionCraft(skillId:uint = 0, probability:uint = 0) : SkillActionDescriptionCraft
      {
         super.initSkillActionDescription(skillId);
         this.probability = probability;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.probability = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SkillActionDescriptionCraft(output);
      }
      
      public function serializeAs_SkillActionDescriptionCraft(output:ICustomDataOutput) : void
      {
         super.serializeAs_SkillActionDescription(output);
         if(this.probability < 0)
         {
            throw new Error("Forbidden value (" + this.probability + ") on element probability.");
         }
         output.writeByte(this.probability);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SkillActionDescriptionCraft(input);
      }
      
      public function deserializeAs_SkillActionDescriptionCraft(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._probabilityFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SkillActionDescriptionCraft(tree);
      }
      
      public function deserializeAsyncAs_SkillActionDescriptionCraft(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._probabilityFunc);
      }
      
      private function _probabilityFunc(input:ICustomDataInput) : void
      {
         this.probability = input.readByte();
         if(this.probability < 0)
         {
            throw new Error("Forbidden value (" + this.probability + ") on element of SkillActionDescriptionCraft.probability.");
         }
      }
   }
}
