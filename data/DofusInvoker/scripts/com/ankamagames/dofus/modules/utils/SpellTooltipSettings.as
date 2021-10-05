package com.ankamagames.dofus.modules.utils
{
   import com.ankamagames.jerakine.interfaces.IModuleUtil;
   
   public class SpellTooltipSettings implements IModuleUtil
   {
       
      
      public var header:Boolean;
      
      public var description:Boolean;
      
      public var isTheoretical:Boolean;
      
      public var footer:Boolean;
      
      public var footerText:String;
      
      public var unPinnable:Boolean = false;
      
      public var isCharacterCreation:Boolean = false;
      
      public var subtitle:String;
      
      public function SpellTooltipSettings()
      {
         super();
         this.header = true;
         this.description = true;
         this.isTheoretical = false;
         this.footer = true;
      }
   }
}
