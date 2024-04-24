package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class SpellCastSequenceContext
   {
      
      private static const NO_ID:int = uint.MAX_VALUE;
      
      private static var idCounter:uint = 0;
       
      
      public var id:uint = 1.0;
      
      public var casterId:Number = 0;
      
      public var targetedCellId:int = -1;
      
      public var weaponId:int = -1;
      
      public var spellData:Spell;
      
      public var spellLevelData:SpellLevel;
      
      public var direction:int = -1;
      
      public var markId:int;
      
      public var markType:int;
      
      public var isSilentCast:Boolean;
      
      public var isCriticalHit:Boolean;
      
      public var isCriticalFail:Boolean;
      
      public var portalIds:Vector.<int>;
      
      public var portalMapPoints:Vector.<MapPoint>;
      
      public var defaultTargetGfxId:uint;
      
      public function SpellCastSequenceContext(isId:Boolean = true)
      {
         super();
         if(isId)
         {
            this.id = idCounter++;
         }
      }
   }
}
