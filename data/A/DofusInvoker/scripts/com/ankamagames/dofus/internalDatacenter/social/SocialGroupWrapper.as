package com.ankamagames.dofus.internalDatacenter.social
{
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SocialGroupWrapper implements IDataCenter
   {
       
      
      private var _groupName:String;
      
      public var lastActivityDay:uint;
      
      public var nbPendingApply:uint;
      
      public var groupId:uint;
      
      public var upEmblem:EmblemWrapper;
      
      public var backEmblem:EmblemWrapper;
      
      public var creationDate:uint;
      
      public var leaderId:Number;
      
      public var nbMembers:uint;
      
      public var motd:String = "";
      
      public var formattedMotd:String = "";
      
      public var motdWriterId:Number;
      
      public var motdWriterName:String = "";
      
      public var motdTimestamp:Number;
      
      public var bulletin:String = "";
      
      public var formattedBulletin:String = "";
      
      public var bulletinWriterId:Number;
      
      public var bulletinWriterName:String = "";
      
      public var bulletinTimestamp:Number;
      
      public var membersTimestamp:Number;
      
      public function SocialGroupWrapper()
      {
         super();
      }
      
      public function get groupName() : String
      {
         if(this._groupName == "#NONAME#")
         {
            return I18n.getUiText("ui.social.noName");
         }
         return this._groupName;
      }
      
      public function set groupName(name:String) : void
      {
         this._groupName = name;
      }
      
      public function get realGroupName() : String
      {
         return this._groupName;
      }
      
      public function get recruitmentInfo() : SocialRecruitmentDataWrapper
      {
         return null;
      }
      
      public function get recruitmentType() : uint
      {
         return this.recruitmentInfo.recruitmentType;
      }
   }
}
