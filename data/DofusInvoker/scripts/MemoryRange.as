package
{
   public class MemoryRange
   {
       
      
      public var offset:int;
      
      public var end:int;
      
      public function MemoryRange(param1:int, param2:int)
      {
         offset = param1;
         end = param2;
      }
      
      public function len() : int
      {
         return end - offset;
      }
   }
}
