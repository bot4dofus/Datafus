package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightTemporaryBoostStateEffect extends FightTemporaryBoostEffect implements INetworkType
   {
      
      public static const protocolId:uint = 4574;
       
      
      public var stateId:int = 0;
      
      public function FightTemporaryBoostStateEffect()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 4574;
      }
      
      public function initFightTemporaryBoostStateEffect(uid:uint = 0, targetId:Number = 0, turnDuration:int = 0, dispelable:uint = 1, spellId:uint = 0, effectId:uint = 0, parentBoostUid:uint = 0, delta:int = 0, stateId:int = 0) : FightTemporaryBoostStateEffect
      {
         super.initFightTemporaryBoostEffect(uid,targetId,turnDuration,dispelable,spellId,effectId,parentBoostUid,delta);
         this.stateId = stateId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.stateId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightTemporaryBoostStateEffect(output);
      }
      
      public function serializeAs_FightTemporaryBoostStateEffect(output:ICustomDataOutput) : void
      {
         super.serializeAs_FightTemporaryBoostEffect(output);
         output.writeShort(this.stateId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightTemporaryBoostStateEffect(input);
      }
      
      public function deserializeAs_FightTemporaryBoostStateEffect(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._stateIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightTemporaryBoostStateEffect(tree);
      }
      
      public function deserializeAsyncAs_FightTemporaryBoostStateEffect(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._stateIdFunc);
      }
      
      private function _stateIdFunc(input:ICustomDataInput) : void
      {
         this.stateId = input.readShort();
      }
   }
}
