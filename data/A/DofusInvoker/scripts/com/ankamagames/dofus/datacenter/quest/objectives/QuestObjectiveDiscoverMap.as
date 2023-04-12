package com.ankamagames.dofus.datacenter.quest.objectives
{
   import com.ankamagames.dofus.datacenter.quest.QuestObjective;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   
   public class QuestObjectiveDiscoverMap extends QuestObjective implements IDataCenter
   {
       
      
      private var _mapDescriptionText:String;
      
      private var _text:String;
      
      public function QuestObjectiveDiscoverMap()
      {
         super();
      }
      
      public function get mapDescriptionTextId() : uint
      {
         if(!this.parameters)
         {
            return 0;
         }
         return this.parameters[0];
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
            this._text = PatternDecoder.getDescription(this.type.name,[this.mapDescriptionText]);
         }
         return this._text;
      }
   }
}
