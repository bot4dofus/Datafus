package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class BasicNamedAllianceInformations extends BasicAllianceInformations implements INetworkType
   {
      
      public static const protocolId:uint = 5416;
       
      
      public var allianceName:String = "";
      
      public function BasicNamedAllianceInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 5416;
      }
      
      public function initBasicNamedAllianceInformations(allianceId:uint = 0, allianceTag:String = "", allianceName:String = "") : BasicNamedAllianceInformations
      {
         super.initBasicAllianceInformations(allianceId,allianceTag);
         this.allianceName = allianceName;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.allianceName = "";
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_BasicNamedAllianceInformations(output);
      }
      
      public function serializeAs_BasicNamedAllianceInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_BasicAllianceInformations(output);
         output.writeUTF(this.allianceName);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BasicNamedAllianceInformations(input);
      }
      
      public function deserializeAs_BasicNamedAllianceInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._allianceNameFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BasicNamedAllianceInformations(tree);
      }
      
      public function deserializeAsyncAs_BasicNamedAllianceInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._allianceNameFunc);
      }
      
      private function _allianceNameFunc(input:ICustomDataInput) : void
      {
         this.allianceName = input.readUTF();
      }
   }
}
