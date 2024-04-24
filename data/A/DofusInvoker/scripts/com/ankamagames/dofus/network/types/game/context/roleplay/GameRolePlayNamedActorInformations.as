package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameRolePlayNamedActorInformations extends GameRolePlayActorInformations implements INetworkType
   {
      
      public static const protocolId:uint = 2435;
       
      
      public var name:String = "";
      
      public function GameRolePlayNamedActorInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 2435;
      }
      
      public function initGameRolePlayNamedActorInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null, name:String = "") : GameRolePlayNamedActorInformations
      {
         super.initGameRolePlayActorInformations(contextualId,disposition,look);
         this.name = name;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.name = "";
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayNamedActorInformations(output);
      }
      
      public function serializeAs_GameRolePlayNamedActorInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameRolePlayActorInformations(output);
         output.writeUTF(this.name);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayNamedActorInformations(input);
      }
      
      public function deserializeAs_GameRolePlayNamedActorInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._nameFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayNamedActorInformations(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayNamedActorInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._nameFunc);
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
   }
}
