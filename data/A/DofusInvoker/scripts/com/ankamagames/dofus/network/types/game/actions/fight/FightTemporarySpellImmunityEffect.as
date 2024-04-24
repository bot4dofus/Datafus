package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightTemporarySpellImmunityEffect extends AbstractFightDispellableEffect implements INetworkType
   {
      
      public static const protocolId:uint = 273;
       
      
      public var immuneSpellId:int = 0;
      
      public function FightTemporarySpellImmunityEffect()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 273;
      }
      
      public function initFightTemporarySpellImmunityEffect(uid:uint = 0, targetId:Number = 0, turnDuration:int = 0, dispelable:uint = 1, spellId:uint = 0, effectId:uint = 0, parentBoostUid:uint = 0, immuneSpellId:int = 0) : FightTemporarySpellImmunityEffect
      {
         super.initAbstractFightDispellableEffect(uid,targetId,turnDuration,dispelable,spellId,effectId,parentBoostUid);
         this.immuneSpellId = immuneSpellId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.immuneSpellId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightTemporarySpellImmunityEffect(output);
      }
      
      public function serializeAs_FightTemporarySpellImmunityEffect(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractFightDispellableEffect(output);
         output.writeInt(this.immuneSpellId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightTemporarySpellImmunityEffect(input);
      }
      
      public function deserializeAs_FightTemporarySpellImmunityEffect(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._immuneSpellIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightTemporarySpellImmunityEffect(tree);
      }
      
      public function deserializeAsyncAs_FightTemporarySpellImmunityEffect(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._immuneSpellIdFunc);
      }
      
      private function _immuneSpellIdFunc(input:ICustomDataInput) : void
      {
         this.immuneSpellId = input.readInt();
      }
   }
}
