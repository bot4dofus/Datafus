package Ankama_ContextMenu.contextMenu
{
   public class ContextMenuItem
   {
       
      
      public var label:String;
      
      public var callback:Function;
      
      public var callbackArgs:Array;
      
      public var disabled:Boolean;
      
      public var child:Array;
      
      public var selected:Boolean;
      
      public var radioStyle:Boolean;
      
      public var help:String;
      
      public var forceCloseOnSelect:Boolean;
      
      public var helpDelay:uint;
      
      public var disabledCallback:Function;
      
      public var disabledCallbackArgs:Array;
      
      public function ContextMenuItem(label:String, callback:Function = null, callbackArgs:Array = null, disabled:Boolean = false, child:Array = null, selected:Boolean = false, radioStyle:Boolean = true, help:String = null, forceCloseOnSelect:Boolean = false, helpDelay:uint = 1000)
      {
         super();
         this.label = label;
         this.callback = callback;
         this.callbackArgs = callbackArgs;
         this.disabled = disabled;
         this.child = child;
         this.selected = selected;
         this.radioStyle = radioStyle;
         this.help = help;
         this.forceCloseOnSelect = forceCloseOnSelect;
         this.helpDelay = helpDelay;
      }
      
      public function addDisabledCallback(pCallback:Function, pCallbackArgs:Array = null) : void
      {
         if(this.disabled)
         {
            this.disabledCallback = pCallback;
            this.disabledCallbackArgs = pCallbackArgs;
         }
      }
   }
}
