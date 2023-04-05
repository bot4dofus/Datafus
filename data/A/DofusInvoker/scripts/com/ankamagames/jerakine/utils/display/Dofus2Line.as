package com.ankamagames.jerakine.utils.display
{
   import mapTools.MapTools;
   import mapTools.MapToolsConfig;
   
   public class Dofus2Line
   {
      
      public static var hasInitMapTools:Boolean = false;
       
      
      public function Dofus2Line()
      {
         super();
      }
      
      public static function getLine(startCellId:uint, endCellId:uint) : Array
      {
         if(!hasInitMapTools)
         {
            MapTools.init(MapToolsConfig.DOFUS2_CONFIG);
            hasInitMapTools = true;
         }
         return MapTools.getCellsCoordBetween(startCellId,endCellId);
      }
   }
}
