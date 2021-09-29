package Ankama_Admin.adminMenu.items
{
   import Ankama_Admin.Admin;
   
   public class ReloadXmlItem extends SendCommandItem
   {
       
      
      public function ReloadXmlItem()
      {
         super(null);
      }
      
      override public function get callbackFunction() : Function
      {
         return Admin.getInstance().reloadXml;
      }
      
      override public function getcallbackArgs(replaceParam:Object) : Array
      {
         return [];
      }
   }
}
