package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.dofus.datacenter.appearance.SkinPosition;
   import com.ankamagames.tiphon.types.ISkinPartTransformProvider;
   import com.ankamagames.tiphon.types.Skin;
   
   public class SkinPartTransformProvider implements ISkinPartTransformProvider
   {
       
      
      public function SkinPartTransformProvider()
      {
         super();
      }
      
      public function init(skin:Skin) : void
      {
         var skinId:uint = 0;
         var sp:SkinPosition = null;
         var i:uint = 0;
         for each(skinId in skin.skinList)
         {
            sp = SkinPosition.getSkinPositionById(skinId);
            if(sp)
            {
               for(i = 0; i < sp.skin.length; i++)
               {
                  skin.addTransform(sp.clip[i],sp.skin[i],sp.transformation[i]);
               }
            }
         }
      }
   }
}
