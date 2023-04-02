package com.ankamagames.dofus.internalDatacenter.social
{
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalSocialPublicInformations;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class SocialGroupFactSheetWrapper implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SocialGroupFactSheetWrapper));
       
      
      protected var _groupName:String;
      
      public var groupId:uint;
      
      public var upEmblem:EmblemWrapper;
      
      public var backEmblem:EmblemWrapper;
      
      public var leaderId:Number = 0;
      
      public var nbMembers:uint = 0;
      
      public var creationDate:Number = 0;
      
      public var members:Vector.<CharacterMinimalSocialPublicInformations>;
      
      public function SocialGroupFactSheetWrapper(groupId:uint, groupName:String, groupUpEmblem:EmblemWrapper, groupBackEmblem:EmblemWrapper, leaderId:Number, nbMembers:uint, creationDate:Number, members:Vector.<CharacterMinimalSocialPublicInformations>)
      {
         this.members = new Vector.<CharacterMinimalSocialPublicInformations>();
         super();
         this.init(groupId,groupName,groupUpEmblem,groupBackEmblem,leaderId,nbMembers,creationDate,members);
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
      
      public function get leaderName() : String
      {
         var member:CharacterMinimalSocialPublicInformations = null;
         if(this.members && this.members.length > 0)
         {
            for each(member in this.members)
            {
               if(member.id == this.leaderId)
               {
                  return member.name;
               }
            }
         }
         return "";
      }
      
      public function update(groupId:uint, groupName:String, groupUpEmblem:EmblemWrapper, groupBackEmblem:EmblemWrapper, leaderId:Number, nbMembers:uint, creationDate:Number, members:Vector.<CharacterMinimalSocialPublicInformations>) : void
      {
         this.init(groupId,groupName,groupUpEmblem,groupBackEmblem,leaderId,nbMembers,creationDate,members);
      }
      
      private function init(groupId:uint, groupName:String, groupUpEmblem:EmblemWrapper, groupBackEmblem:EmblemWrapper, leaderId:Number, nbMembers:uint, creationDate:Number, members:Vector.<CharacterMinimalSocialPublicInformations>) : void
      {
         this.groupId = groupId;
         this.groupName = groupName;
         this.upEmblem = groupUpEmblem;
         this.backEmblem = groupBackEmblem;
         this.leaderId = leaderId;
         this.nbMembers = nbMembers;
         this.creationDate = creationDate;
         this.members = members;
      }
   }
}
