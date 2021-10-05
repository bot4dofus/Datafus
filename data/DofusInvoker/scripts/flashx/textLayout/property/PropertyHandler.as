package flashx.textLayout.property
{
   [ExcludeClass]
   public class PropertyHandler
   {
       
      
      public function PropertyHandler()
      {
         super();
      }
      
      public static function createRange(rest:Array) : Object
      {
         var range:Object = new Object();
         for(var i:int = 0; i < rest.length; i++)
         {
            range[rest[i]] = null;
         }
         return range;
      }
      
      public function get customXMLStringHandler() : Boolean
      {
         return false;
      }
      
      public function toXMLString(val:Object) : String
      {
         return null;
      }
      
      public function owningHandlerCheck(newVal:*) : *
      {
         return undefined;
      }
      
      public function setHelper(newVal:*) : *
      {
         return newVal;
      }
   }
}
