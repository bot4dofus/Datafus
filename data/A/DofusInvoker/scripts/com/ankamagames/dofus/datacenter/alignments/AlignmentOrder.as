package com.ankamagames.dofus.datacenter.alignments
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class AlignmentOrder implements IDataCenter
   {
      
      public static const MODULE:String = "AlignmentOrder";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AlignmentOrder));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getAlignmentOrderById,getAlignmentOrders);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var sideId:uint;
      
      private var _name:String;
      
      public function AlignmentOrder()
      {
         super();
      }
      
      public static function getAlignmentOrderById(id:int) : AlignmentOrder
      {
         return GameData.getObject(MODULE,id) as AlignmentOrder;
      }
      
      public static function getAlignmentOrders() : Array
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
