package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.prism.PrismInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameRolePlayPrismInformations extends GameRolePlayActorInformations implements INetworkType
   {
      
      public static const protocolId:uint = 7369;
       
      
      public var prism:PrismInformation;
      
      private var _prismtree:FuncTree;
      
      public function GameRolePlayPrismInformations()
      {
         this.prism = new PrismInformation();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7369;
      }
      
      public function initGameRolePlayPrismInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null, prism:PrismInformation = null) : GameRolePlayPrismInformations
      {
         super.initGameRolePlayActorInformations(contextualId,disposition,look);
         this.prism = prism;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.prism = new PrismInformation();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayPrismInformations(output);
      }
      
      public function serializeAs_GameRolePlayPrismInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameRolePlayActorInformations(output);
         output.writeShort(this.prism.getTypeId());
         this.prism.serialize(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayPrismInformations(input);
      }
      
      public function deserializeAs_GameRolePlayPrismInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         var _id1:uint = input.readUnsignedShort();
         this.prism = ProtocolTypeManager.getInstance(PrismInformation,_id1);
         this.prism.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayPrismInformations(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayPrismInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._prismtree = tree.addChild(this._prismtreeFunc);
      }
      
      private function _prismtreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.prism = ProtocolTypeManager.getInstance(PrismInformation,_id);
         this.prism.deserializeAsync(this._prismtree);
      }
   }
}
