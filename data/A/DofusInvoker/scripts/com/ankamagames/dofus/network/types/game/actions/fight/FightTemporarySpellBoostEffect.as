package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightTemporarySpellBoostEffect extends FightTemporaryBoostEffect implements INetworkType
   {
      
      public static const protocolId:uint = 5892;
       
      
      public var boostedSpellId:uint = 0;
      
      public function FightTemporarySpellBoostEffect()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 5892;
      }
      
      public function initFightTemporarySpellBoostEffect(uid:uint = 0, targetId:Number = 0, turnDuration:int = 0, dispelable:uint = 1, spellId:uint = 0, effectId:uint = 0, parentBoostUid:uint = 0, delta:int = 0, boostedSpellId:uint = 0) : FightTemporarySpellBoostEffect
      {
         super.initFightTemporaryBoostEffect(uid,targetId,turnDuration,dispelable,spellId,effectId,parentBoostUid,delta);
         this.boostedSpellId = boostedSpellId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.boostedSpellId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightTemporarySpellBoostEffect(output);
      }
      
      public function serializeAs_FightTemporarySpellBoostEffect(output:ICustomDataOutput) : void
      {
         super.serializeAs_FightTemporaryBoostEffect(output);
         if(this.boostedSpellId < 0)
         {
            throw new Error("Forbidden value (" + this.boostedSpellId + ") on element boostedSpellId.");
         }
         output.writeVarShort(this.boostedSpellId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightTemporarySpellBoostEffect(input);
      }
      
      public function deserializeAs_FightTemporarySpellBoostEffect(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._boostedSpellIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightTemporarySpellBoostEffect(tree);
      }
      
      public function deserializeAsyncAs_FightTemporarySpellBoostEffect(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._boostedSpellIdFunc);
      }
      
      private function _boostedSpellIdFunc(input:ICustomDataInput) : void
      {
         this.boostedSpellId = input.readVarUhShort();
         if(this.boostedSpellId < 0)
         {
            throw new Error("Forbidden value (" + this.boostedSpellId + ") on element of FightTemporarySpellBoostEffect.boostedSpellId.");
         }
      }
   }
}
