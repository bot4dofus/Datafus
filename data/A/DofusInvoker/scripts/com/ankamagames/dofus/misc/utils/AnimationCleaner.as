package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   
   public class AnimationCleaner
   {
       
      
      public function AnimationCleaner()
      {
         super();
      }
      
      public static function cleanBones1AnimName(bones:uint, anim:String = null) : String
      {
         var name:String = null;
         switch(bones)
         {
            case 1:
               if(anim)
               {
                  if(anim.length > 12 && anim.slice(0,12) == AnimationEnum.ANIM_STATIQUE && (anim.length < 15 || anim.slice(12,15) != "_to"))
                  {
                     return AnimationEnum.ANIM_STATIQUE;
                  }
               }
         }
         return anim;
      }
   }
}
