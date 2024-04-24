package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameRolePlayActorInformations extends GameContextActorInformations implements INetworkType
   {
      
      public static const protocolId:uint = 3676;
       
      
      public function GameRolePlayActorInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3676;
      }
      
      public function initGameRolePlayActorInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null) : GameRolePlayActorInformations
      {
         super.initGameContextActorInformations(contextualId,disposition,look);
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayActorInformations(output);
      }
      
      public function serializeAs_GameRolePlayActorInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameContextActorInformations(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayActorInformations(input);
      }
      
      public function deserializeAs_GameRolePlayActorInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayActorInformations(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayActorInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
