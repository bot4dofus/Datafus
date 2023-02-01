package com.ankamagames.tiphon.types
{
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.display.DisplayObjectContainer;
   
   public class TiphonUtility
   {
       
      
      public function TiphonUtility()
      {
         super();
      }
      
      public static function getLookWithoutMount(look:TiphonEntityLook) : TiphonEntityLook
      {
         var boneId:int = 0;
         var ridderLook:TiphonEntityLook = look.getSubEntity(2,0);
         if(ridderLook)
         {
            boneId = ridderLook.getBone();
            if(boneId == 1084)
            {
               ridderLook.setBone(44);
            }
            else if(boneId == 1068)
            {
               ridderLook.setBone(113);
            }
            else if(boneId == 1202)
            {
               ridderLook.setBone(453);
            }
            else if(boneId == 1575 || boneId == 1576 || boneId == 2)
            {
               ridderLook.setBone(1);
            }
            else if(boneId == 2456)
            {
               ridderLook.setBone(1107);
            }
            return ridderLook;
         }
         return look;
      }
      
      public static function getEntityWithoutMount(ent:TiphonSprite) : DisplayObjectContainer
      {
         if(ent == null)
         {
            return null;
         }
         var rider:DisplayObjectContainer = ent.getSubEntitySlot(2,0);
         return rider == null ? ent : rider;
      }
      
      public static function getFlipDirection(direction:int) : uint
      {
         if(direction == 0)
         {
            return 4;
         }
         if(direction == 1)
         {
            return 3;
         }
         if(direction == 7)
         {
            return 5;
         }
         if(direction == 4)
         {
            return 0;
         }
         if(direction == 3)
         {
            return 1;
         }
         if(direction == 5)
         {
            return 7;
         }
         return direction;
      }
   }
}
