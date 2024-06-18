package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.character.alignment.ActorAlignmentInformations;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameRolePlayCharacterInformations extends GameRolePlayHumanoidInformations implements INetworkType
   {
      
      public static const protocolId:uint = 9304;
       
      
      public var alignmentInfos:ActorAlignmentInformations;
      
      private var _alignmentInfostree:FuncTree;
      
      public function GameRolePlayCharacterInformations()
      {
         this.alignmentInfos = new ActorAlignmentInformations();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 9304;
      }
      
      public function initGameRolePlayCharacterInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null, name:String = "", humanoidInfo:HumanInformations = null, accountId:uint = 0, alignmentInfos:ActorAlignmentInformations = null) : GameRolePlayCharacterInformations
      {
         super.initGameRolePlayHumanoidInformations(contextualId,disposition,look,name,humanoidInfo,accountId);
         this.alignmentInfos = alignmentInfos;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.alignmentInfos = new ActorAlignmentInformations();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayCharacterInformations(output);
      }
      
      public function serializeAs_GameRolePlayCharacterInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameRolePlayHumanoidInformations(output);
         this.alignmentInfos.serializeAs_ActorAlignmentInformations(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayCharacterInformations(input);
      }
      
      public function deserializeAs_GameRolePlayCharacterInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.alignmentInfos = new ActorAlignmentInformations();
         this.alignmentInfos.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayCharacterInformations(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayCharacterInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._alignmentInfostree = tree.addChild(this._alignmentInfostreeFunc);
      }
      
      private function _alignmentInfostreeFunc(input:ICustomDataInput) : void
      {
         this.alignmentInfos = new ActorAlignmentInformations();
         this.alignmentInfos.deserializeAsync(this._alignmentInfostree);
      }
   }
}
