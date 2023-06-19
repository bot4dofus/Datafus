package com.ankamagames.dofus.internalDatacenter.social
{
   import com.ankamagames.dofus.datacenter.social.SocialTag;
   
   public class SocialDirectoryFiltersWrapper
   {
      
      private static const TAG_TYPE_GOAL:int = 1;
      
      private static const TAG_TYPE_ATMOSPHERE:int = 2;
      
      private static const TAG_TYPE_LOGIN_HABITS:int = 3;
      
      protected static const SORT_NAME_STR:String = "Name - ";
      
      protected static const SORT_NB_MEMBERS_STR:String = "Nb members - ";
       
      
      public var sortType:uint;
      
      public var textFilter:String = "";
      
      public var recruitmentTypeFilter:Vector.<uint>;
      
      public var languagesFilter:Vector.<uint>;
      
      public var criterionFilter:Vector.<uint>;
      
      public var minPlayerLevelFilter:uint = 1;
      
      public var maxPlayerLevelFilter:uint = 200;
      
      public var sortDescending:Boolean = false;
      
      public var hideFullFilter:Boolean = false;
      
      public var followingSocialGroupCriteria:Boolean = false;
      
      public function SocialDirectoryFiltersWrapper()
      {
         this.sortType = this.initSortType();
         this.recruitmentTypeFilter = new Vector.<uint>();
         this.languagesFilter = new Vector.<uint>();
         this.criterionFilter = new Vector.<uint>();
         super();
      }
      
      public function setFormat(params:Object, module:String) : Object
      {
         var filterId:uint = 0;
         var i:int = 0;
         params.ambianceFilters = "";
         params.interestFilters = "";
         params.playtimeFilters = "";
         params.languageFilters = "";
         params.recruitmentType = "";
         for each(filterId in this.criterionFilter)
         {
            switch(SocialTag.getSocialTagById(module,filterId).typeId)
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
         params.playerLevelMinMax = this.minPlayerLevelFilter + "-" + this.maxPlayerLevelFilter;
         params.searchText = this.textFilter;
         params.lastSort = "";
         params.lastSort += !!this.sortDescending ? "DESC" : "ASC";
         return params;
      }
      
      protected function initSortType() : uint
      {
         return 0;
      }
   }
}
