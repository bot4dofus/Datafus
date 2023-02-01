package com.ankamagames.atouin.utils.map
{
   public function getMapIdFromCoord(worldId:int, x:int, y:int) : Number
   {
      var worldIdMax:* = 2 << 12;
      var mapCoordMax:* = 2 << 8;
      if(x > mapCoordMax || y > mapCoordMax || worldId > worldIdMax)
      {
         return -1;
      }
      var newWorldId:* = worldId & 4095;
      var newX:* = Math.abs(x) & 255;
      if(x < 0)
      {
         newX |= 256;
      }
      var newY:* = Math.abs(y) & 255;
      if(y < 0)
      {
         newY |= 256;
      }
      return newWorldId << 18 | (newX << 9 | newY);
   }
}
