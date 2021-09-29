package Ankama_ContextMenu.contextMenu
{
   public class ContextMenuTitle
   {
       
      
      public var label:String;
      
      public var parseText:Boolean;
      
      public function ContextMenuTitle(label:String, parseText:Boolean)
      {
         super();
         this.label = label;
         this.parseText = parseText;
      }
   }
}
