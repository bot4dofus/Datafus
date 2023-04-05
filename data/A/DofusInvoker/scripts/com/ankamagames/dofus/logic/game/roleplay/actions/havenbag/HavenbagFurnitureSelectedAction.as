package com.ankamagames.dofus.logic.game.roleplay.actions.havenbag
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HavenbagFurnitureSelectedAction extends AbstractAction implements Action
   {
       
      
      public var furnitureTypeId:uint;
      
      public function HavenbagFurnitureSelectedAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(furnitureTypeId:uint) : HavenbagFurnitureSelectedAction
      {
         var a:HavenbagFurnitureSelectedAction = new HavenbagFurnitureSelectedAction(arguments);
         a.furnitureTypeId = furnitureTypeId;
         return a;
      }
   }
}
