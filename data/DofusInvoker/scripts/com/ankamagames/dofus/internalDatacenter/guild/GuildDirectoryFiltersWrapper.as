package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.dofus.datacenter.guild.GuildTag;
   import com.ankamagames.dofus.network.enums.GuildSummarySortEnum;
   
   public class GuildDirectoryFiltersWrapper
   {
      
      private static const TAG_TYPE_GOAL:int = 1;
      
      private static const TAG_TYPE_ATMOSPHERE:int = 2;
      
      private static const TAG_TYPE_LOGIN_HABITS:int = 3;
       
      
      public var nameFilter:String = "";
      
      public var minLevelFilter:uint = 1;
      
      public var maxLevelFilter:uint = 200;
      
      public var recruitmentTypeFilter:Vector.<uint>;
      
      public var languagesFilter:Vector.<uint>;
      
      public var criterionFilter:Vector.<uint>;
      
      public var minPlayerLevelFilter:uint = 1;
      
      public var maxPlayerLevelFilter:uint = 200;
      
      public var minSuccessFilter:uint = 0;
      
      public var maxSuccessFilter:uint = 20792;
      
      public var sortType:uint = 3;
      
      public var sortDescending:Boolean = false;
      
      public var hideFullFilter:Boolean = false;
      
      public function GuildDirectoryFiltersWrapper()
      {
         this.recruitmentTypeFilter = new Vector.<uint>();
         this.languagesFilter = new Vector.<uint>();
         this.criterionFilter = new Vector.<uint>();
         super();
      }
      
      public function formatForData() : Object
      {
         var filterId:uint = 0;
         var i:int = 0;
         var params:Object = {};
         params.ambianceFilters = "";
         params.interestFilters = "";
         params.playtimeFilters = "";
         params.languageFilters = "";
         params.recruitmentType = "";
         for each(filterId in this.criterionFilter)
         {
            switch(GuildTag.getGuildTagById(filterId).typeId)
            {
               case TAG_TYPE_GOAL:
                  params.interestFilters += filterId + ",";
                  break;
               case TAG_TYPE_ATMOSPHERE:
                  params.ambianceFilters += filterId + ",";
                  break;
               case TAG_TYPE_LOGIN_HABITS:
                  params.playtimeFilters += filterId + ",";
                  break;
            }
         }
         for(i = 0; i < this.languagesFilter.length; i++)
         {
            params.languageFilters += this.languagesFilter[i] + "" + (i < this.languagesFilter.length - 1 ? "," : "");
         }
         for(var j:int = 0; j < this.recruitmentTypeFilter.length; j++)
         {
            params.recruitmentType += this.recruitmentTypeFilter[j] + "" + (j < this.recruitmentTypeFilter.length - 1 ? "," : "");
         }
         if(params.interestFilters.length > 0)
         {
            params.interestFilters = params.interestFilters.substr(0,params.interestFilters.length - 1);
         }
         if(params.ambianceFilters.length > 0)
         {
            params.ambianceFilters = params.ambianceFilters.substr(0,params.ambianceFilters.length - 1);
         }
         if(params.playtimeFilters.length > 0)
         {
            params.playtimeFilters = params.playtimeFilters.substr(0,params.playtimeFilters.length - 1);
         }
         params.guildLevelMinMax = this.minLevelFilter + "-" + this.maxLevelFilter;
         params.playerLevelMinMax = this.minPlayerLevelFilter + "-" + this.maxPlayerLevelFilter;
         params.achievementMinMax = this.minSuccessFilter + "-" + this.maxSuccessFilter;
         params.searchName = this.nameFilter;
         params.lastSort = "";
         switch(this.sortType)
         {
            case GuildSummarySortEnum.SORT_BY_LAST_ACTIVITY:
               params.lastSort = "Last activity - ";
               break;
            case GuildSummarySortEnum.SORT_BY_LEVEL:
               params.lastSort = "Level - ";
               break;
            case GuildSummarySortEnum.SORT_BY_NAME:
               params.lastSort = "Name - ";
               break;
            case GuildSummarySortEnum.SORT_BY_NB_MEMBERS:
               params.lastSort = "Nb members - ";
         }
         params.lastSort += !!this.sortDescending ? "DESC" : "ASC";
         return params;
      }
   }
}
