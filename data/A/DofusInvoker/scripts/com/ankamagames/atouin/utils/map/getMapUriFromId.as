package com.ankamagames.atouin.utils.map
{
   import com.ankamagames.atouin.Atouin;
   
   public function getMapUriFromId(mapId:Number) : String
   {
      return Atouin.getInstance().options.getOption("mapsPath") + mapId % 10 + "/" + mapId + ".dlm";
   }
}
