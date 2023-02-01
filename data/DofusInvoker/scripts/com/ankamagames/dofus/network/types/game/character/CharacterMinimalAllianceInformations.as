package com.ankamagames.dofus.network.types.game.character
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicAllianceInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class CharacterMinimalAllianceInformations extends CharacterMinimalGuildInformations implements INetworkType
   {
      
      public static const protocolId:uint = 9153;
       
      
      public var alliance:BasicAllianceInformations;
      
      private var _alliancetree:FuncTree;
      
      public function CharacterMinimalAllianceInformations()
      {
         this.alliance = new BasicAllianceInformations();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 9153;
      }
      
      public function initCharacterMinimalAllianceInformations(id:Number = 0, name:String = "", level:uint = 0, entityLook:EntityLook = null, breed:int = 0, guild:BasicGuildInformations = null, alliance:BasicAllianceInformations = null) : CharacterMinimalAllianceInformations
      {
         super.initCharacterMinimalGuildInformations(id,name,level,entityLook,breed,guild);
         this.alliance = alliance;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.alliance = new BasicAllianceInformations();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterMinimalAllianceInformations(output);
      }
      
      public function serializeAs_CharacterMinimalAllianceInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterMinimalGuildInformations(output);
         this.alliance.serializeAs_BasicAllianceInformations(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterMinimalAllianceInformations(input);
      }
      
      public function deserializeAs_CharacterMinimalAllianceInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.alliance = new BasicAllianceInformations();
         this.alliance.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterMinimalAllianceInformations(tree);
      }
      
      public function deserializeAsyncAs_CharacterMinimalAllianceInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._alliancetree = tree.addChild(this._alliancetreeFunc);
      }
      
      private function _alliancetreeFunc(input:ICustomDataInput) : void
      {
         this.alliance = new BasicAllianceInformations();
         this.alliance.deserializeAsync(this._alliancetree);
      }
   }
}
