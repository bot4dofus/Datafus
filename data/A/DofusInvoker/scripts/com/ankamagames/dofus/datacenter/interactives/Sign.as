package com.ankamagames.dofus.datacenter.interactives
{
   import com.ankamagames.dofus.datacenter.world.Hint;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Sign implements IDataCenter
   {
      
      public static const MODULE:String = "Signs";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getSignById,getSigns);
       
      
      public var id:int;
      
      public var params:String;
      
      public var skillId:int;
      
      public var textKey:uint;
      
      private var _hintOrSubAreaId:uint;
      
      private var _signText:String;
      
      public function Sign()
      {
         super();
      }
      
      public static function getSignById(id:int) : Sign
      {
         return GameData.getObject(MODULE,id) as Sign;
      }
      
      public static function getSigns() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get signText() : String
      {
         if(!this._signText)
         {
            this._hintOrSubAreaId = parseInt(this.params.split(",")[0]);
            switch(this.skillId)
            {
               case DataEnum.SKILL_SIGN_FREE_TEXT:
                  this._signText = I18n.getText(this.textKey);
                  break;
               case DataEnum.SKILL_SIGN_HINT:
                  this._signText = Hint.getHintById(this._hintOrSubAreaId).name;
                  break;
               case DataEnum.SKILL_SIGN_SUBAREA:
                  this._signText = SubArea.getSubAreaById(this._hintOrSubAreaId).name;
            }
         }
         return this._signText;
      }
   }
}
