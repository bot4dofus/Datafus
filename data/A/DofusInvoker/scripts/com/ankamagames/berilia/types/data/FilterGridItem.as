package com.ankamagames.berilia.types.data
{
   public class FilterGridItem
   {
       
      
      public var filterId:int;
      
      public var nameId:String;
      
      public var text:String;
      
      public var gfxId:String;
      
      public var catId:int;
      
      public var selected:Boolean;
      
      public var isCat:Boolean;
      
      public function FilterGridItem(pFilterId:int, pNameId:String, pText:String, pGfxId:String, pSelected:Boolean, pCatId:int)
      {
         super();
         this.filterId = pFilterId;
         this.nameId = pNameId;
         this.text = pText;
         this.gfxId = pGfxId;
         this.selected = pSelected;
         this.catId = pCatId;
         this.isCat = false;
      }
   }
}
