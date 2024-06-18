package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightTemporaryBoostEffect extends AbstractFightDispellableEffect implements INetworkType
   {
      
      public static const protocolId:uint = 2521;
       
      
      public var delta:int = 0;
      
      public function FightTemporaryBoostEffect()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 2521;
      }
      
      public function initFightTemporaryBoostEffect(uid:uint = 0, targetId:Number = 0, turnDuration:int = 0, dispelable:uint = 1, spellId:uint = 0, effectId:uint = 0, parentBoostUid:uint = 0, delta:int = 0) : FightTemporaryBoostEffect
      {
         super.initAbstractFightDispellableEffect(uid,targetId,turnDuration,dispelable,spellId,effectId,parentBoostUid);
         this.delta = delta;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.delta = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightTemporaryBoostEffect(output);
      }
      
      public function serializeAs_FightTemporaryBoostEffect(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractFightDispellableEffect(output);
         output.writeInt(this.delta);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightTemporaryBoostEffect(input);
      }
      
      public function deserializeAs_FightTemporaryBoostEffect(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._deltaFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightTemporaryBoostEffect(tree);
      }
      
      public function deserializeAsyncAs_FightTemporaryBoostEffect(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._deltaFunc);
      }
      
      private function _deltaFunc(input:ICustomDataInput) : void
      {
         this.delta = input.readInt();
      }
   }
}
