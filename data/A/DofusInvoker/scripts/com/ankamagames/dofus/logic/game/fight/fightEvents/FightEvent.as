package com.ankamagames.dofus.logic.game.fight.fightEvents
{
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   
   public class FightEvent
   {
      
      private static var FIGHT_EVENT_ID_COUNTER:uint = 0;
       
      
      public var name:String;
      
      public var targetId:Number;
      
      public var params:Array;
      
      public var checkParams:int;
      
      public var firstParamToCheck:int;
      
      public var castingSpellId:int;
      
      public var order:int;
      
      public var buff:BasicBuff;
      
      public var id:uint;
      
      public function FightEvent(pName:String, pParams:Array, pTargetId:Number, pCheckParams:int, pCastingSpellId:int, pOrder:int = -1, pFirstParamToCheck:int = 1, pBuff:BasicBuff = null)
      {
         super();
         this.name = pName;
         this.targetId = pTargetId;
         this.params = pParams;
         this.checkParams = pCheckParams;
         this.castingSpellId = pCastingSpellId;
         this.order = pOrder;
         this.firstParamToCheck = pFirstParamToCheck;
         this.buff = pBuff;
         this.id = ++FIGHT_EVENT_ID_COUNTER;
      }
      
      public static function reset() : void
      {
         FIGHT_EVENT_ID_COUNTER = 0;
      }
   }
}
