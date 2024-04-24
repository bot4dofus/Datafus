package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.social.SocialEmblem;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AllianceInformation extends BasicNamedAllianceInformations implements INetworkType
   {
      
      public static const protocolId:uint = 9229;
       
      
      public var allianceEmblem:SocialEmblem;
      
      private var _allianceEmblemtree:FuncTree;
      
      public function AllianceInformation()
      {
         this.allianceEmblem = new SocialEmblem();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 9229;
      }
      
      public function initAllianceInformation(allianceId:uint = 0, allianceTag:String = "", allianceName:String = "", allianceEmblem:SocialEmblem = null) : AllianceInformation
      {
         super.initBasicNamedAllianceInformations(allianceId,allianceTag,allianceName);
         this.allianceEmblem = allianceEmblem;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.allianceEmblem = new SocialEmblem();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AllianceInformation(output);
      }
      
      public function serializeAs_AllianceInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_BasicNamedAllianceInformations(output);
         this.allianceEmblem.serializeAs_SocialEmblem(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceInformation(input);
      }
      
      public function deserializeAs_AllianceInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.allianceEmblem = new SocialEmblem();
         this.allianceEmblem.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceInformation(tree);
      }
      
      public function deserializeAsyncAs_AllianceInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._allianceEmblemtree = tree.addChild(this._allianceEmblemtreeFunc);
      }
      
      private function _allianceEmblemtreeFunc(input:ICustomDataInput) : void
      {
         this.allianceEmblem = new SocialEmblem();
         this.allianceEmblem.deserializeAsync(this._allianceEmblemtree);
      }
   }
}
