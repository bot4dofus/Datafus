package com.ankamagames.dofus.network.types.game.character
{
   import com.ankamagames.dofus.network.types.game.guild.GuildRankPublicInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class CharacterMinimalGuildPublicInformations extends CharacterMinimalInformations implements INetworkType
   {
      
      public static const protocolId:uint = 9695;
       
      
      public var rank:GuildRankPublicInformation;
      
      private var _ranktree:FuncTree;
      
      public function CharacterMinimalGuildPublicInformations()
      {
         this.rank = new GuildRankPublicInformation();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 9695;
      }
      
      public function initCharacterMinimalGuildPublicInformations(id:Number = 0, name:String = "", level:uint = 0, rank:GuildRankPublicInformation = null) : CharacterMinimalGuildPublicInformations
      {
         super.initCharacterMinimalInformations(id,name,level);
         this.rank = rank;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.rank = new GuildRankPublicInformation();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterMinimalGuildPublicInformations(output);
      }
      
      public function serializeAs_CharacterMinimalGuildPublicInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterMinimalInformations(output);
         this.rank.serializeAs_GuildRankPublicInformation(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterMinimalGuildPublicInformations(input);
      }
      
      public function deserializeAs_CharacterMinimalGuildPublicInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.rank = new GuildRankPublicInformation();
         this.rank.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterMinimalGuildPublicInformations(tree);
      }
      
      public function deserializeAsyncAs_CharacterMinimalGuildPublicInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._ranktree = tree.addChild(this._ranktreeFunc);
      }
      
      private function _ranktreeFunc(input:ICustomDataInput) : void
      {
         this.rank = new GuildRankPublicInformation();
         this.rank.deserializeAsync(this._ranktree);
      }
   }
}
