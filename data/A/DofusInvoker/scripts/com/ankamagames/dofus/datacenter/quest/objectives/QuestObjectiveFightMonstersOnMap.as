package com.ankamagames.dofus.datacenter.quest.objectives
{
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.quest.QuestObjective;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   
   public class QuestObjectiveFightMonstersOnMap extends QuestObjective implements IDataCenter
   {
       
      
      private var _monster:Monster;
      
      private var _mapDescriptionText:String;
      
      private var _text:String;
      
      public function QuestObjectiveFightMonstersOnMap()
      {
         super();
      }
      
      public function get monsterId() : uint
      {
         if(!parameters)
         {
            return 0;
         }
         return parameters[0];
      }
      
      public function get monster() : Monster
      {
         if(!this._monster)
         {
            this._monster = Monster.getMonsterById(this.monsterId);
         }
         return this._monster;
      }
      
      public function get quantity() : uint
      {
         if(!parameters)
         {
            return 0;
         }
         return parameters[1];
      }
      
      public function get mapDescriptionTextId() : uint
      {
         if(!parameters)
         {
            return 0;
         }
         return parameters[3];
      }
      
      public function get mapDescriptionText() : String
      {
         if(!this._mapDescriptionText)
         {
            this._mapDescriptionText = I18n.getText(this.mapDescriptionTextId);
         }
         return this._mapDescriptionText;
      }
      
      override public function get text() : String
      {
         if(!this._text)
         {
            this._text = PatternDecoder.getDescription(type.name,["{chatmonster," + this.monsterId + "}",this.quantity,this.mapDescriptionText]);
         }
         return this._text;
      }
   }
}
