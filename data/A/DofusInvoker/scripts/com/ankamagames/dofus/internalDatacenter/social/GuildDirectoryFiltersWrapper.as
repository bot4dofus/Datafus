package com.ankamagames.dofus.internalDatacenter.social
{
   import com.ankamagames.dofus.datacenter.guild.GuildTag;
   import com.ankamagames.dofus.network.enums.GuildSummarySortEnum;
   
   public class GuildDirectoryFiltersWrapper extends SocialDirectoryFiltersWrapper
   {
      
      private static const SORT_LEVEL_STR:String = "Level - ";
      
      private static const SORT_LAST_ACTIVITY_STR:String = "Last activity - ";
       
      
      public var minLevelFilter:uint = 1;
      
      public var maxLevelFilter:uint = 200;
      
      public var minSuccessFilter:uint = 0;
      
      public var maxSuccessFilter:uint = 22610;
      
      public function GuildDirectoryFiltersWrapper()
      {
         super();
      }
      
      public function formatForData() : Object
      {
         var params:Object = {};
         params = setFormat(params,GuildTag.MODULE);
         switch(sortType)
         {
            case GuildSummarySortEnum.SORT_BY_LAST_ACTIVITY:
               params.lastSort = SORT_LAST_ACTIVITY_STR;
               break;
            case GuildSummarySortEnum.SORT_BY_LEVEL:
               params.lastSort = SORT_LEVEL_STR;
               break;
            case GuildSummarySortEnum.SORT_BY_NAME:
               params.lastSort = SORT_NAME_STR;
               break;
            case GuildSummarySortEnum.SORT_BY_NB_MEMBERS:
               params.lastSort = SORT_NB_MEMBERS_STR;
         }
         params.guildLevelMinMax = this.minLevelFilter + "-" + this.maxLevelFilter;
         params.achievementMinMax = this.minSuccessFilter + "-" + this.maxSuccessFilter;
         params.lastSort += !!sortDescending ? "DESC" : "ASC";
         return params;
      }
      
      override protected function initSortType() : uint
      {
         return GuildSummarySortEnum.SORT_BY_LAST_ACTIVITY;
      }
   }
}
