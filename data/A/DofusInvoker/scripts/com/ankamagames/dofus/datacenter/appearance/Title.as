package com.ankamagames.dofus.datacenter.appearance
{
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Title implements IDataCenter
   {
      
      public static const MODULE:String = "Titles";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getTitleById,getAllTitle);
       
      
      public var id:int;
      
      public var nameMaleId:uint;
      
      public var nameFemaleId:uint;
      
      public var visible:Boolean;
      
      public var categoryId:int;
      
      private var _nameM:String;
      
      private var _nameF:String;
      
      public function Title()
      {
         super();
      }
      
      public static function getTitleById(id:int) : Title
      {
         return GameData.getObject(MODULE,id) as Title;
      }
      
      public static function getAllTitle() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get name() : String
      {
         if(!PlayedCharacterManager.getInstance() || !PlayedCharacterManager.getInstance().infos || PlayedCharacterManager.getInstance().infos.sex == 0)
         {
            if(!this._nameM)
            {
               this._nameM = I18n.getText(this.nameMaleId);
            }
            return this._nameM;
         }
         if(!this._nameF)
         {
            this._nameF = I18n.getText(this.nameFemaleId);
         }
         return this._nameF;
      }
      
      public function get nameMale() : String
      {
         if(!this._nameM)
         {
            this._nameM = I18n.getText(this.nameMaleId);
         }
         return this._nameM;
      }
      
      public function get nameFemale() : String
      {
         if(!this._nameF)
         {
            this._nameF = I18n.getText(this.nameFemaleId);
         }
         return this._nameF;
      }
   }
}
