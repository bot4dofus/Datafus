package com.ankamagames.dofus.logic.game.fight.miscs
{
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.tiphon.types.AnimationModifierPriority;
   import com.ankamagames.tiphon.types.IAnimationModifier;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class CarrierAnimationModifier implements IAnimationModifier
   {
      
      private static var _self:CarrierAnimationModifier;
       
      
      public function CarrierAnimationModifier()
      {
         super();
      }
      
      public static function getInstance() : CarrierAnimationModifier
      {
         if(!_self)
         {
            _self = new CarrierAnimationModifier();
         }
         return _self;
      }
      
      public function get priority() : int
      {
         return AnimationModifierPriority.VERY_HIGH;
      }
      
      public function getModifiedAnimation(animation:String, look:TiphonEntityLook) : String
      {
         switch(animation)
         {
            case AnimationEnum.ANIM_STATIQUE:
               return AnimationEnum.ANIM_STATIQUE_CARRYING;
            case AnimationEnum.ANIM_MARCHE:
               return AnimationEnum.ANIM_MARCHE_CARRYING;
            case AnimationEnum.ANIM_COURSE:
               return AnimationEnum.ANIM_COURSE_CARRYING;
            case AnimationEnum.ANIM_HIT:
               return AnimationEnum.ANIM_HIT_CARRYING;
            case AnimationEnum.ANIM_MORT:
               return AnimationEnum.ANIM_MORT_CARRYING;
            case AnimationEnum.ANIM_TACLE:
               return AnimationEnum.ANIM_TACLE_CARRYING;
            default:
               if(animation.indexOf(AnimationEnum.ANIM_MARCHE) == 0)
               {
                  return AnimationEnum.ANIM_MARCHE_CARRYING;
               }
               if(animation.indexOf(AnimationEnum.ANIM_COURSE) == 0)
               {
                  return AnimationEnum.ANIM_COURSE_CARRYING;
               }
               return animation;
         }
      }
   }
}
