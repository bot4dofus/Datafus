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
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc1_:Object = {};
         _loc1_.ambianceFilters = "";
         _loc1_.interestFilters = "";
         _loc1_.playtimeFilters = "";
         _loc1_.languageFilters = "";
         _loc1_.recruitmentType = "";
         for each(_loc2_ in this.criterionFilter)
         {
            switch(GuildTag.getGuildTagById(_loc2_).typeId)
            {
               case TAG_TYPE_GOAL:
                  _loc1_.interestFilters += _loc2_ + ",";
                  break;
               case TAG_TYPE_ATMOSPHERE:
                  _loc1_.ambianceFilters += _loc2_ + ",";
                  break;
               case TAG_TYPE_LOGIN_HABITS:
                  _loc1_.playtimeFilters += _loc2_ + ",";
                  break;
            }
         }
         for(_loc3_ = 0; _loc3_ < this.languagesFilter.length; _loc3_++)
         {
            _loc1_.languageFilters += this.languagesFilter[_loc3_] + "" + (_loc3_ < this.languagesFilter.length - 1 ? "," : "");
         }
         for(_loc3_ = 0; _loc3_ < this.recruitmentTypeFilter.length; _loc3_++)
         {
            _loc1_.recruitmentType += this.recruitmentTypeFilter[_loc3_] + "" + (_loc3_ < this.recruitmentTypeFilter.length - 1 ? "," : "");
         }
         if(_loc1_.interestFilters.length > 0)
         {
            _loc1_.interestFilters = _loc1_.interestFilters.substr(0,_loc1_.interestFilters.length - 1);
         }
         if(_loc1_.ambianceFilters.length > 0)
         {
            _loc1_.ambianceFilters = _loc1_.ambianceFilters.substr(0,_loc1_.ambianceFilters.length - 1);
         }
         if(_loc1_.playtimeFilters.length > 0)
         {
            _loc1_.playtimeFilters = _loc1_.playtimeFilters.substr(0,_loc1_.playtimeFilters.length - 1);
         }
         _loc1_.guildLevelMinMax = this.minLevelFilter + "-" + this.maxLevelFilter;
         _loc1_.playerLevelMinMax = this.minPlayerLevelFilter + "-" + this.maxPlayerLevelFilter;
         _loc1_.achievementMinMax = this.minSuccessFilter + "-" + this.maxSuccessFilter;
         _loc1_.searchName = this.nameFilter;
         _loc1_.lastSort = "";
         switch(this.sortType)
         {
            case GuildSummarySortEnum.SORT_BY_LAST_ACTIVITY:
               _loc1_.lastSort = "Last activity - ";
               break;
            case GuildSummarySortEnum.SORT_BY_LEVEL:
               _loc1_.lastSort = "Level - ";
               break;
            case GuildSummarySortEnum.SORT_BY_NAME:
               _loc1_.lastSort = "Name - ";
               break;
            case GuildSummarySortEnum.SORT_BY_NB_MEMBERS:
               _loc1_.lastSort = "Nb members - ";
         }
         _loc1_.lastSort += !!this.sortDescending ? "DESC" : "ASC";
         return _loc1_;
      }
   }
}
