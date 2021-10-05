package damageCalculation.fighterManagement.fighterstats
{
   public class HaxeDetailedStat extends HaxeStat
   {
       
      
      public var objectsAndMountBonus:int;
      
      public var contextModif:int;
      
      public var base:int;
      
      public var alignGiftBonus:int;
      
      public var additional:int;
      
      public function HaxeDetailedStat(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int)
      {
         contextModif = 0;
         alignGiftBonus = 0;
         objectsAndMountBonus = 0;
         additional = 0;
         base = 0;
         super(param1);
         set_base(param2);
         set_additional(param3);
         set_objectsAndMountBonus(param4);
         set_alignGiftBonus(param5);
         set_contextModif(param6);
      }
      
      public function updateTotal() : void
      {
         total = int(get_base()) + int(get_additional()) + int(get_objectsAndMountBonus()) + int(get_alignGiftBonus()) + int(get_contextModif());
      }
      
      override public function updateStatWithValue(param1:int, param2:Boolean) : void
      {
         var _loc3_:int = !!param2 ? 1 : -1;
         var _loc4_:int = Math.floor(_loc3_ * param1);
         var _loc5_:HaxeDetailedStat = this;
         _loc5_.set_contextModif(int(_loc5_.get_contextModif()) + _loc4_);
      }
      
      public function set_objectsAndMountBonus(param1:int) : int
      {
         objectsAndMountBonus = param1;
         updateTotal();
         return int(get_objectsAndMountBonus());
      }
      
      public function set_contextModif(param1:int) : int
      {
         contextModif = param1;
         updateTotal();
         return int(get_contextModif());
      }
      
      public function set_base(param1:int) : int
      {
         base = param1;
         updateTotal();
         return int(get_base());
      }
      
      public function set_alignGiftBonus(param1:int) : int
      {
         alignGiftBonus = param1;
         updateTotal();
         return int(get_alignGiftBonus());
      }
      
      public function set_additional(param1:int) : int
      {
         additional = param1;
         updateTotal();
         return int(get_additional());
      }
      
      public function get_objectsAndMountBonus() : int
      {
         return objectsAndMountBonus;
      }
      
      public function get_contextModif() : int
      {
         return contextModif;
      }
      
      public function get_base() : int
      {
         return base;
      }
      
      public function get_alignGiftBonus() : int
      {
         return alignGiftBonus;
      }
      
      public function get_additional() : int
      {
         return additional;
      }
   }
}
