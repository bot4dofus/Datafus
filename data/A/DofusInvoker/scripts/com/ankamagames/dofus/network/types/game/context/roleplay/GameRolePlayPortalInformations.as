package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.PortalInformation;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameRolePlayPortalInformations extends GameRolePlayActorInformations implements INetworkType
   {
      
      public static const protocolId:uint = 9999;
       
      
      public var portal:PortalInformation;
      
      private var _portaltree:FuncTree;
      
      public function GameRolePlayPortalInformations()
      {
         this.portal = new PortalInformation();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 9999;
      }
      
      public function initGameRolePlayPortalInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null, portal:PortalInformation = null) : GameRolePlayPortalInformations
      {
         super.initGameRolePlayActorInformations(contextualId,disposition,look);
         this.portal = portal;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.portal = new PortalInformation();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayPortalInformations(output);
      }
      
      public function serializeAs_GameRolePlayPortalInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameRolePlayActorInformations(output);
         output.writeShort(this.portal.getTypeId());
         this.portal.serialize(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayPortalInformations(input);
      }
      
      public function deserializeAs_GameRolePlayPortalInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         var _id1:uint = input.readUnsignedShort();
         this.portal = ProtocolTypeManager.getInstance(PortalInformation,_id1);
         this.portal.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayPortalInformations(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayPortalInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._portaltree = tree.addChild(this._portaltreeFunc);
      }
      
      private function _portaltreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.portal = ProtocolTypeManager.getInstance(PortalInformation,_id);
         this.portal.deserializeAsync(this._portaltree);
      }
   }
}
