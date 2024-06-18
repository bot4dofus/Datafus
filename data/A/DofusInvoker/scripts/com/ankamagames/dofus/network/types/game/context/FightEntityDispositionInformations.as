package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightEntityDispositionInformations extends EntityDispositionInformations implements INetworkType
   {
      
      public static const protocolId:uint = 3736;
       
      
      public var carryingCharacterId:Number = 0;
      
      public function FightEntityDispositionInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3736;
      }
      
      public function initFightEntityDispositionInformations(cellId:int = 0, direction:uint = 1, carryingCharacterId:Number = 0) : FightEntityDispositionInformations
      {
         super.initEntityDispositionInformations(cellId,direction);
         this.carryingCharacterId = carryingCharacterId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.carryingCharacterId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightEntityDispositionInformations(output);
      }
      
      public function serializeAs_FightEntityDispositionInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_EntityDispositionInformations(output);
         if(this.carryingCharacterId < -9007199254740992 || this.carryingCharacterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.carryingCharacterId + ") on element carryingCharacterId.");
         }
         output.writeDouble(this.carryingCharacterId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightEntityDispositionInformations(input);
      }
      
      public function deserializeAs_FightEntityDispositionInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._carryingCharacterIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightEntityDispositionInformations(tree);
      }
      
      public function deserializeAsyncAs_FightEntityDispositionInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._carryingCharacterIdFunc);
      }
      
      private function _carryingCharacterIdFunc(input:ICustomDataInput) : void
      {
         this.carryingCharacterId = input.readDouble();
         if(this.carryingCharacterId < -9007199254740992 || this.carryingCharacterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.carryingCharacterId + ") on element of FightEntityDispositionInformations.carryingCharacterId.");
         }
      }
   }
}
