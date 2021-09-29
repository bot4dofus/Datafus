package com.ankamagames.tiphon.types
{
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public interface ISubEntityHandler
   {
       
      
      function onSubEntityAdded(param1:TiphonSprite, param2:TiphonEntityLook, param3:uint, param4:uint) : Boolean;
   }
}
