package Ankama_Common.ui.items
{
   public class RecipesFilterWrapper
   {
       
      
      public var jobId:int;
      
      public var minLevel:int;
      
      public var maxLevel:int;
      
      public var typeId:int;
      
      public function RecipesFilterWrapper(pjobId:int, pminLevel:int, pmaxLevel:int, ptypeId:int = 0)
      {
         super();
         this.jobId = pjobId;
         this.minLevel = pminLevel;
         this.maxLevel = pmaxLevel;
         this.typeId = ptypeId;
      }
   }
}
