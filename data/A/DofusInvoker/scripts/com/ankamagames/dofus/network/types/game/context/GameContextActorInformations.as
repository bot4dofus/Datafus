package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameContextActorInformations extends GameContextActorPositionInformations implements INetworkType
   {
      
      public static const protocolId:uint = 9060;
       
      
      public var look:EntityLook;
      
      private var _looktree:FuncTree;
      
      public function GameContextActorInformations()
      {
         this.look = new EntityLook();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 9060;
      }
      
      public function initGameContextActorInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null) : GameContextActorInformations
      {
         super.initGameContextActorPositionInformations(contextualId,disposition);
         this.look = look;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.look = new EntityLook();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameContextActorInformations(output);
      }
      
      public function serializeAs_GameContextActorInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameContextActorPositionInformations(output);
         this.look.serializeAs_EntityLook(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameContextActorInformations(input);
      }
      
      public function deserializeAs_GameContextActorInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.look = new EntityLook();
         this.look.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameContextActorInformations(tree);
      }
      
      public function deserializeAsyncAs_GameContextActorInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._looktree = tree.addChild(this._looktreeFunc);
      }
      
      private function _looktreeFunc(input:ICustomDataInput) : void
      {
         this.look = new EntityLook();
         this.look.deserializeAsync(this._looktree);
      }
   }
}
