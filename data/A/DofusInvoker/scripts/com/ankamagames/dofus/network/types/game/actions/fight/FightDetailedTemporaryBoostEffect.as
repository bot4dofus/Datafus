package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightDetailedTemporaryBoostEffect extends FightTemporaryBoostEffect implements INetworkType
   {
      
      public static const protocolId:uint = 1155;
       
      
      public var param1:int = 0;
      
      public var param2:int = 0;
      
      public var param3:int = 0;
      
      public function FightDetailedTemporaryBoostEffect()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 1155;
      }
      
      public function initFightDetailedTemporaryBoostEffect(uid:uint = 0, targetId:Number = 0, turnDuration:int = 0, dispelable:uint = 1, spellId:uint = 0, effectId:uint = 0, parentBoostUid:uint = 0, delta:int = 0, param1:int = 0, param2:int = 0, param3:int = 0) : FightDetailedTemporaryBoostEffect
      {
         super.initFightTemporaryBoostEffect(uid,targetId,turnDuration,dispelable,spellId,effectId,parentBoostUid,delta);
         this.param1 = param1;
         this.param2 = param2;
         this.param3 = param3;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.param1 = 0;
         this.param2 = 0;
         this.param3 = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightDetailedTemporaryBoostEffect(output);
      }
      
      public function serializeAs_FightDetailedTemporaryBoostEffect(output:ICustomDataOutput) : void
      {
         super.serializeAs_FightTemporaryBoostEffect(output);
         output.writeInt(this.param1);
         output.writeInt(this.param2);
         output.writeInt(this.param3);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightDetailedTemporaryBoostEffect(input);
      }
      
      public function deserializeAs_FightDetailedTemporaryBoostEffect(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._param1Func(input);
         this._param2Func(input);
         this._param3Func(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightDetailedTemporaryBoostEffect(tree);
      }
      
      public function deserializeAsyncAs_FightDetailedTemporaryBoostEffect(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._param1Func);
         tree.addChild(this._param2Func);
         tree.addChild(this._param3Func);
      }
      
      private function _param1Func(input:ICustomDataInput) : void
      {
         this.param1 = input.readInt();
      }
      
      private function _param2Func(input:ICustomDataInput) : void
      {
         this.param2 = input.readInt();
      }
      
      private function _param3Func(input:ICustomDataInput) : void
      {
         this.param3 = input.readInt();
      }
   }
}
