package com.ankamagames.atouin.types.miscs
{
   public class HavenbagPackedInfos
   {
       
      
      public var furnitureTypeIds:Vector.<int>;
      
      public var furnitureCellIds:Vector.<uint>;
      
      public var furnitureOrientations:Vector.<uint>;
      
      public function HavenbagPackedInfos()
      {
         this.furnitureTypeIds = new Vector.<int>();
         this.furnitureCellIds = new Vector.<uint>();
         this.furnitureOrientations = new Vector.<uint>();
         super();
      }
      
      public static function createFromSharedObject(soData:Object) : HavenbagPackedInfos
      {
         var infos:HavenbagPackedInfos = new HavenbagPackedInfos();
         infos.furnitureTypeIds = soData.furnitureTypeIds;
         infos.furnitureCellIds = soData.furnitureCellIds;
         infos.furnitureOrientations = soData.furnitureOrientations;
         return infos;
      }
   }
}
