package com.ankamagames.dofus.datacenter.quest.objectives
{
   import com.ankamagames.dofus.datacenter.quest.QuestObjective;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   
   public class QuestObjectiveDuelSpecificPlayer extends QuestObjective implements IDataCenter
   {
       
      
      private var _specificPlayerText:String;
      
      private var _text:String;
      
      public function QuestObjectiveDuelSpecificPlayer()
      {
         super();
      }
      
      public function get specificPlayerTextId() : uint
      {
         if(!this.parameters)
         {
            return 0;
         }
         return this.parameters[0];
      }
      
      public function get specificPlayerText() : String
      {
         if(!this._specificPlayerText)
         {
            this._specificPlayerText = I18n.getText(this.specificPlayerTextId);
         }
         return this._specificPlayerText;
      }
      
      override public function get text() : String
      {
         if(!this._text)
         {
            this._text = PatternDecoder.getDescription(this.type.name,[this.specificPlayerText]);
         }
         return this._text;
      }
   }
}
