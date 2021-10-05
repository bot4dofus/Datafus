package flashx.textLayout.property
{
   [ExcludeClass]
   public class UndefinedPropertyHandler extends PropertyHandler
   {
       
      
      public function UndefinedPropertyHandler()
      {
         super();
      }
      
      override public function owningHandlerCheck(newVal:*) : *
      {
         return newVal === null || newVal === undefined ? true : undefined;
      }
      
      override public function setHelper(newVal:*) : *
      {
         return undefined;
      }
   }
}
