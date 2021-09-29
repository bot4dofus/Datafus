package Ankama_Admin.adminMenu.items
{
   import Ankama_Admin.Api;
   
   public class SeparatorItem extends BasicItem
   {
       
      
      private var _label:String;
      
      public function SeparatorItem()
      {
         super();
      }
      
      override public function getContextMenuItem(replaceParam:Object) : Object
      {
         return Api.contextMod.createContextMenuSeparatorObject();
      }
      
      override public function get label() : String
      {
         return "";
      }
      
      override public function set label(l:String) : void
      {
      }
      
      override protected function replace(txt:String, param:Object) : String
      {
         return "";
      }
   }
}
