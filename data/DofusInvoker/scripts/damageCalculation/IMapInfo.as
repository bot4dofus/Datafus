package damageCalculation
{
   import damageCalculation.fighterManagement.HaxeFighter;
   import haxe.ds.List;
   
   public interface IMapInfo
   {
       
      
      function isCellWalkable(param1:int) : Boolean;
      
      function getOutputPortalCell(param1:int) : int;
      
      function getMarks(param1:int = undefined, param2:int = undefined) : Array;
      
      function getMarkInteractingWithCell(param1:int, param2:int = undefined) : Array;
      
      function getLastKilledAlly(param1:int) : HaxeFighter;
      
      function getFightersInitialPositions() : List;
      
      function getFighterById(param1:Number) : HaxeFighter;
      
      function getEveryFighterId() : Array;
      
      function getCarriedFighterIdBy(param1:HaxeFighter) : Number;
      
      function dispellIllusionOnCell(param1:int) : void;
   }
}
