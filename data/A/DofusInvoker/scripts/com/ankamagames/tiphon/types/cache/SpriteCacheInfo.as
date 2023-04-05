package com.ankamagames.tiphon.types.cache
{
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class SpriteCacheInfo
   {
       
      
      public var sprite:TiphonSprite;
      
      public var look:TiphonEntityLook;
      
      public function SpriteCacheInfo(tiphonSprite:TiphonSprite, tiphonEntityLook:TiphonEntityLook)
      {
         super();
         this.sprite = tiphonSprite;
         this.look = tiphonEntityLook;
      }
   }
}
