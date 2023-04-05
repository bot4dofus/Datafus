package com.ankamagames.dofus.datacenter.alliance
{
   import com.ankamagames.dofus.datacenter.social.SocialTag;
   import com.ankamagames.dofus.misc.utils.GameDataQuery;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class AllianceTag extends SocialTag implements IDataCenter
   {
      
      public static const MODULE:String = "AllianceTags";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AllianceTag));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getAllianceTagById,getAllianceTags);
       
      
      private var _type:AllianceTagsType;
      
      public function AllianceTag()
      {
         super();
      }
      
      public static function getAllianceTagById(id:int) : AllianceTag
      {
         return GameData.getObject(MODULE,id) as AllianceTag;
      }
      
      public static function getAllianceTagsByTagId(id:int) : Vector.<SocialTag>
      {
         var tagId:uint = 0;
         var tagIds:Vector.<uint> = GameDataQuery.queryEquals(AllianceTag,"typeId",id);
         var tags:Vector.<SocialTag> = new Vector.<SocialTag>(0);
         for each(tagId in tagIds)
         {
            tags.push(AllianceTag.getAllianceTagById(tagId));
         }
         return tags;
      }
      
      public static function getAllianceTags() : Array
      {
         return getSocialTags(MODULE);
      }
      
      public function get tagType() : AllianceTagsType
      {
         if(!this._type)
         {
            this._type = AllianceTagsType.getAllianceTagsTypeById(this.typeId);
         }
         return this._type;
      }
   }
}
