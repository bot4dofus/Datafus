package Ankama_ContextMenu.contextMenu
{
   public class ContextMenuPictureItem extends ContextMenuItem
   {
       
      
      public var uri:String;
      
      public function ContextMenuPictureItem(uri:String, callback:Function = null, callbackArgs:Array = null, disabled:Boolean = false, child:Array = null, selected:Boolean = false, radioStyle:Boolean = false, help:String = null, forceCloseOnSelect:Boolean = false, helpDelay:uint = 1000)
      {
         super("",callback,callbackArgs,disabled,child,selected,radioStyle,help,forceCloseOnSelect,helpDelay);
         this.uri = uri;
      }
   }
}
