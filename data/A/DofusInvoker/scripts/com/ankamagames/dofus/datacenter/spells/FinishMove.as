package com.ankamagames.dofus.datacenter.spells
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class FinishMove implements IDataCenter
   {
      
      public static const MODULE:String = "FinishMoves";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getFinishMoveById,getFinishMoves);
       
      
      public var id:int;
      
      public var duration:int;
      
      public var free:Boolean;
      
      public var nameId:uint;
      
      public var category:int;
      
      public var spellLevel:int;
      
      private var _name:String;
      
      public function FinishMove()
      {
         super();
      }
      
      public static function getFinishMoveById(id:int) : FinishMove
      {
         return GameData.getObject(MODULE,id) as FinishMove;
      }
      
      public static function getFinishMoves() : Array
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
      
      public function getSpellLevel() : SpellLevel
      {
         return SpellLevel.getLevelById(this.spellLevel);
      }
   }
}
