package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameRolePlayMutantInformations extends GameRolePlayHumanoidInformations implements INetworkType
   {
      
      public static const protocolId:uint = 3898;
       
      
      public var monsterId:uint = 0;
      
      public var powerLevel:int = 0;
      
      public function GameRolePlayMutantInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3898;
      }
      
      public function initGameRolePlayMutantInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null, name:String = "", humanoidInfo:HumanInformations = null, accountId:uint = 0, monsterId:uint = 0, powerLevel:int = 0) : GameRolePlayMutantInformations
      {
         super.initGameRolePlayHumanoidInformations(contextualId,disposition,look,name,humanoidInfo,accountId);
         this.monsterId = monsterId;
         this.powerLevel = powerLevel;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.monsterId = 0;
         this.powerLevel = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayMutantInformations(output);
      }
      
      public function serializeAs_GameRolePlayMutantInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameRolePlayHumanoidInformations(output);
         if(this.monsterId < 0)
         {
            throw new Error("Forbidden value (" + this.monsterId + ") on element monsterId.");
         }
         output.writeVarShort(this.monsterId);
         output.writeByte(this.powerLevel);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayMutantInformations(input);
      }
      
      public function deserializeAs_GameRolePlayMutantInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._monsterIdFunc(input);
         this._powerLevelFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayMutantInformations(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayMutantInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._monsterIdFunc);
         tree.addChild(this._powerLevelFunc);
      }
      
      private function _monsterIdFunc(input:ICustomDataInput) : void
      {
         this.monsterId = input.readVarUhShort();
         if(this.monsterId < 0)
         {
            throw new Error("Forbidden value (" + this.monsterId + ") on element of GameRolePlayMutantInformations.monsterId.");
         }
      }
      
      private function _powerLevelFunc(input:ICustomDataInput) : void
      {
         this.powerLevel = input.readByte();
      }
   }
}
