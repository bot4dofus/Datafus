package Ankama_Admin.adminMenu.items
{
   import flash.utils.Dictionary;
   
   public class PrepareCommanditem extends SendCommandItem
   {
       
      
      public function PrepareCommanditem(cmd:String, delay:int = 0, repeat:int = 1, localizationParameters:Dictionary = null)
      {
         super(cmd,delay,repeat,localizationParameters);
      }
      
      override public function getcallbackArgs(replaceParam:Object) : Array
      {
         return [replace(command,replaceParam),false,true];
      }
   }
}
