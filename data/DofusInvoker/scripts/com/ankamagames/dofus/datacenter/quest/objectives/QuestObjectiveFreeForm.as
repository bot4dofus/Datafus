package com.ankamagames.dofus.datacenter.quest.objectives
{
   import com.ankamagames.dofus.datacenter.quest.QuestObjective;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class QuestObjectiveFreeForm extends QuestObjective implements IDataCenter
   {
       
      
      private var _freeFormText:String;
      
      public function QuestObjectiveFreeForm()
      {
         super();
      }
      
      public function get freeFormTextId() : uint
      {
         if(!this.parameters)
         {
            return 0;
         }
         return this.parameters[0];
      }
      
      public function get freeFormText() : String
      {
         if(!this._freeFormText)
         {
            this._freeFormText = I18n.getText(this.freeFormTextId);
         }
         return this._freeFormText;
      }
      
      override public function get text() : String
      {
         return this.freeFormText;
      }
   }
}
