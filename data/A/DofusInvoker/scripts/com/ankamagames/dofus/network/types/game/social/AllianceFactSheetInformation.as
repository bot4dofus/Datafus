package com.ankamagames.dofus.network.types.game.social
{
   import com.ankamagames.dofus.network.types.game.alliance.recruitment.AllianceRecruitmentInformation;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AllianceFactSheetInformation extends AllianceInformation implements INetworkType
   {
      
      public static const protocolId:uint = 6340;
       
      
      public var creationDate:uint = 0;
      
      public var nbMembers:uint = 0;
      
      public var nbSubarea:uint = 0;
      
      public var nbTaxCollectors:uint = 0;
      
      public var recruitment:AllianceRecruitmentInformation;
      
      private var _recruitmenttree:FuncTree;
      
      public function AllianceFactSheetInformation()
      {
         this.recruitment = new AllianceRecruitmentInformation();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 6340;
      }
      
      public function initAllianceFactSheetInformation(allianceId:uint = 0, allianceTag:String = "", allianceName:String = "", allianceEmblem:SocialEmblem = null, creationDate:uint = 0, nbMembers:uint = 0, nbSubarea:uint = 0, nbTaxCollectors:uint = 0, recruitment:AllianceRecruitmentInformation = null) : AllianceFactSheetInformation
      {
         super.initAllianceInformation(allianceId,allianceTag,allianceName,allianceEmblem);
         this.creationDate = creationDate;
         this.nbMembers = nbMembers;
         this.nbSubarea = nbSubarea;
         this.nbTaxCollectors = nbTaxCollectors;
         this.recruitment = recruitment;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.creationDate = 0;
         this.nbMembers = 0;
         this.nbSubarea = 0;
         this.nbTaxCollectors = 0;
         this.recruitment = new AllianceRecruitmentInformation();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AllianceFactSheetInformation(output);
      }
      
      public function serializeAs_AllianceFactSheetInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_AllianceInformation(output);
         if(this.creationDate < 0)
         {
            throw new Error("Forbidden value (" + this.creationDate + ") on element creationDate.");
         }
         output.writeInt(this.creationDate);
         if(this.nbMembers < 0)
         {
            throw new Error("Forbidden value (" + this.nbMembers + ") on element nbMembers.");
         }
         output.writeVarShort(this.nbMembers);
         if(this.nbSubarea < 0)
         {
            throw new Error("Forbidden value (" + this.nbSubarea + ") on element nbSubarea.");
         }
         output.writeVarShort(this.nbSubarea);
         if(this.nbTaxCollectors < 0)
         {
            throw new Error("Forbidden value (" + this.nbTaxCollectors + ") on element nbTaxCollectors.");
         }
         output.writeVarShort(this.nbTaxCollectors);
         this.recruitment.serializeAs_AllianceRecruitmentInformation(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceFactSheetInformation(input);
      }
      
      public function deserializeAs_AllianceFactSheetInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._creationDateFunc(input);
         this._nbMembersFunc(input);
         this._nbSubareaFunc(input);
         this._nbTaxCollectorsFunc(input);
         this.recruitment = new AllianceRecruitmentInformation();
         this.recruitment.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceFactSheetInformation(tree);
      }
      
      public function deserializeAsyncAs_AllianceFactSheetInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._creationDateFunc);
         tree.addChild(this._nbMembersFunc);
         tree.addChild(this._nbSubareaFunc);
         tree.addChild(this._nbTaxCollectorsFunc);
         this._recruitmenttree = tree.addChild(this._recruitmenttreeFunc);
      }
      
      private function _creationDateFunc(input:ICustomDataInput) : void
      {
         this.creationDate = input.readInt();
         if(this.creationDate < 0)
         {
            throw new Error("Forbidden value (" + this.creationDate + ") on element of AllianceFactSheetInformation.creationDate.");
         }
      }
      
      private function _nbMembersFunc(input:ICustomDataInput) : void
      {
         this.nbMembers = input.readVarUhShort();
         if(this.nbMembers < 0)
         {
            throw new Error("Forbidden value (" + this.nbMembers + ") on element of AllianceFactSheetInformation.nbMembers.");
         }
      }
      
      private function _nbSubareaFunc(input:ICustomDataInput) : void
      {
         this.nbSubarea = input.readVarUhShort();
         if(this.nbSubarea < 0)
         {
            throw new Error("Forbidden value (" + this.nbSubarea + ") on element of AllianceFactSheetInformation.nbSubarea.");
         }
      }
      
      private function _nbTaxCollectorsFunc(input:ICustomDataInput) : void
      {
         this.nbTaxCollectors = input.readVarUhShort();
         if(this.nbTaxCollectors < 0)
         {
            throw new Error("Forbidden value (" + this.nbTaxCollectors + ") on element of AllianceFactSheetInformation.nbTaxCollectors.");
         }
      }
      
      private function _recruitmenttreeFunc(input:ICustomDataInput) : void
      {
         this.recruitment = new AllianceRecruitmentInformation();
         this.recruitment.deserializeAsync(this._recruitmenttree);
      }
   }
}
