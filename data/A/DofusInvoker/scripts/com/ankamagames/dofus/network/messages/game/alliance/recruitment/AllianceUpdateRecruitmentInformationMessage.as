package com.ankamagames.dofus.network.messages.game.alliance.recruitment
{
   import com.ankamagames.dofus.network.types.game.alliance.recruitment.AllianceRecruitmentInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceUpdateRecruitmentInformationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5387;
       
      
      private var _isInitialized:Boolean = false;
      
      public var recruitmentData:AllianceRecruitmentInformation;
      
      private var _recruitmentDatatree:FuncTree;
      
      public function AllianceUpdateRecruitmentInformationMessage()
      {
         this.recruitmentData = new AllianceRecruitmentInformation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5387;
      }
      
      public function initAllianceUpdateRecruitmentInformationMessage(recruitmentData:AllianceRecruitmentInformation = null) : AllianceUpdateRecruitmentInformationMessage
      {
         this.recruitmentData = recruitmentData;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.recruitmentData = new AllianceRecruitmentInformation();
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:ICustomDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      override public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         var tree:FuncTree = new FuncTree();
         tree.setRoot(input);
         this.deserializeAsync(tree);
         return tree;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AllianceUpdateRecruitmentInformationMessage(output);
      }
      
      public function serializeAs_AllianceUpdateRecruitmentInformationMessage(output:ICustomDataOutput) : void
      {
         this.recruitmentData.serializeAs_AllianceRecruitmentInformation(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceUpdateRecruitmentInformationMessage(input);
      }
      
      public function deserializeAs_AllianceUpdateRecruitmentInformationMessage(input:ICustomDataInput) : void
      {
         this.recruitmentData = new AllianceRecruitmentInformation();
         this.recruitmentData.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceUpdateRecruitmentInformationMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceUpdateRecruitmentInformationMessage(tree:FuncTree) : void
      {
         this._recruitmentDatatree = tree.addChild(this._recruitmentDatatreeFunc);
      }
      
      private function _recruitmentDatatreeFunc(input:ICustomDataInput) : void
      {
         this.recruitmentData = new AllianceRecruitmentInformation();
         this.recruitmentData.deserializeAsync(this._recruitmentDatatree);
      }
   }
}
