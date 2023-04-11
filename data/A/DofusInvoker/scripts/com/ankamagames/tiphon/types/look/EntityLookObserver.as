package com.ankamagames.tiphon.types.look
{
   public interface EntityLookObserver
   {
       
      
      function boneChanged(param1:TiphonEntityLook) : void;
      
      function skinsChanged(param1:TiphonEntityLook) : void;
      
      function colorsChanged(param1:TiphonEntityLook) : void;
      
      function scalesChanged(param1:TiphonEntityLook) : void;
      
      function subEntitiesChanged(param1:TiphonEntityLook) : void;
   }
}
