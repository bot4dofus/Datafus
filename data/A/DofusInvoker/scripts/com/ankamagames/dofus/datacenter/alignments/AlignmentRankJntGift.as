package com.ankamagames.dofus.datacenter.alignments
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class AlignmentRankJntGift implements IDataCenter
   {
      
      public static const MODULE:String = "AlignmentRankJntGift";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AlignmentRankJntGift));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getAlignmentRankJntGiftById,getAlignmentRankJntGifts);
       
      
      public var id:int;
      
      public var gifts:Vector.<int>;
      
      public var levels:Vector.<int>;
      
      public function AlignmentRankJntGift()
      {
         super();
      }
      
      public static function getAlignmentRankJntGiftById(id:int) : AlignmentRankJntGift
      {
         return GameData.getObject(MODULE,id) as AlignmentRankJntGift;
      }
      
      public static function getAlignmentRankJntGifts() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
