package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameRolePlayNpcInformations extends GameRolePlayActorInformations implements INetworkType
   {
      
      public static const protocolId:uint = 8347;
       
      
      public var npcId:uint = 0;
      
      public var sex:Boolean = false;
      
      public var specialArtworkId:uint = 0;
      
      public function GameRolePlayNpcInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8347;
      }
      
      public function initGameRolePlayNpcInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null, npcId:uint = 0, sex:Boolean = false, specialArtworkId:uint = 0) : GameRolePlayNpcInformations
      {
         super.initGameRolePlayActorInformations(contextualId,disposition,look);
         this.npcId = npcId;
         this.sex = sex;
         this.specialArtworkId = specialArtworkId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.npcId = 0;
         this.sex = false;
         this.specialArtworkId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayNpcInformations(output);
      }
      
      public function serializeAs_GameRolePlayNpcInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameRolePlayActorInformations(output);
         if(this.npcId < 0)
         {
            throw new Error("Forbidden value (" + this.npcId + ") on element npcId.");
         }
         output.writeVarShort(this.npcId);
         output.writeBoolean(this.sex);
         if(this.specialArtworkId < 0)
         {
            throw new Error("Forbidden value (" + this.specialArtworkId + ") on element specialArtworkId.");
         }
         output.writeVarShort(this.specialArtworkId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayNpcInformations(input);
      }
      
      public function deserializeAs_GameRolePlayNpcInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._npcIdFunc(input);
         this._sexFunc(input);
         this._specialArtworkIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayNpcInformations(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayNpcInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._npcIdFunc);
         tree.addChild(this._sexFunc);
         tree.addChild(this._specialArtworkIdFunc);
      }
      
      private function _npcIdFunc(input:ICustomDataInput) : void
      {
         this.npcId = input.readVarUhShort();
         if(this.npcId < 0)
         {
            throw new Error("Forbidden value (" + this.npcId + ") on element of GameRolePlayNpcInformations.npcId.");
         }
      }
      
      private function _sexFunc(input:ICustomDataInput) : void
      {
         this.sex = input.readBoolean();
      }
      
      private function _specialArtworkIdFunc(input:ICustomDataInput) : void
      {
         this.specialArtworkId = input.readVarUhShort();
         if(this.specialArtworkId < 0)
         {
            throw new Error("Forbidden value (" + this.specialArtworkId + ") on element of GameRolePlayNpcInformations.specialArtworkId.");
         }
      }
   }
}
