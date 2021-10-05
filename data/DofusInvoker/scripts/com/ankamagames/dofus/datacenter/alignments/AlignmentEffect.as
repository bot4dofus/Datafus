package com.ankamagames.dofus.datacenter.alignments
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class AlignmentEffect implements IDataCenter
   {
      
      public static const MODULE:String = "AlignmentEffect";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AlignmentEffect));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getAlignmentEffectById,getAlignmentEffects);
       
      
      public var id:int;
      
      public var characteristicId:uint;
      
      public var descriptionId:uint;
      
      private var _description:String;
      
      public function AlignmentEffect()
      {
         super();
      }
      
      public static function getAlignmentEffectById(id:int) : AlignmentEffect
      {
         return GameData.getObject(MODULE,id) as AlignmentEffect;
      }
      
      public static function getAlignmentEffects() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get description() : String
      {
         if(!this._description)
         {
            this._description = I18n.getText(this.descriptionId);
         }
         return this._description;
      }
   }
}
