package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightPhase implements INetworkType
   {
      
      public static const protocolId:uint = 9523;
       
      
      public var phase:uint = 0;
      
      public var phaseEndTimeStamp:Number = 0;
      
      public function FightPhase()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 9523;
      }
      
      public function initFightPhase(phase:uint = 0, phaseEndTimeStamp:Number = 0) : FightPhase
      {
         this.phase = phase;
         this.phaseEndTimeStamp = phaseEndTimeStamp;
         return this;
      }
      
      public function reset() : void
      {
         this.phase = 0;
         this.phaseEndTimeStamp = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightPhase(output);
      }
      
      public function serializeAs_FightPhase(output:ICustomDataOutput) : void
      {
         output.writeByte(this.phase);
         if(this.phaseEndTimeStamp < -9007199254740992 || this.phaseEndTimeStamp > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.phaseEndTimeStamp + ") on element phaseEndTimeStamp.");
         }
         output.writeDouble(this.phaseEndTimeStamp);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightPhase(input);
      }
      
      public function deserializeAs_FightPhase(input:ICustomDataInput) : void
      {
         this._phaseFunc(input);
         this._phaseEndTimeStampFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightPhase(tree);
      }
      
      public function deserializeAsyncAs_FightPhase(tree:FuncTree) : void
      {
         tree.addChild(this._phaseFunc);
         tree.addChild(this._phaseEndTimeStampFunc);
      }
      
      private function _phaseFunc(input:ICustomDataInput) : void
      {
         this.phase = input.readByte();
         if(this.phase < 0)
         {
            throw new Error("Forbidden value (" + this.phase + ") on element of FightPhase.phase.");
         }
      }
      
      private function _phaseEndTimeStampFunc(input:ICustomDataInput) : void
      {
         this.phaseEndTimeStamp = input.readDouble();
         if(this.phaseEndTimeStamp < -9007199254740992 || this.phaseEndTimeStamp > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.phaseEndTimeStamp + ") on element of FightPhase.phaseEndTimeStamp.");
         }
      }
   }
}
