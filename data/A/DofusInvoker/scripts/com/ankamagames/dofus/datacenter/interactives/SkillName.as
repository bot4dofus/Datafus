package com.ankamagames.dofus.datacenter.interactives
{
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SkillName implements IDataCenter
   {
      
      public static const MODULE:String = "SkillNames";
       
      
      public var id:int;
      
      public var nameId:uint;
      
      private var _name:String;
      
      public function SkillName()
      {
         super();
      }
      
      public static function getSkillNameById(id:int) : SkillName
      {
         return GameData.getObject(MODULE,id) as SkillName;
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
