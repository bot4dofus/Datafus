package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class HumanOptionAlliance extends HumanOption implements INetworkType
   {
      
      public static const protocolId:uint = 7953;
       
      
      public var allianceInformation:AllianceInformation;
      
      public var aggressable:uint = 0;
      
      private var _allianceInformationtree:FuncTree;
      
      public function HumanOptionAlliance()
      {
         this.allianceInformation = new AllianceInformation();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7953;
      }
      
      public function initHumanOptionAlliance(allianceInformation:AllianceInformation = null, aggressable:uint = 0) : HumanOptionAlliance
      {
         this.allianceInformation = allianceInformation;
         this.aggressable = aggressable;
         return this;
      }
      
      override public function reset() : void
      {
         this.allianceInformation = new AllianceInformation();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_HumanOptionAlliance(output);
      }
      
      public function serializeAs_HumanOptionAlliance(output:ICustomDataOutput) : void
      {
         super.serializeAs_HumanOption(output);
         this.allianceInformation.serializeAs_AllianceInformation(output);
         output.writeByte(this.aggressable);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HumanOptionAlliance(input);
      }
      
      public function deserializeAs_HumanOptionAlliance(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.allianceInformation = new AllianceInformation();
         this.allianceInformation.deserialize(input);
         this._aggressableFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HumanOptionAlliance(tree);
      }
      
      public function deserializeAsyncAs_HumanOptionAlliance(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._allianceInformationtree = tree.addChild(this._allianceInformationtreeFunc);
         tree.addChild(this._aggressableFunc);
      }
      
      private function _allianceInformationtreeFunc(input:ICustomDataInput) : void
      {
         this.allianceInformation = new AllianceInformation();
         this.allianceInformation.deserializeAsync(this._allianceInformationtree);
      }
      
      private function _aggressableFunc(input:ICustomDataInput) : void
      {
         this.aggressable = input.readByte();
         if(this.aggressable < 0)
         {
            throw new Error("Forbidden value (" + this.aggressable + ") on element of HumanOptionAlliance.aggressable.");
         }
      }
   }
}
