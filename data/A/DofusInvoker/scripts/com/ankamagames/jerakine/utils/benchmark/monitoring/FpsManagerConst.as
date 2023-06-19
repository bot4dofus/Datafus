package com.ankamagames.jerakine.utils.benchmark.monitoring
{
   public class FpsManagerConst
   {
      
      public static const BOX_WIDTH:int = 250;
      
      public static const BOX_HEIGHT:int = 60;
      
      public static const BOX_COLOR:uint = 0;
      
      public static const BOX_FILTER_WIDTH:int = 125;
      
      public static const BOX_BORDER:int = 1;
      
      public static const PADDING_LEFT:int = 5;
      
      public static const PADDING_TOP:int = 5;
      
      public static var PLAYER_VERSION:int;
      
      public static const SPECIAL_GRAPH:Array = [{
         "name":"frames",
         "color":16777215
      },{
         "name":"fps_ref",
         "color":13325419
      }];
      
      public static const SPECIAL_GRAPH_POS:int = 50;
       
      
      public function FpsManagerConst()
      {
         super();
      }
   }
}
