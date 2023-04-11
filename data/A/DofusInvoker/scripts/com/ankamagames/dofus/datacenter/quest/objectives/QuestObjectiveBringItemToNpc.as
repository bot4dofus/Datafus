package com.ankamagames.dofus.datacenter.quest.objectives
{
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.dofus.datacenter.quest.QuestObjective;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   
   public class QuestObjectiveBringItemToNpc extends QuestObjective implements IDataCenter
   {
       
      
      private var _npc:Npc;
      
      private var _item:Item;
      
      private var _text:String;
      
      public function QuestObjectiveBringItemToNpc()
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
      
      public function get itemId() : uint
      {
         if(!this.parameters)
         {
            return 0;
         }
         return this.parameters[1];
      }
      
      public function get item() : Item
      {
         if(!this._item)
         {
            this._item = Item.getItemById(this.itemId);
         }
         return this._item;
      }
      
      public function get quantity() : uint
      {
         if(!this.parameters)
         {
            return 0;
         }
         return this.parameters[2];
      }
      
      override public function get text() : String
      {
         if(!this._text)
         {
            this._text = PatternDecoder.getDescription(this.type.name,[this.npc.name,"{item," + this.itemId + "}",this.quantity]);
         }
         return this._text;
      }
   }
}
