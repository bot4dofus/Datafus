package com.ankamagames.dofus.datacenter.interactives
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Interactive implements IDataCenter
   {
      
      public static const MODULE:String = "Interactives";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getInteractiveById,getInteractives);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var actionId:int;
      
      public var displayTooltip:Boolean;
      
      private var _name:String;
      
      public function Interactive()
      {
         super();
      }
      
      public static function getInteractiveById(id:int) : Interactive
      {
         return GameData.getObject(MODULE,id) as Interactive;
      }
      
      public static function getInteractives() : Array
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
