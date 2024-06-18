package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.GameRolePlayNpcQuestFlag;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameRolePlayNpcWithQuestInformations extends GameRolePlayNpcInformations implements INetworkType
   {
      
      public static const protocolId:uint = 7588;
       
      
      public var questFlag:GameRolePlayNpcQuestFlag;
      
      private var _questFlagtree:FuncTree;
      
      public function GameRolePlayNpcWithQuestInformations()
      {
         this.questFlag = new GameRolePlayNpcQuestFlag();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7588;
      }
      
      public function initGameRolePlayNpcWithQuestInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null, npcId:uint = 0, sex:Boolean = false, specialArtworkId:uint = 0, questFlag:GameRolePlayNpcQuestFlag = null) : GameRolePlayNpcWithQuestInformations
      {
         super.initGameRolePlayNpcInformations(contextualId,disposition,look,npcId,sex,specialArtworkId);
         this.questFlag = questFlag;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.questFlag = new GameRolePlayNpcQuestFlag();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayNpcWithQuestInformations(output);
      }
      
      public function serializeAs_GameRolePlayNpcWithQuestInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameRolePlayNpcInformations(output);
         this.questFlag.serializeAs_GameRolePlayNpcQuestFlag(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayNpcWithQuestInformations(input);
      }
      
      public function deserializeAs_GameRolePlayNpcWithQuestInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.questFlag = new GameRolePlayNpcQuestFlag();
         this.questFlag.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayNpcWithQuestInformations(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayNpcWithQuestInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._questFlagtree = tree.addChild(this._questFlagtreeFunc);
      }
      
      private function _questFlagtreeFunc(input:ICustomDataInput) : void
      {
         this.questFlag = new GameRolePlayNpcQuestFlag();
         this.questFlag.deserializeAsync(this._questFlagtree);
      }
   }
}
