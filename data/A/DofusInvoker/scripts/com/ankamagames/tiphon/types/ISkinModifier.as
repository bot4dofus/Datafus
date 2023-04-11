package com.ankamagames.tiphon.types
{
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public interface ISkinModifier
   {
       
      
      function getModifiedSkin(param1:Skin, param2:String, param3:TiphonEntityLook) : String;
   }
}
