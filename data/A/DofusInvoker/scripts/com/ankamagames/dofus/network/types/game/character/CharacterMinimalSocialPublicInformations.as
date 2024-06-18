package com.ankamagames.dofus.network.types.game.character
{
   import com.ankamagames.dofus.network.types.game.guild.RankPublicInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class CharacterMinimalSocialPublicInformations extends CharacterMinimalInformations implements INetworkType
   {
      
      public static const protocolId:uint = 5126;
       
      
      public var rank:RankPublicInformation;
      
      private var _ranktree:FuncTree;
      
      public function CharacterMinimalSocialPublicInformations()
      {
         this.rank = new RankPublicInformation();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 5126;
      }
      
      public function initCharacterMinimalSocialPublicInformations(id:Number = 0, name:String = "", level:uint = 0, rank:RankPublicInformation = null) : CharacterMinimalSocialPublicInformations
      {
         super.initCharacterMinimalInformations(id,name,level);
         this.rank = rank;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.rank = new RankPublicInformation();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterMinimalSocialPublicInformations(output);
      }
      
      public function serializeAs_CharacterMinimalSocialPublicInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterMinimalInformations(output);
         this.rank.serializeAs_RankPublicInformation(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterMinimalSocialPublicInformations(input);
      }
      
      public function deserializeAs_CharacterMinimalSocialPublicInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.rank = new RankPublicInformation();
         this.rank.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterMinimalSocialPublicInformations(tree);
      }
      
      public function deserializeAsyncAs_CharacterMinimalSocialPublicInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._ranktree = tree.addChild(this._ranktreeFunc);
      }
      
      private function _ranktreeFunc(input:ICustomDataInput) : void
      {
         this.rank = new RankPublicInformation();
         this.rank.deserializeAsync(this._ranktree);
      }
   }
}
