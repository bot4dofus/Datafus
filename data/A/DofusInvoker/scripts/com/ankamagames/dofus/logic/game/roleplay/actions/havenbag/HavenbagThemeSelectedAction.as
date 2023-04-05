package com.ankamagames.dofus.logic.game.roleplay.actions.havenbag
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HavenbagThemeSelectedAction extends AbstractAction implements Action
   {
       
      
      public var themeId:int;
      
      public function HavenbagThemeSelectedAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(themeId:int) : HavenbagThemeSelectedAction
      {
         var a:HavenbagThemeSelectedAction = new HavenbagThemeSelectedAction(arguments);
         a.themeId = themeId;
         return a;
      }
   }
}
