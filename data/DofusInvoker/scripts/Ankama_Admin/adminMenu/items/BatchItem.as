package Ankama_Admin.adminMenu.items
{
   import Ankama_Admin.Api;
   
   public class BatchItem extends ExecItem
   {
       
      
      public var subItem:Array;
      
      public function BatchItem(delay:int = 0, repeat:int = 1)
      {
         this.subItem = [];
         super(delay,repeat);
      }
      
      override public function getContextMenuItem(replaceParam:Object) : Object
      {
         return Api.contextMod.createContextMenuItemObject(replace(label,replaceParam),this.execCmdCallback,[replaceParam],false,null,false,true,help);
      }
      
      private function execCmdCallback(replaceParam:Object) : void
      {
         var cmd:ExecItem = null;
         for each(cmd in this.subItem)
         {
            if(cmd)
            {
               cmd.callbackFunction.apply(null,cmd.getcallbackArgs(replaceParam));
            }
         }
      }
      
      override public function get callbackFunction() : Function
      {
         return this.execCmdCallback;
      }
      
      override public function getcallbackArgs(replaceParam:Object) : Array
      {
         return [replaceParam];
      }
   }
}
