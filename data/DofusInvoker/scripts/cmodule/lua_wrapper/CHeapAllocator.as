package cmodule.lua_wrapper
{
   class CHeapAllocator implements ICAllocator
   {
       
      
      private var pmalloc:Function;
      
      private var pfree:Function;
      
      function CHeapAllocator()
      {
         super();
      }
      
      public function free(param1:int) : void
      {
         if(this.pfree == null)
         {
            this.pfree = new CProcTypemap(CTypemap.VoidType,[CTypemap.PtrType]).fromC([_free]);
         }
         this.pfree(param1);
      }
      
      public function alloc(param1:int) : int
      {
         var _loc2_:int = 0;
         if(this.pmalloc == null)
         {
            this.pmalloc = new CProcTypemap(CTypemap.PtrType,[CTypemap.IntType]).fromC([_malloc]);
         }
         return int(this.pmalloc(param1));
      }
   }
}
