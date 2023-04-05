package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   
   public class MarkInstance
   {
       
      
      public var markCasterId:Number;
      
      public var markId:int;
      
      public var markType:int;
      
      public var associatedSpell:Spell;
      
      public var associatedSpellLevel:SpellLevel;
      
      public var selections:Vector.<Selection>;
      
      public var cells:Vector.<uint>;
      
      public var teamId:int;
      
      public var active:Boolean;
      
      public var markImpactCellId:int;
      
      public function MarkInstance()
      {
         super();
      }
   }
}
