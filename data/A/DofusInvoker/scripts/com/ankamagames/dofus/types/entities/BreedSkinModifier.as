package com.ankamagames.dofus.types.entities
{
   import com.ankamagames.tiphon.types.ISkinModifier;
   import com.ankamagames.tiphon.types.Skin;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class BreedSkinModifier implements ISkinModifier
   {
       
      
      public function BreedSkinModifier()
      {
         super();
      }
      
      public function getModifiedSkin(skin:Skin, requestedPart:String, look:TiphonEntityLook) : String
      {
         var name:String = null;
         var id:String = null;
         var newPart:String = null;
         var i:int = 0;
         if(!look || !look.skins || !requestedPart || !skin)
         {
            return requestedPart;
         }
         var separatorIndex:int = requestedPart.indexOf("_");
         if(separatorIndex != -1)
         {
            name = requestedPart.substring(0,separatorIndex + 1);
            id = requestedPart.substring(separatorIndex);
            for(i = look.skins.length - 1; i >= 0; i--)
            {
               newPart = name + look.skins[i] + id;
               if(skin.getPart(newPart) != null)
               {
                  return newPart;
               }
            }
         }
         return requestedPart;
      }
   }
}
