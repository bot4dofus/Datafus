package com.ankamagames.dofus.datacenter.guild
{
   import com.ankamagames.dofus.datacenter.social.SocialTag;
   import com.ankamagames.dofus.misc.utils.GameDataQuery;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class GuildTag extends SocialTag implements IDataCenter
   {
      
      public static const MODULE:String = "GuildTags";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GuildTag));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getGuildTagById,getGuildTags);
       
      
      private var _type:GuildTagsType;
      
      public function GuildTag()
      {
         super();
      }
      
      public static function getGuildTagById(id:int) : GuildTag
      {
         return GameData.getObject(MODULE,id) as GuildTag;
      }
      
      public static function getGuildTagsByTagId(id:int) : Vector.<SocialTag>
      {
         var tagId:uint = 0;
         var tagIds:Vector.<uint> = GameDataQuery.queryEquals(GuildTag,"typeId",id);
         var tags:Vector.<SocialTag> = new Vector.<SocialTag>(0);
         for each(tagId in tagIds)
         {
            tags.push(GuildTag.getGuildTagById(tagId));
         }
         return tags;
      }
      
      public static function getGuildTags() : Array
      {
         return getSocialTags(MODULE);
      }
      
      public function get tagType() : GuildTagsType
      {
         if(!this._type)
         {
            this._type = GuildTagsType.getGuildTagsTypeById(this.typeId);
         }
         return this._type;
      }
   }
}
