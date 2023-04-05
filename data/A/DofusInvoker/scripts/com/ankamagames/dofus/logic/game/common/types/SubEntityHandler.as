package com.ankamagames.dofus.logic.game.common.types
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.types.ISubEntityHandler;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class SubEntityHandler implements ISubEntityHandler
   {
      
      public static var instance:ISubEntityHandler = new SubEntityHandler();
       
      
      public function SubEntityHandler()
      {
         super();
      }
      
      public function onSubEntityAdded(target:TiphonSprite, look:TiphonEntityLook, category:uint, slot:uint) : Boolean
      {
         if(category != SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET_FOLLOWER)
         {
            return true;
         }
         var fef:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(fef)
         {
            if(target.look.getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET,0) == null)
            {
               target.look.addSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET,0,look);
            }
            return false;
         }
         return false;
      }
   }
}
