package com.ankamagames.dofus.datacenter.popup
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class PopupInformation implements IDataCenter
   {
      
      public static const MODULE:String = "PopupInformations";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getPopupInformationById,getPopupInformations);
       
      
      public var id:int;
      
      public var parentId:uint;
      
      public var titleId:uint;
      
      public var descriptionId:uint;
      
      public var illuName:String;
      
      public var buttons:Vector.<PopupButton>;
      
      public var criterion:String;
      
      public var cacheType:uint;
      
      public var autoTrigger:Boolean;
      
      private var _title:String;
      
      private var _description:String;
      
      public function PopupInformation()
      {
         super();
      }
      
      public static function getPopupInformationById(id:int) : PopupInformation
      {
         return GameData.getObject(MODULE,id) as PopupInformation;
      }
      
      public static function getPopupInformations() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get title() : String
      {
         if(!this._title)
         {
            this._title = I18n.getText(this.titleId);
         }
         return this._title;
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
