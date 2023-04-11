package com.ankamagames.dofus.datacenter.quest.objectives
{
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.quest.QuestObjective;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   
   public class QuestObjectiveCraftItem extends QuestObjective implements IDataCenter
   {
       
      
      private var _item:Item;
      
      private var _text:String;
      
      public function QuestObjectiveCraftItem()
      {
         super();
      }
      
      public function get itemId() : uint
      {
         if(!this.parameters || this.parameters.length < 2)
         {
            return 0;
         }
         return this.parameters[0];
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
         if(!this.parameters || this.parameters.length < 2)
         {
            return 0;
         }
         return this.parameters[1];
      }
      
      override public function get text() : String
      {
         if(!this._text)
         {
            this._text = PatternDecoder.getDescription(this.type.name,["{item," + this.itemId + "}",this.quantity]);
         }
         return this._text;
      }
   }
}
