package com.ankamagames.dofus.network.messages.game.guild.recruitment
{
   import com.ankamagames.dofus.network.types.game.guild.recruitment.GuildRecruitmentInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class UpdateRecruitmentInformationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 691;
       
      
      private var _isInitialized:Boolean = false;
      
      public var recruitmentData:GuildRecruitmentInformation;
      
      private var _recruitmentDatatree:FuncTree;
      
      public function UpdateRecruitmentInformationMessage()
      {
         this.recruitmentData = new GuildRecruitmentInformation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 691;
      }
      
      public function initUpdateRecruitmentInformationMessage(recruitmentData:GuildRecruitmentInformation = null) : UpdateRecruitmentInformationMessage
      {
         this.recruitmentData = recruitmentData;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.recruitmentData = new GuildRecruitmentInformation();
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
         this.serializeAs_UpdateRecruitmentInformationMessage(output);
      }
      
      public function serializeAs_UpdateRecruitmentInformationMessage(output:ICustomDataOutput) : void
      {
         this.recruitmentData.serializeAs_GuildRecruitmentInformation(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_UpdateRecruitmentInformationMessage(input);
      }
      
      public function deserializeAs_UpdateRecruitmentInformationMessage(input:ICustomDataInput) : void
      {
         this.recruitmentData = new GuildRecruitmentInformation();
         this.recruitmentData.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_UpdateRecruitmentInformationMessage(tree);
      }
      
      public function deserializeAsyncAs_UpdateRecruitmentInformationMessage(tree:FuncTree) : void
      {
         this._recruitmentDatatree = tree.addChild(this._recruitmentDatatreeFunc);
      }
      
      private function _recruitmentDatatreeFunc(input:ICustomDataInput) : void
      {
         this.recruitmentData = new GuildRecruitmentInformation();
         this.recruitmentData.deserializeAsync(this._recruitmentDatatree);
      }
   }
}
