package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.social.AbstractSocialGroupInfos;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class BasicAllianceInformations extends AbstractSocialGroupInfos implements INetworkType
   {
      
      public static const protocolId:uint = 7430;
       
      
      public var allianceId:uint = 0;
      
      public var allianceTag:String = "";
      
      public function BasicAllianceInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7430;
      }
      
      public function initBasicAllianceInformations(allianceId:uint = 0, allianceTag:String = "") : BasicAllianceInformations
      {
         this.allianceId = allianceId;
         this.allianceTag = allianceTag;
         return this;
      }
      
      override public function reset() : void
      {
         this.allianceId = 0;
         this.allianceTag = "";
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_BasicAllianceInformations(output);
      }
      
      public function serializeAs_BasicAllianceInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractSocialGroupInfos(output);
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element allianceId.");
         }
         output.writeVarInt(this.allianceId);
         output.writeUTF(this.allianceTag);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BasicAllianceInformations(input);
      }
      
      public function deserializeAs_BasicAllianceInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._allianceIdFunc(input);
         this._allianceTagFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BasicAllianceInformations(tree);
      }
      
      public function deserializeAsyncAs_BasicAllianceInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._allianceIdFunc);
         tree.addChild(this._allianceTagFunc);
      }
      
      private function _allianceIdFunc(input:ICustomDataInput) : void
      {
         this.allianceId = input.readVarUhInt();
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element of BasicAllianceInformations.allianceId.");
         }
      }
      
      private function _allianceTagFunc(input:ICustomDataInput) : void
      {
         this.allianceTag = input.readUTF();
      }
   }
}
