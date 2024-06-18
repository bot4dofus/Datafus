package com.ankamagames.dofus.network.types.game.interactive
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class InteractiveElementWithAgeBonus extends InteractiveElement implements INetworkType
   {
      
      public static const protocolId:uint = 2952;
       
      
      public var ageBonus:int = 0;
      
      public function InteractiveElementWithAgeBonus()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 2952;
      }
      
      public function initInteractiveElementWithAgeBonus(elementId:uint = 0, elementTypeId:int = 0, enabledSkills:Vector.<InteractiveElementSkill> = null, disabledSkills:Vector.<InteractiveElementSkill> = null, onCurrentMap:Boolean = false, ageBonus:int = 0) : InteractiveElementWithAgeBonus
      {
         super.initInteractiveElement(elementId,elementTypeId,enabledSkills,disabledSkills,onCurrentMap);
         this.ageBonus = ageBonus;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.ageBonus = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_InteractiveElementWithAgeBonus(output);
      }
      
      public function serializeAs_InteractiveElementWithAgeBonus(output:ICustomDataOutput) : void
      {
         super.serializeAs_InteractiveElement(output);
         if(this.ageBonus < -1 || this.ageBonus > 1000)
         {
            throw new Error("Forbidden value (" + this.ageBonus + ") on element ageBonus.");
         }
         output.writeShort(this.ageBonus);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_InteractiveElementWithAgeBonus(input);
      }
      
      public function deserializeAs_InteractiveElementWithAgeBonus(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._ageBonusFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_InteractiveElementWithAgeBonus(tree);
      }
      
      public function deserializeAsyncAs_InteractiveElementWithAgeBonus(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._ageBonusFunc);
      }
      
      private function _ageBonusFunc(input:ICustomDataInput) : void
      {
         this.ageBonus = input.readShort();
         if(this.ageBonus < -1 || this.ageBonus > 1000)
         {
            throw new Error("Forbidden value (" + this.ageBonus + ") on element of InteractiveElementWithAgeBonus.ageBonus.");
         }
      }
   }
}
