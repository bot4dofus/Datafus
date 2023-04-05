package com.ankamagames.dofus.internalDatacenter.social
{
   import com.ankamagames.dofus.datacenter.alliance.AllianceTag;
   import com.ankamagames.dofus.network.enums.AllianceSummarySortEnum;
   
   public class AllianceDirectoryFiltersWrapper extends SocialDirectoryFiltersWrapper
   {
      
      private static const SORT_TAG_STR:String = "Tag - ";
      
      private static const SORT_NB_TERRITORIES_STR:String = "Nb territories - ";
       
      
      public var filterType:int = 0;
      
      public function AllianceDirectoryFiltersWrapper()
      {
         super();
      }
      
      public function formatForData() : Object
      {
         var params:Object = {};
         params = setFormat(params,AllianceTag.MODULE);
         switch(sortType)
         {
            case AllianceSummarySortEnum.SORT_BY_ALLIANCE_NAME:
               params.lastSort = SORT_NAME_STR;
               break;
            case AllianceSummarySortEnum.SORT_BY_ALLIANCE_TAG:
               params.lastSort = SORT_TAG_STR;
               break;
            case AllianceSummarySortEnum.SORT_BY_NB_TERRITORIES:
               params.lastSort = SORT_NB_TERRITORIES_STR;
               break;
            case AllianceSummarySortEnum.SORT_BY_ALLIANCE_NB_MEMBERS:
               params.lastSort = SORT_NB_MEMBERS_STR;
         }
         params.lastSort += !!sortDescending ? "DESC" : "ASC";
         params.filterType = this.filterType;
         return params;
      }
      
      override protected function initSortType() : uint
      {
         return AllianceSummarySortEnum.SORT_BY_NB_TERRITORIES;
      }
   }
}
