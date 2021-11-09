package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameRolePlayTaxCollectorInformations extends GameRolePlayActorInformations implements INetworkType
   {
      
      public static const protocolId:uint = 6468;
       
      
      public var identification:TaxCollectorStaticInformations;
      
      public var guildLevel:uint = 0;
      
      public var taxCollectorAttack:int = 0;
      
      private var _identificationtree:FuncTree;
      
      public function GameRolePlayTaxCollectorInformations()
      {
         this.identification = new TaxCollectorStaticInformations();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 6468;
      }
      
      public function initGameRolePlayTaxCollectorInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null, identification:TaxCollectorStaticInformations = null, guildLevel:uint = 0, taxCollectorAttack:int = 0) : GameRolePlayTaxCollectorInformations
      {
         super.initGameRolePlayActorInformations(contextualId,disposition,look);
         this.identification = identification;
         this.guildLevel = guildLevel;
         this.taxCollectorAttack = taxCollectorAttack;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.identification = new TaxCollectorStaticInformations();
         this.taxCollectorAttack = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayTaxCollectorInformations(output);
      }
      
      public function serializeAs_GameRolePlayTaxCollectorInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameRolePlayActorInformations(output);
         output.writeShort(this.identification.getTypeId());
         this.identification.serialize(output);
         if(this.guildLevel < 0 || this.guildLevel > 255)
         {
            throw new Error("Forbidden value (" + this.guildLevel + ") on element guildLevel.");
         }
         output.writeByte(this.guildLevel);
         output.writeInt(this.taxCollectorAttack);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayTaxCollectorInformations(input);
      }
      
      public function deserializeAs_GameRolePlayTaxCollectorInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         var _id1:uint = input.readUnsignedShort();
         this.identification = ProtocolTypeManager.getInstance(TaxCollectorStaticInformations,_id1);
         this.identification.deserialize(input);
         this._guildLevelFunc(input);
         this._taxCollectorAttackFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayTaxCollectorInformations(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayTaxCollectorInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._identificationtree = tree.addChild(this._identificationtreeFunc);
         tree.addChild(this._guildLevelFunc);
         tree.addChild(this._taxCollectorAttackFunc);
      }
      
      private function _identificationtreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.identification = ProtocolTypeManager.getInstance(TaxCollectorStaticInformations,_id);
         this.identification.deserializeAsync(this._identificationtree);
      }
      
      private function _guildLevelFunc(input:ICustomDataInput) : void
      {
         this.guildLevel = input.readUnsignedByte();
         if(this.guildLevel < 0 || this.guildLevel > 255)
         {
            throw new Error("Forbidden value (" + this.guildLevel + ") on element of GameRolePlayTaxCollectorInformations.guildLevel.");
         }
      }
      
      private function _taxCollectorAttackFunc(input:ICustomDataInput) : void
      {
         this.taxCollectorAttack = input.readInt();
      }
   }
}
