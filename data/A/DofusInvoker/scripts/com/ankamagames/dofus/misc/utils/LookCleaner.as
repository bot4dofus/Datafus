package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.dofus.datacenter.breeds.Breed;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class LookCleaner
   {
       
      
      public function LookCleaner()
      {
         super();
      }
      
      public static function clean(look:TiphonEntityLook) : TiphonEntityLook
      {
         var breed:Breed = null;
         var result:TiphonEntityLook = look.clone();
         var ridderLook:TiphonEntityLook = result.getSubEntity(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0);
         if(ridderLook)
         {
            if(ridderLook.getBone() == 2)
            {
               ridderLook.setBone(1);
            }
            return ridderLook;
         }
         for each(breed in Breed.getBreeds())
         {
            if(breed.creatureBonesId == result.getBone())
            {
               result.setBone(1);
               break;
            }
         }
         return result;
      }
   }
}
