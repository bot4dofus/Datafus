package org.flintparticles.common.utils
{
   public function construct(type:Class, parameters:Array) : *
   {
      switch(parameters.length)
      {
         case 0:
            return new type();
         case 1:
            return new type(parameters[0]);
         case 2:
            return new type(parameters[0],parameters[1]);
         case 3:
            return new type(parameters[0],parameters[1],parameters[2]);
         case 4:
            return new type(parameters[0],parameters[1],parameters[2],parameters[3]);
         case 5:
            return new type(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4]);
         case 6:
            return new type(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5]);
         case 7:
            return new type(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6]);
         case 8:
            return new type(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7]);
         case 9:
            return new type(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8]);
         case 10:
            return new type(parameters[0],parameters[1],parameters[2],parameters[3],parameters[4],parameters[5],parameters[6],parameters[7],parameters[8],parameters[9]);
         default:
            return null;
      }
   }
}
