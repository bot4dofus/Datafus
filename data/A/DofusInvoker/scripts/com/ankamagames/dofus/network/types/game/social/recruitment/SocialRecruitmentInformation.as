package com.ankamagames.dofus.network.types.game.social.recruitment
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SocialRecruitmentInformation implements INetworkType
   {
      
      public static const protocolId:uint = 209;
       
      
      public var socialId:uint = 0;
      
      public var recruitmentType:uint = 0;
      
      public var recruitmentTitle:String = "";
      
      public var recruitmentText:String = "";
      
      public var selectedLanguages:Vector.<uint>;
      
      public var selectedCriterion:Vector.<uint>;
      
      public var minLevel:uint = 0;
      
      public var minLevelFacultative:Boolean = false;
      
      public var invalidatedByModeration:Boolean = false;
      
      public var lastEditPlayerName:String = "";
      
      public var lastEditDate:Number = 0;
      
      public var recruitmentAutoLocked:Boolean = false;
      
      private var _selectedLanguagestree:FuncTree;
      
      private var _selectedCriteriontree:FuncTree;
      
      public function SocialRecruitmentInformation()
      {
         this.selectedLanguages = new Vector.<uint>();
         this.selectedCriterion = new Vector.<uint>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 209;
      }
      
      public function initSocialRecruitmentInformation(socialId:uint = 0, recruitmentType:uint = 0, recruitmentTitle:String = "", recruitmentText:String = "", selectedLanguages:Vector.<uint> = null, selectedCriterion:Vector.<uint> = null, minLevel:uint = 0, minLevelFacultative:Boolean = false, invalidatedByModeration:Boolean = false, lastEditPlayerName:String = "", lastEditDate:Number = 0, recruitmentAutoLocked:Boolean = false) : SocialRecruitmentInformation
      {
         this.socialId = socialId;
         this.recruitmentType = recruitmentType;
         this.recruitmentTitle = recruitmentTitle;
         this.recruitmentText = recruitmentText;
         this.selectedLanguages = selectedLanguages;
         this.selectedCriterion = selectedCriterion;
         this.minLevel = minLevel;
         this.minLevelFacultative = minLevelFacultative;
         this.invalidatedByModeration = invalidatedByModeration;
         this.lastEditPlayerName = lastEditPlayerName;
         this.lastEditDate = lastEditDate;
         this.recruitmentAutoLocked = recruitmentAutoLocked;
         return this;
      }
      
      public function reset() : void
      {
         this.socialId = 0;
         this.recruitmentType = 0;
         this.recruitmentTitle = "";
         this.recruitmentText = "";
         this.selectedLanguages = new Vector.<uint>();
         this.selectedCriterion = new Vector.<uint>();
         this.minLevel = 0;
         this.minLevelFacultative = false;
         this.invalidatedByModeration = false;
         this.lastEditPlayerName = "";
         this.lastEditDate = 0;
         this.recruitmentAutoLocked = false;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SocialRecruitmentInformation(output);
      }
      
      public function serializeAs_SocialRecruitmentInformation(output:ICustomDataOutput) : void
      {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.minLevelFacultative);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.invalidatedByModeration);
         _box0 = BooleanByteWrapper.setFlag(_box0,2,this.recruitmentAutoLocked);
         output.writeByte(_box0);
         if(this.socialId < 0)
         {
            throw new Error("Forbidden value (" + this.socialId + ") on element socialId.");
         }
         output.writeVarInt(this.socialId);
         output.writeByte(this.recruitmentType);
         output.writeUTF(this.recruitmentTitle);
         output.writeUTF(this.recruitmentText);
         output.writeShort(this.selectedLanguages.length);
         for(var _i5:uint = 0; _i5 < this.selectedLanguages.length; _i5++)
         {
            if(this.selectedLanguages[_i5] < 0)
            {
               throw new Error("Forbidden value (" + this.selectedLanguages[_i5] + ") on element 5 (starting at 1) of selectedLanguages.");
            }
            output.writeVarInt(this.selectedLanguages[_i5]);
         }
         output.writeShort(this.selectedCriterion.length);
         for(var _i6:uint = 0; _i6 < this.selectedCriterion.length; _i6++)
         {
            if(this.selectedCriterion[_i6] < 0)
            {
               throw new Error("Forbidden value (" + this.selectedCriterion[_i6] + ") on element 6 (starting at 1) of selectedCriterion.");
            }
            output.writeVarInt(this.selectedCriterion[_i6]);
         }
         if(this.minLevel < 0)
         {
            throw new Error("Forbidden value (" + this.minLevel + ") on element minLevel.");
         }
         output.writeShort(this.minLevel);
         output.writeUTF(this.lastEditPlayerName);
         if(this.lastEditDate < -9007199254740992 || this.lastEditDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.lastEditDate + ") on element lastEditDate.");
         }
         output.writeDouble(this.lastEditDate);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SocialRecruitmentInformation(input);
      }
      
      public function deserializeAs_SocialRecruitmentInformation(input:ICustomDataInput) : void
      {
         var _val5:uint = 0;
         var _val6:uint = 0;
         this.deserializeByteBoxes(input);
         this._socialIdFunc(input);
         this._recruitmentTypeFunc(input);
         this._recruitmentTitleFunc(input);
         this._recruitmentTextFunc(input);
         var _selectedLanguagesLen:uint = input.readUnsignedShort();
         for(var _i5:uint = 0; _i5 < _selectedLanguagesLen; _i5++)
         {
            _val5 = input.readVarUhInt();
            if(_val5 < 0)
            {
               throw new Error("Forbidden value (" + _val5 + ") on elements of selectedLanguages.");
            }
            this.selectedLanguages.push(_val5);
         }
         var _selectedCriterionLen:uint = input.readUnsignedShort();
         for(var _i6:uint = 0; _i6 < _selectedCriterionLen; _i6++)
         {
            _val6 = input.readVarUhInt();
            if(_val6 < 0)
            {
               throw new Error("Forbidden value (" + _val6 + ") on elements of selectedCriterion.");
            }
            this.selectedCriterion.push(_val6);
         }
         this._minLevelFunc(input);
         this._lastEditPlayerNameFunc(input);
         this._lastEditDateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SocialRecruitmentInformation(tree);
      }
      
      public function deserializeAsyncAs_SocialRecruitmentInformation(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._socialIdFunc);
         tree.addChild(this._recruitmentTypeFunc);
         tree.addChild(this._recruitmentTitleFunc);
         tree.addChild(this._recruitmentTextFunc);
         this._selectedLanguagestree = tree.addChild(this._selectedLanguagestreeFunc);
         this._selectedCriteriontree = tree.addChild(this._selectedCriteriontreeFunc);
         tree.addChild(this._minLevelFunc);
         tree.addChild(this._lastEditPlayerNameFunc);
         tree.addChild(this._lastEditDateFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.minLevelFacultative = BooleanByteWrapper.getFlag(_box0,0);
         this.invalidatedByModeration = BooleanByteWrapper.getFlag(_box0,1);
         this.recruitmentAutoLocked = BooleanByteWrapper.getFlag(_box0,2);
      }
      
      private function _socialIdFunc(input:ICustomDataInput) : void
      {
         this.socialId = input.readVarUhInt();
         if(this.socialId < 0)
         {
            throw new Error("Forbidden value (" + this.socialId + ") on element of SocialRecruitmentInformation.socialId.");
         }
      }
      
      private function _recruitmentTypeFunc(input:ICustomDataInput) : void
      {
         this.recruitmentType = input.readByte();
         if(this.recruitmentType < 0)
         {
            throw new Error("Forbidden value (" + this.recruitmentType + ") on element of SocialRecruitmentInformation.recruitmentType.");
         }
      }
      
      private function _recruitmentTitleFunc(input:ICustomDataInput) : void
      {
         this.recruitmentTitle = input.readUTF();
      }
      
      private function _recruitmentTextFunc(input:ICustomDataInput) : void
      {
         this.recruitmentText = input.readUTF();
      }
      
      private function _selectedLanguagestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._selectedLanguagestree.addChild(this._selectedLanguagesFunc);
         }
      }
      
      private function _selectedLanguagesFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of selectedLanguages.");
         }
         this.selectedLanguages.push(_val);
      }
      
      private function _selectedCriteriontreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._selectedCriteriontree.addChild(this._selectedCriterionFunc);
         }
      }
      
      private function _selectedCriterionFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of selectedCriterion.");
         }
         this.selectedCriterion.push(_val);
      }
      
      private function _minLevelFunc(input:ICustomDataInput) : void
      {
         this.minLevel = input.readShort();
         if(this.minLevel < 0)
         {
            throw new Error("Forbidden value (" + this.minLevel + ") on element of SocialRecruitmentInformation.minLevel.");
         }
      }
      
      private function _lastEditPlayerNameFunc(input:ICustomDataInput) : void
      {
         this.lastEditPlayerName = input.readUTF();
      }
      
      private function _lastEditDateFunc(input:ICustomDataInput) : void
      {
         this.lastEditDate = input.readDouble();
         if(this.lastEditDate < -9007199254740992 || this.lastEditDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.lastEditDate + ") on element of SocialRecruitmentInformation.lastEditDate.");
         }
      }
   }
}
