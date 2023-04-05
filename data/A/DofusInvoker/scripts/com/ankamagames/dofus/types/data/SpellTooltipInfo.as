package com.ankamagames.dofus.types.data
{
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   
   public class SpellTooltipInfo
   {
       
      
      public var spellWrapper:SpellWrapper;
      
      public var shortcutKey:String;
      
      public function SpellTooltipInfo(spellWrapper:SpellWrapper, shortcutKey:String = null)
      {
         super();
         this.spellWrapper = spellWrapper;
         this.shortcutKey = shortcutKey;
      }
   }
}
