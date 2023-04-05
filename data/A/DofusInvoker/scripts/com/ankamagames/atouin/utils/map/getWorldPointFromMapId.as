package com.ankamagames.atouin.utils.map
{
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   
   public function getWorldPointFromMapId(nMapId:Number) : WorldPoint
   {
      var worldId:uint = (nMapId & 1073479680) >> 18;
      var x:* = nMapId >> 9 & 511;
      var y:* = nMapId & 511;
      if((x & 256) == 256)
      {
         x = int(-(x & 255));
      }
      if((y & 256) == 256)
      {
         y = int(-(y & 255));
      }
      return WorldPoint.fromCoords(worldId,x,y);
   }
}
