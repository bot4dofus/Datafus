package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AllianceInformations extends BasicNamedAllianceInformations implements INetworkType
   {
      
      public static const protocolId:uint = 1445;
       
      
      public var allianceEmblem:GuildEmblem;
      
      private var _allianceEmblemtree:FuncTree;
      
      public function AllianceInformations()
      {
         this.allianceEmblem = new GuildEmblem();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 1445;
      }
      
      public function initAllianceInformations(allianceId:uint = 0, allianceTag:String = "", allianceName:String = "", allianceEmblem:GuildEmblem = null) : AllianceInformations
      {
         super.initBasicNamedAllianceInformations(allianceId,allianceTag,allianceName);
         this.allianceEmblem = allianceEmblem;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.allianceEmblem = new GuildEmblem();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AllianceInformations(output);
      }
      
      public function serializeAs_AllianceInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_BasicNamedAllianceInformations(output);
         this.allianceEmblem.serializeAs_GuildEmblem(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceInformations(input);
      }
      
      public function deserializeAs_AllianceInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.allianceEmblem = new GuildEmblem();
         this.allianceEmblem.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceInformations(tree);
      }
      
      public function deserializeAsyncAs_AllianceInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._allianceEmblemtree = tree.addChild(this._allianceEmblemtreeFunc);
      }
      
      private function _allianceEmblemtreeFunc(input:ICustomDataInput) : void
      {
         this.allianceEmblem = new GuildEmblem();
         this.allianceEmblem.deserializeAsync(this._allianceEmblemtree);
      }
   }
}
