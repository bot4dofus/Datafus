package com.ankamagames.jerakine.managers
{
   import flash.display.DisplayObject;
   import flash.filters.BitmapFilter;
   import flash.utils.Dictionary;
   
   public class FiltersManager
   {
      
      private static var _self:FiltersManager;
       
      
      private var dFilters:Dictionary;
      
      public function FiltersManager()
      {
         super();
         this.dFilters = new Dictionary(true);
      }
      
      public static function getInstance() : FiltersManager
      {
         if(_self == null)
         {
            _self = new FiltersManager();
         }
         return _self;
      }
      
      public function addEffect(pTarget:DisplayObject, pFilter:BitmapFilter) : void
      {
         var filters:Array = this.dFilters[pTarget] as Array;
         if(filters == null)
         {
            filters = this.dFilters[pTarget] = pTarget.filters;
         }
         filters.push(pFilter);
         pTarget.filters = filters;
      }
      
      public function removeEffect(pTarget:DisplayObject, pFilter:BitmapFilter) : void
      {
         var filters:Array = this.dFilters[pTarget] as Array;
         if(filters == null)
         {
            filters = this.dFilters[pTarget] = pTarget.filters;
         }
         var index:int = this.indexOf(pTarget,pFilter);
         if(index != -1)
         {
            filters.splice(index,1);
            pTarget.filters = filters;
         }
      }
      
      public function indexOf(pTarget:DisplayObject, pFilter:BitmapFilter) : int
      {
         var f:BitmapFilter = null;
         var filters:Array = this.dFilters[pTarget] as Array;
         if(filters == null)
         {
            return -1;
         }
         var index:int = filters.length;
         while(index--)
         {
            f = filters[index];
            if(f == pFilter)
            {
               return index;
            }
         }
         return -1;
      }
   }
}
