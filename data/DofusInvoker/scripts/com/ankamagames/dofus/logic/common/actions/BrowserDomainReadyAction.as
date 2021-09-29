package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.berilia.components.WebBrowser;
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BrowserDomainReadyAction extends AbstractAction implements Action
   {
       
      
      public var browser:WebBrowser;
      
      public function BrowserDomainReadyAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(browser:WebBrowser) : BrowserDomainReadyAction
      {
         var a:BrowserDomainReadyAction = new BrowserDomainReadyAction(arguments);
         a.browser = browser;
         return a;
      }
   }
}
