package com.ankamagames.dofus.datacenter.alignments
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class AlignmentGift implements IDataCenter
   {
      
      public static const MODULE:String = "AlignmentGift";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AlignmentGift));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getAlignmentGiftById,getAlignmentGifts);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      private var _name:String;
      
      public function AlignmentGift()
      {
         super();
      }
      
      public static function getAlignmentGiftById(id:int) : AlignmentGift
      {
         return GameData.getObject(MODULE,id) as AlignmentGift;
      }
      
      public static function getAlignmentGifts() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
   }
}
