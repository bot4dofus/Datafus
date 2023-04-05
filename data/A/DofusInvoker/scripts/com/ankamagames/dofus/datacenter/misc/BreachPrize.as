package com.ankamagames.dofus.datacenter.misc
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class BreachPrize implements IDataCenter
   {
      
      public static const MODULE:String = "BreachPrizes";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getBreachPrizeById,getAllBreachPrizes);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var currency:int;
      
      public var tooltipKey:String;
      
      public var descriptionKey:uint;
      
      public var categoryId:int;
      
      public var itemId:int;
      
      private var _name:String;
      
      private var _description:String;
      
      public function BreachPrize()
      {
         super();
      }
      
      public static function getBreachPrizeById(id:int) : BreachPrize
      {
         return GameData.getObject(MODULE,id) as BreachPrize;
      }
      
      public static function getAllBreachPrizes() : Array
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
      
      public function get description() : String
      {
         if(!this._description)
         {
            this._description = "";
            if(this.tooltipKey && this.tooltipKey != "")
            {
               this._description = I18n.getUiText("ui." + this.tooltipKey);
            }
            if(this.descriptionKey && this.descriptionKey != 0)
            {
               if(this._description != "")
               {
                  this._description += "\n";
               }
               this._description += I18n.getText(this.descriptionKey);
            }
         }
         return this._description;
      }
      
      public function get item() : ItemWrapper
      {
         return ItemWrapper.create(0,0,this.itemId,1,null);
      }
   }
}
