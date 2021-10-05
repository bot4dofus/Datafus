package damageCalculation.fighterManagement
{
   import damageCalculation.fighterManagement.fighterstats.HaxeStat;
   
   public interface IFighterData
   {
       
      
      function useSummonSlot() : Boolean;
      
      function setStat(param1:HaxeStat) : void;
      
      function resolveDodge() : int;
      
      function resetStats() : void;
      
      function isSummon() : Boolean;
      
      function isInvisible() : Boolean;
      
      function isAlly() : Boolean;
      
      function getUsedPM() : int;
      
      function getTurnBeginPosition() : int;
      
      function getSummonerId() : Number;
      
      function getStatIds() : Array;
      
      function getStat(param1:int) : HaxeStat;
      
      function getStartedPositionCell() : int;
      
      function getPreviousPosition() : int;
      
      function getMaxHealthPoints() : int;
      
      function getItemSpellDamageModification(param1:int) : int;
      
      function getItemSpellBaseDamageModification(param1:int) : int;
      
      function getHealthPoints() : int;
      
      function getCharacteristicValue(param1:int) : int;
      
      function canBreedUsePortals() : Boolean;
      
      function canBreedSwitchPosOnTarget() : Boolean;
      
      function canBreedSwitchPos() : Boolean;
      
      function canBreedBePushed() : Boolean;
      
      function canBreedBeCarried() : Boolean;
   }
}
