package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ActivitySuggestionsRequestAction extends AbstractAction implements Action
   {
       
      
      public var minLevel:int;
      
      public var maxLevel:int;
      
      public var areaId:int;
      
      public var activityCategoryId:int;
      
      public var nbCards:int;
      
      public function ActivitySuggestionsRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(minLevel:int, maxLevel:int, areaId:int, activityCategoryId:int, nbCards:int) : ActivitySuggestionsRequestAction
      {
         var a:ActivitySuggestionsRequestAction = new ActivitySuggestionsRequestAction(arguments);
         a.minLevel = minLevel;
         a.maxLevel = maxLevel;
         a.areaId = areaId;
         a.activityCategoryId = activityCategoryId;
         a.nbCards = nbCards;
         return a;
      }
   }
}
