package mx.core
{
   import flash.display.SimpleButton;
   import mx.utils.NameUtil;
   
   use namespace mx_internal;
   
   public class FlexSimpleButton extends SimpleButton
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
       
      
      public function FlexSimpleButton()
      {
         super();
         try
         {
            name = NameUtil.createUniqueName(this);
         }
         catch(e:Error)
         {
         }
      }
      
      override public function toString() : String
      {
         return NameUtil.displayObjectToString(this);
      }
   }
}
