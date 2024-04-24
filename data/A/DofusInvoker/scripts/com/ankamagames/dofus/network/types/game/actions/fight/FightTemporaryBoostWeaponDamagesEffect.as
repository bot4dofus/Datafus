package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightTemporaryBoostWeaponDamagesEffect extends FightTemporaryBoostEffect implements INetworkType
   {
      
      public static const protocolId:uint = 8504;
       
      
      public var weaponTypeId:int = 0;
      
      public function FightTemporaryBoostWeaponDamagesEffect()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8504;
      }
      
      public function initFightTemporaryBoostWeaponDamagesEffect(uid:uint = 0, targetId:Number = 0, turnDuration:int = 0, dispelable:uint = 1, spellId:uint = 0, effectId:uint = 0, parentBoostUid:uint = 0, delta:int = 0, weaponTypeId:int = 0) : FightTemporaryBoostWeaponDamagesEffect
      {
         super.initFightTemporaryBoostEffect(uid,targetId,turnDuration,dispelable,spellId,effectId,parentBoostUid,delta);
         this.weaponTypeId = weaponTypeId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.weaponTypeId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightTemporaryBoostWeaponDamagesEffect(output);
      }
      
      public function serializeAs_FightTemporaryBoostWeaponDamagesEffect(output:ICustomDataOutput) : void
      {
         super.serializeAs_FightTemporaryBoostEffect(output);
         output.writeShort(this.weaponTypeId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightTemporaryBoostWeaponDamagesEffect(input);
      }
      
      public function deserializeAs_FightTemporaryBoostWeaponDamagesEffect(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._weaponTypeIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightTemporaryBoostWeaponDamagesEffect(tree);
      }
      
      public function deserializeAsyncAs_FightTemporaryBoostWeaponDamagesEffect(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._weaponTypeIdFunc);
      }
      
      private function _weaponTypeIdFunc(input:ICustomDataInput) : void
      {
         this.weaponTypeId = input.readShort();
      }
   }
}
