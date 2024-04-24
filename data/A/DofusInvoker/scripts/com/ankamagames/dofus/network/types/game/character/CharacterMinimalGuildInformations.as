package com.ankamagames.dofus.network.types.game.character
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class CharacterMinimalGuildInformations extends CharacterMinimalPlusLookInformations implements INetworkType
   {
      
      public static const protocolId:uint = 16;
       
      
      public var guild:BasicGuildInformations;
      
      private var _guildtree:FuncTree;
      
      public function CharacterMinimalGuildInformations()
      {
         this.guild = new BasicGuildInformations();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 16;
      }
      
      public function initCharacterMinimalGuildInformations(id:Number = 0, name:String = "", level:uint = 0, entityLook:EntityLook = null, breed:int = 0, guild:BasicGuildInformations = null) : CharacterMinimalGuildInformations
      {
         super.initCharacterMinimalPlusLookInformations(id,name,level,entityLook,breed);
         this.guild = guild;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.guild = new BasicGuildInformations();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterMinimalGuildInformations(output);
      }
      
      public function serializeAs_CharacterMinimalGuildInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterMinimalPlusLookInformations(output);
         this.guild.serializeAs_BasicGuildInformations(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterMinimalGuildInformations(input);
      }
      
      public function deserializeAs_CharacterMinimalGuildInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.guild = new BasicGuildInformations();
         this.guild.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterMinimalGuildInformations(tree);
      }
      
      public function deserializeAsyncAs_CharacterMinimalGuildInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._guildtree = tree.addChild(this._guildtreeFunc);
      }
      
      private function _guildtreeFunc(input:ICustomDataInput) : void
      {
         this.guild = new BasicGuildInformations();
         this.guild.deserializeAsync(this._guildtree);
      }
   }
}
