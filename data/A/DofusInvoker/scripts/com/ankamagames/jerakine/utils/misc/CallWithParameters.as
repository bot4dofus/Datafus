package com.ankamagames.jerakine.utils.misc
{
   public class CallWithParameters
   {
       
      
      public function CallWithParameters()
      {
         super();
      }
      
      public static function call(method:Function, parameters:Array) : void
      {
         if(!parameters || !parameters.length)
         {
            method();
            return;
         }
         switch(parameters.length)
         {
            case 1:
               method(parameters[0]);
               break;
            case 2:
               method(parameters[0],parameters[1]);
               break;
            case 3:
               method(parameters[0],parameters[1],parameters[2]);
               break;
            case 4:
               method(parameters[0],parameters[1],parameters[2],parameters[3]);
               break;
            case 5:
               method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4]);
               break;
            case 6:
               method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5]);
               break;
            case 7:
               method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6]);
               break;
            case 8:
               method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7]);
               break;
            case 9:
               method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8]);
               break;
            case 10:
               method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8],parameters[9]);
               break;
            case 11:
               method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8],parameters[9],parameters[10]);
               break;
            case 12:
               method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8],parameters[9],parameters[10],parameters[11]);
               break;
            case 13:
               method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8],parameters[9],parameters[10],parameters[11],parameters[12]);
               break;
            case 14:
               method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8],parameters[9],parameters[10],parameters[11],parameters[12],parameters[13]);
               break;
            case 15:
               method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8],parameters[9],parameters[10],parameters[11],parameters[12],parameters[13],parameters[14]);
         }
      }
      
      public static function callR(method:Function, parameters:Array) : *
      {
         if(!parameters || !parameters.length)
         {
            return method();
         }
         switch(parameters.length)
         {
            case 1:
               return method(parameters[0]);
            case 2:
               return method(parameters[0],parameters[1]);
            case 3:
               return method(parameters[0],parameters[1],parameters[2]);
            case 4:
               return method(parameters[0],parameters[1],parameters[2],parameters[3]);
            case 5:
               return method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4]);
            case 6:
               return method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5]);
            case 7:
               return method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6]);
            case 8:
               return method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7]);
            case 9:
               return method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8]);
            case 10:
               return method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8],parameters[9]);
            case 11:
               return method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8],parameters[9],parameters[10]);
            case 12:
               return method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8],parameters[9],parameters[10],parameters[11]);
            case 13:
               return method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8],parameters[9],parameters[10],parameters[11],parameters[12]);
            case 14:
               return method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8],parameters[9],parameters[10],parameters[11],parameters[12],parameters[13]);
            case 15:
               return method(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8],parameters[9],parameters[10],parameters[11],parameters[12],parameters[13],parameters[14]);
            default:
               return;
         }
      }
      
      public static function callConstructor(callClass:Class, parameters:Array) : *
      {
         if(!parameters || !parameters.length)
         {
            return new callClass();
         }
         switch(parameters.length)
         {
            case 1:
               return new callClass(parameters[0]);
            case 2:
               return new callClass(parameters[0],parameters[1]);
            case 3:
               return new callClass(parameters[0],parameters[1],parameters[2]);
            case 4:
               return new callClass(parameters[0],parameters[1],parameters[2],parameters[3]);
            case 5:
               return new callClass(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4]);
            case 6:
               return new callClass(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5]);
            case 7:
               return new callClass(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6]);
            case 8:
               return new callClass(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7]);
            case 9:
               return new callClass(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8]);
            case 10:
               return new callClass(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8],parameters[9]);
            case 11:
               return new callClass(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8],parameters[9],parameters[10]);
            case 12:
               return new callClass(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8],parameters[9],parameters[10],parameters[11]);
            case 13:
               return new callClass(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8],parameters[9],parameters[10],parameters[11],parameters[12]);
            case 14:
               return new callClass(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8],parameters[9],parameters[10],parameters[11],parameters[12],parameters[13]);
            case 15:
               return new callClass(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8],parameters[9],parameters[10],parameters[11],parameters[12],parameters[13],parameters[14]);
            default:
               return;
         }
      }
   }
}
