package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameRolePlayTreasureHintInformations extends GameRolePlayActorInformations implements INetworkType
   {
      
      public static const protocolId:uint = 5267;
       
      
      public var npcId:uint = 0;
      
      public function GameRolePlayTreasureHintInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 5267;
      }
      
      public function initGameRolePlayTreasureHintInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null, npcId:uint = 0) : GameRolePlayTreasureHintInformations
      {
         super.initGameRolePlayActorInformations(contextualId,disposition,look);
         this.npcId = npcId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.npcId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayTreasureHintInformations(output);
      }
      
      public function serializeAs_GameRolePlayTreasureHintInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameRolePlayActorInformations(output);
         if(this.npcId < 0)
         {
            throw new Error("Forbidden value (" + this.npcId + ") on element npcId.");
         }
         output.writeVarShort(this.npcId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayTreasureHintInformations(input);
      }
      
      public function deserializeAs_GameRolePlayTreasureHintInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._npcIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayTreasureHintInformations(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayTreasureHintInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._npcIdFunc);
      }
      
      private function _npcIdFunc(input:ICustomDataInput) : void
      {
         this.npcId = input.readVarUhShort();
         if(this.npcId < 0)
         {
            throw new Error("Forbidden value (" + this.npcId + ") on element of GameRolePlayTreasureHintInformations.npcId.");
         }
      }
   }
}
