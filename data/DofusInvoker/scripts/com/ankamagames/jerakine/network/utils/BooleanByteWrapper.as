package com.ankamagames.jerakine.network.utils
{
   public class BooleanByteWrapper
   {
       
      
      public function BooleanByteWrapper()
      {
         super();
      }
      
      public static function setFlag(a:uint, pos:uint, b:Boolean) : uint
      {
         switch(pos)
         {
            case 0:
               if(b)
               {
                  a |= 1;
               }
               else
               {
                  a &= 255 - 1;
               }
               break;
            case 1:
               if(b)
               {
                  a |= 2;
               }
               else
               {
                  a &= 255 - 2;
               }
               break;
            case 2:
               if(b)
               {
                  a |= 4;
               }
               else
               {
                  a &= 255 - 4;
               }
               break;
            case 3:
               if(b)
               {
                  a |= 8;
               }
               else
               {
                  a &= 255 - 8;
               }
               break;
            case 4:
               if(b)
               {
                  a |= 16;
               }
               else
               {
                  a &= 255 - 16;
               }
               break;
            case 5:
               if(b)
               {
                  a |= 32;
               }
               else
               {
                  a &= 255 - 32;
               }
               break;
            case 6:
               if(b)
               {
                  a |= 64;
               }
               else
               {
                  a &= 255 - 64;
               }
               break;
            case 7:
               if(b)
               {
                  a |= 128;
               }
               else
               {
                  a &= 255 - 128;
               }
               break;
            default:
               throw new Error("Bytebox overflow.");
         }
         return a;
      }
      
      public static function getFlag(a:uint, pos:uint) : Boolean
      {
         switch(pos)
         {
            case 0:
               return (a & 1) != 0;
            case 1:
               return (a & 2) != 0;
            case 2:
               return (a & 4) != 0;
            case 3:
               return (a & 8) != 0;
            case 4:
               return (a & 16) != 0;
            case 5:
               return (a & 32) != 0;
            case 6:
               return (a & 64) != 0;
            case 7:
               return (a & 128) != 0;
            default:
               throw new Error("Bytebox overflow.");
         }
      }
   }
}
