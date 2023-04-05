package com.ankamagames.dofus.types.entities
{
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.tiphon.types.AnimationModifierPriority;
   import com.ankamagames.tiphon.types.IAnimationModifier;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.utils.getQualifiedClassName;
   
   public class UnderWaterAnimationModifier implements IAnimationModifier
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(UnderWaterAnimationModifier));
       
      
      public function UnderWaterAnimationModifier()
      {
         super();
      }
      
      public function get priority() : int
      {
         return AnimationModifierPriority.HIGH;
      }
      
      public function getModifiedAnimation(pAnimation:String, pLook:TiphonEntityLook) : String
      {
         var boneId:uint = pLook.getBone();
         if(boneId != 1)
         {
            return pAnimation;
         }
         switch(pAnimation)
         {
            case AnimationEnum.ANIM_MARCHE:
               return AnimationEnum.ANIM_MARCHE_UNDERWATER;
            case AnimationEnum.ANIM_COURSE:
               return AnimationEnum.ANIM_COURSE_UNDERWATER;
            default:
               return pAnimation;
         }
      }
   }
}
