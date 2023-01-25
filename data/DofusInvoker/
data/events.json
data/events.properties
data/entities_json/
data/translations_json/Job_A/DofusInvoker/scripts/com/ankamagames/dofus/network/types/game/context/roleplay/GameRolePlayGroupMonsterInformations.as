package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameRolePlayGroupMonsterInformations extends GameRolePlayActorInformations implements INetworkType
   {
      
      public static const protocolId:uint = 5208;
       
      
      public var staticInfos:GroupMonsterStaticInformations;
      
      public var lootShare:int = 0;
      
      public var alignmentSide:int = 0;
      
      public var keyRingBonus:Boolean = false;
      
      public var hasHardcoreDrop:Boolean = false;
      
      public var hasAVARewardToken:Boolean = false;
      
      private var _staticInfostree:FuncTree;
      
      public function GameRolePlayGroupMonsterInformations()
      {
         this.staticInfos = new GroupMonsterStaticInformations();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 5208;
      }
      
      public function initGameRolePlayGroupMonsterInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null, staticInfos:GroupMonsterStaticInformations = null, lootShare:int = 0, alignmentSide:int = 0, keyRingBonus:Boolean = false, hasHardcoreDrop:Boolean = false, hasAVARewardToken:Boolean = false) : GameRolePlayGroupMonsterInformations
      {
         super.initGameRolePlayActorInformations(contextualId,disposition,look);
         this.staticInfos = staticInfos;
         this.lootShare = lootShare;
         this.alignmentSide = alignmentSide;
         this.keyRingBonus = keyRingBonus;
         this.hasHardcoreDrop = hasHardcoreDrop;
         this.hasAVARewardToken = hasAVARewardToken;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.staticInfos = new GroupMonsterStaticInformations();
         this.alignmentSide = 0;
         this.keyRingBonus = false;
         this.hasHardcoreDrop = false;
         this.hasAVARewardToken = false;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayGroupMonsterInformations(output);
      }
      
      public function serializeAs_GameRolePlayGroupMonsterInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameRolePlayActorInformations(output);
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.keyRingBonus);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.hasHardcoreDrop);
         _box0 = BooleanByteWrapper.setFlag(_box0,2,this.hasAVARewardToken);
         output.writeByte(_box0);
         output.writeShort(this.staticInfos.getTypeId());
         this.staticInfos.serialize(output);
         if(this.lootShare < -1 || this.lootShare > 8)
         {
            throw new Error("Forbidden value (" + this.lootShare + ") on element lootShare.");
         }
         output.writeByte(this.lootShare);
         output.writeByte(this.alignmentSide);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayGroupMonsterInformations(input);
      }
      
      public function deserializeAs_GameRolePlayGroupMonsterInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.deserializeByteBoxes(input);
         var _id1:uint = input.readUnsignedShort();
         this.staticInfos = ProtocolTypeManager.getInstance(GroupMonsterStaticInformations,_id1);
         this.staticInfos.deserialize(input);
         this._lootShareFunc(input);
         this._alignmentSideFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayGroupMonsterInformations(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayGroupMonsterInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this.deserializeByteBoxes);
         this._staticInfostree = tree.addChild(this._staticInfostreeFunc);
         tree.addChild(this._lootShareFunc);
         tree.addChild(this._alignmentSideFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.keyRingBonus = BooleanByteWrapper.getFlag(_box0,0);
         this.hasHardcoreDrop = BooleanByteWrapper.getFlag(_box0,1);
         this.hasAVARewardToken = BooleanByteWrapper.getFlag(_box0,2);
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
   }
}
