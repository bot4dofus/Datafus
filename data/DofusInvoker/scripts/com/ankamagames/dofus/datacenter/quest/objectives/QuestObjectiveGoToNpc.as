package com.ankamagames.dofus.datacenter.quest.objectives
{
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.dofus.datacenter.quest.QuestObjective;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   
   public class QuestObjectiveGoToNpc extends QuestObjective implements IDataCenter
   {
       
      
      private var _npc:Npc;
      
      private var _text:String;
      
      public function QuestObjectiveGoToNpc()
      {
         super();
      }
      
      public function get npcId() : uint
      {
         if(!this.parameters)
         {
            return 0;
         }
         return this.parameters[0];
      }
      
      public function get npc() : Npc
      {
         if(!this._npc)
         {
            this._npc = Npc.getNpcById(this.npcId);
         }
         return this._npc;
      }
      
      override public function get text() : String
      {
         if(!this._text)
         {
            this._text = PatternDecoder.getDescription(this.type.name,[this.npc.name]);
         }
         return this._text;
      }
   }
}
