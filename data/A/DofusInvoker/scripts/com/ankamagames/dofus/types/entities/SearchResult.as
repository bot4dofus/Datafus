package com.ankamagames.dofus.types.entities
{
   public class SearchResult
   {
      
      public static const VALID_NONE:int = 0;
      
      public static const VALID_PARTIAL:int = 1;
      
      public static const VALID_ALL:int = 2;
       
      
      public var resultData;
      
      public var resultCode:int;
      
      public function SearchResult()
      {
         super();
      }
   }
}
