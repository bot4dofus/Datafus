package com.ankamagames.dofus.datacenter.items
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Weapon extends Item implements IDataCenter
   {
      
      public static var idAccessors:IdAccessors = new IdAccessors(getWeaponById,getWeapons);
       
      
      public var apCost:int;
      
      public var minRange:int;
      
      public var range:int;
      
      public var maxCastPerTurn:uint;
      
      public var castInLine:Boolean;
      
      public var castInDiagonal:Boolean;
      
      public var castTestLos:Boolean;
      
      public var criticalHitProbability:int;
      
      public var criticalHitBonus:int;
      
      public var criticalFailureProbability:int;
      
      public function Weapon()
      {
         super();
      }
      
      public static function getWeaponById(weaponId:int) : Weapon
      {
         var item:Item = Item.getItemById(weaponId);
         if(item && item.isWeapon)
         {
            return Weapon(item);
         }
         return null;
      }
      
      public static function getWeapons() : Array
      {
         var item:Item = null;
         var items:Array = Item.getItems();
         var result:Array = new Array();
         for each(item in items)
         {
            if(item.isWeapon)
            {
               result.push(item);
            }
         }
         return result;
      }
      
      override public function get isWeapon() : Boolean
      {
         return true;
      }
      
      override public function copy(from:Item, to:Item) : void
      {
         super.copy(from,to);
         if(to.hasOwnProperty("apCost") && from.hasOwnProperty("apCost"))
         {
            Object(to).apCost = Object(from).apCost;
            Object(to).minRange = Object(from).minRange;
            Object(to).range = Object(from).range;
            Object(to).maxCastPerTurn = Object(from).maxCastPerTurn;
            Object(to).castInLine = Object(from).castInLine;
            Object(to).castInDiagonal = Object(from).castInDiagonal;
            Object(to).castTestLos = Object(from).castTestLos;
            Object(to).criticalHitProbability = Object(from).criticalHitProbability;
            Object(to).criticalHitBonus = Object(from).criticalHitBonus;
            Object(to).criticalFailureProbability = Object(from).criticalFailureProbability;
         }
         else
         {
            _log.error("Failed to properly copy weapon data " + from.id + " to " + to.id);
         }
      }
   }
}
