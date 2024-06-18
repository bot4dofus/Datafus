package com.ankamagames.dofus.network.types.game.data.items.effects
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ObjectEffectCreature extends ObjectEffect implements INetworkType
   {
      
      public static const protocolId:uint = 3987;
       
      
      public var monsterFamilyId:uint = 0;
      
      public function ObjectEffectCreature()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3987;
      }
      
      public function initObjectEffectCreature(actionId:uint = 0, monsterFamilyId:uint = 0) : ObjectEffectCreature
      {
         super.initObjectEffect(actionId);
         this.monsterFamilyId = monsterFamilyId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.monsterFamilyId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectEffectCreature(output);
      }
      
      public function serializeAs_ObjectEffectCreature(output:ICustomDataOutput) : void
      {
         super.serializeAs_ObjectEffect(output);
         if(this.monsterFamilyId < 0)
         {
            throw new Error("Forbidden value (" + this.monsterFamilyId + ") on element monsterFamilyId.");
         }
         output.writeVarShort(this.monsterFamilyId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectEffectCreature(input);
      }
      
      public function deserializeAs_ObjectEffectCreature(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._monsterFamilyIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectEffectCreature(tree);
      }
      
      public function deserializeAsyncAs_ObjectEffectCreature(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._monsterFamilyIdFunc);
      }
      
      private function _monsterFamilyIdFunc(input:ICustomDataInput) : void
      {
         this.monsterFamilyId = input.readVarUhShort();
         if(this.monsterFamilyId < 0)
         {
            throw new Error("Forbidden value (" + this.monsterFamilyId + ") on element of ObjectEffectCreature.monsterFamilyId.");
         }
      }
   }
}
