package com.ankamagames.dofus.datacenter.quest.objectives
{
   import com.ankamagames.dofus.datacenter.quest.QuestObjective;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   
   public class QuestObjectiveDiscoverSubArea extends QuestObjective implements IDataCenter
   {
       
      
      private var _subArea:SubArea;
      
      private var _text:String;
      
      public function QuestObjectiveDiscoverSubArea()
      {
         super();
      }
      
      public function get subAreaId() : uint
      {
         if(!this.parameters)
         {
            return 0;
         }
         return this.parameters[0];
      }
      
      public function get subArea() : SubArea
      {
         if(!this._subArea)
         {
            this._subArea = SubArea.getSubAreaById(this.subAreaId);
         }
         return this._subArea;
      }
      
      override public function get text() : String
      {
         if(!this._text)
         {
            this._text = PatternDecoder.getDescription(this.type.name,[this.subArea.name]);
         }
         return this._text;
      }
   }
}
