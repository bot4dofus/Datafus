package Ankama_ContextMenu.contextMenu
{
   public class ContextMenuPictureLabelItem extends ContextMenuItem
   {
       
      
      public var uri:String;
      
      public var txSize:int;
      
      public var pictureAfterLaber:Boolean;
      
      public function ContextMenuPictureLabelItem(uri:String, label:String, textureSize:int, after:Boolean, callback:Function = null, callbackArgs:Array = null, disabled:Boolean = false, child:Array = null, selected:Boolean = false, radioStyle:Boolean = false, help:String = null, forceCloseOnSelect:Boolean = false, helpDelay:uint = 1000)
      {
         super(label,callback,callbackArgs,disabled,child,selected,radioStyle,help,forceCloseOnSelect,helpDelay);
         this.uri = uri;
         this.txSize = textureSize;
         this.pictureAfterLaber = after;
      }
   }
}
