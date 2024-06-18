package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameRolePlayGroupMonsterInformations extends GameRolePlayActorInformations implements INetworkType
   {
      
      public static const protocolId:uint = 7360;
       
      
      public var staticInfos:GroupMonsterStaticInformations;
      
      public var lootShare:int = 0;
      
      public var alignmentSide:int = 0;
      
      public var hasHardcoreDrop:Boolean = false;
      
      private var _staticInfostree:FuncTree;
      
      public function GameRolePlayGroupMonsterInformations()
      {
         this.staticInfos = new GroupMonsterStaticInformations();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7360;
      }
      
      public function initGameRolePlayGroupMonsterInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null, staticInfos:GroupMonsterStaticInformations = null, lootShare:int = 0, alignmentSide:int = 0, hasHardcoreDrop:Boolean = false) : GameRolePlayGroupMonsterInformations
      {
         super.initGameRolePlayActorInformations(contextualId,disposition,look);
         this.staticInfos = staticInfos;
         this.lootShare = lootShare;
         this.alignmentSide = alignmentSide;
         this.hasHardcoreDrop = hasHardcoreDrop;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.staticInfos = new GroupMonsterStaticInformations();
         this.alignmentSide = 0;
         this.hasHardcoreDrop = false;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayGroupMonsterInformations(output);
      }
      
      public function serializeAs_GameRolePlayGroupMonsterInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameRolePlayActorInformations(output);
         output.writeShort(this.staticInfos.getTypeId());
         this.staticInfos.serialize(output);
         if(this.lootShare < -1 || this.lootShare > 8)
         {
            throw new Error("Forbidden value (" + this.lootShare + ") on element lootShare.");
         }
         output.writeByte(this.lootShare);
         output.writeByte(this.alignmentSide);
         output.writeBoolean(this.hasHardcoreDrop);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayGroupMonsterInformations(input);
      }
      
      public function deserializeAs_GameRolePlayGroupMonsterInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         var _id1:uint = input.readUnsignedShort();
         this.staticInfos = ProtocolTypeManager.getInstance(GroupMonsterStaticInformations,_id1);
         this.staticInfos.deserialize(input);
         this._lootShareFunc(input);
         this._alignmentSideFunc(input);
         this._hasHardcoreDropFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayGroupMonsterInformations(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayGroupMonsterInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._staticInfostree = tree.addChild(this._staticInfostreeFunc);
         tree.addChild(this._lootShareFunc);
         tree.addChild(this._alignmentSideFunc);
         tree.addChild(this._hasHardcoreDropFunc);
      }
      
      private function _staticInfostreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.staticInfos = ProtocolTypeManager.getInstance(GroupMonsterStaticInformations,_id);
         this.staticInfos.deserializeAsync(this._staticInfostree);
      }
      
      private function _lootShareFunc(input:ICustomDataInput) : void
      {
         this.lootShare = input.readByte();
         if(this.lootShare < -1 || this.lootShare > 8)
         {
            throw new Error("Forbidden value (" + this.lootShare + ") on element of GameRolePlayGroupMonsterInformations.lootShare.");
         }
      }
      
      private function _alignmentSideFunc(input:ICustomDataInput) : void
      {
         this.alignmentSide = input.readByte();
      }
      
      private function _hasHardcoreDropFunc(input:ICustomDataInput) : void
      {
         this.hasHardcoreDrop = input.readBoolean();
      }
   }
}
