package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   import flash.utils.Dictionary;
   
   public class ToggleShowUIAction extends AbstractAction implements Action
   {
       
      
      private var _beriliaInstance:Berilia;
      
      public function ToggleShowUIAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ToggleShowUIAction
      {
         return new ToggleShowUIAction(arguments);
      }
      
      public function toggleUIs() : void
      {
         this._beriliaInstance = Berilia.getInstance();
         if(Berilia.getInstance().hidenActiveUIs.length > 0)
         {
            this.unhide();
         }
         else
         {
            this.hide();
         }
      }
      
      public function unhide() : void
      {
         var uiList:Dictionary = null;
         var pop:String = null;
         uiList = Berilia.getInstance().uiList;
         while(Berilia.getInstance().hidenActiveUIs.length > 0)
         {
            pop = Berilia.getInstance().hidenActiveUIs.pop();
            if(uiList[pop])
            {
               if(uiList[pop].uiClass.hasOwnProperty("visible"))
               {
                  try
                  {
                     uiList[pop].uiClass.visible = true;
                  }
                  catch(e:ReferenceError)
                  {
                     uiList[pop].visible = true;
                  }
               }
               else
               {
                  uiList[pop].visible = true;
               }
            }
         }
      }
      
      private function hide() : void
      {
         var name:* = undefined;
         var uiList:Dictionary = Berilia.getInstance().uiList;
         for(name in uiList)
         {
            if((name as String).indexOf("tooltip_entity") == -1)
            {
               if((name as String).indexOf("gameMenu") == -1)
               {
                  if((name as String).indexOf("mapInfo") == -1)
                  {
                     if((name as String).indexOf("cartography") == -1)
                     {
                        if(uiList[name].visible)
                        {
                           uiList[name].visible = false;
                           Berilia.getInstance().hidenActiveUIs.push(name);
                        }
                     }
                  }
               }
            }
         }
      }
   }
}
