package Ankama_Admin.adminMenu.items
{
   import Ankama_Admin.Api;
   
   public class BasicItem
   {
       
      
      private var _label:String;
      
      public var help:String;
      
      public var rank:int;
      
      public function BasicItem()
      {
         super();
      }
      
      public function getContextMenuItem(replaceParam:Object) : Object
      {
         return Api.contextMod.createContextMenuTitleObject(this.replace(this.label,replaceParam));
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function set label(l:String) : void
      {
         this._label = l;
      }
      
      protected function replace(txt:String, param:Object) : String
      {
         var search:* = null;
         for(search in param)
         {
            txt = txt.split("%" + search).join(param[search]);
         }
         return txt;
      }
   }
}
