package com.ankamagames.dofus.internalDatacenter.conquest
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.geom.ColorTransform;
   
   public class KothColorsEnum implements IDataCenter
   {
      
      public static const COLOR_DEFENDER_AVA_BLUE:ColorTransform = new ColorTransform(0.4,0.75,0.96);
      
      public static const COLOR_ATTACKER_AVA_GREEN:ColorTransform = new ColorTransform(0.66,0.97,0.11);
      
      public static const COLOR_ATTACKER_AVA_RED:ColorTransform = new ColorTransform(0.92,0,0);
      
      public static const COLOR_PROBATION_TIME:ColorTransform = new ColorTransform(0.92,0.76,0);
       
      
      public function KothColorsEnum()
      {
         super();
      }
   }
}
