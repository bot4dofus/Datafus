package flashx.textLayout.property
{
   [ExcludeClass]
   public class StringPropertyHandler extends PropertyHandler
   {
       
      
      public function StringPropertyHandler()
      {
         super();
      }
      
      override public function owningHandlerCheck(newVal:*) : *
      {
         return newVal is String ? newVal : undefined;
      }
   }
}
