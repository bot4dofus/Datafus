package com.ankamagames.dofus.datacenter.quest.objectives
{
   import com.ankamagames.dofus.datacenter.alterations.Alteration;
   import com.ankamagames.dofus.datacenter.quest.QuestObjective;
   import com.ankamagames.dofus.internalDatacenter.alterations.AlterationWrapper;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkAlterationManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   
   public class QuestObjectiveFightMonster extends QuestObjective implements IDataCenter
   {
       
      
      private var _text:String;
      
      public function QuestObjectiveFightMonster()
      {
         super();
      }
      
      private function get monsterId() : uint
      {
         if(!this.parameters)
         {
            return 0;
         }
         return this.parameters.parameter0;
      }
      
      private function get quantity() : uint
      {
         if(!this.parameters)
         {
            return 0;
         }
         return this.parameters.parameter1;
      }
      
      private function get alteration() : String
      {
         if(!this.parameters)
         {
            return "";
         }
         var alteration:Alteration = Alteration.getAlterationById(this.parameters.parameter3);
         if(!alteration)
         {
            return "";
         }
         return HyperlinkAlterationManager.getLink(AlterationWrapper.create(alteration,TimeManager.getInstance().getUtcTimestamp()));
      }
      
      override public function get text() : String
      {
         var monsterLink:* = null;
         if(!this._text)
         {
            monsterLink = "{chatmonster," + this.monsterId + "}";
            if(this.alteration.length == 0)
            {
               this._text = PatternDecoder.getDescription(this.type.name,[monsterLink,this.quantity]);
            }
            else
            {
               this._text = I18n.getUiText("ui.grimoire.quest.objectives.type6.alteration",[this.quantity,monsterLink,this.alteration]);
            }
         }
         return this._text;
      }
   }
}
