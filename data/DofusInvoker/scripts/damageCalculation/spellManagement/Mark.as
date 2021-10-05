package damageCalculation.spellManagement
{
   public class Mark
   {
       
      
      public var teamId:uint;
      
      public var markType:int;
      
      public var markId:int;
      
      public var mainCell:int;
      
      public var cells:Array;
      
      public var casterId:Number;
      
      public var associatedSpell:HaxeSpell;
      
      public var active:Boolean;
      
      public function Mark()
      {
         associatedSpell = null;
         markType = 0;
      }
      
      public function stopDrag() : Boolean
      {
         switch(markType)
         {
            case 2:
            case 3:
               return true;
            default:
               return false;
         }
      }
      
      public function setMarkType(param1:int) : void
      {
         markType = param1;
         if(markType != 0 && associatedSpell != null)
         {
            switch(markType)
            {
               case 1:
                  associatedSpell.isGlyph = true;
                  associatedSpell.isTrap = false;
                  associatedSpell.isRune = false;
                  break;
               case 2:
                  associatedSpell.isTrap = true;
                  associatedSpell.isGlyph = false;
                  associatedSpell.isRune = false;
                  break;
               case 5:
                  associatedSpell.isRune = true;
                  associatedSpell.isTrap = false;
                  associatedSpell.isGlyph = false;
            }
         }
      }
      
      public function setAssociatedSpell(param1:HaxeSpell) : void
      {
         associatedSpell = param1;
         if(markType != 0 && associatedSpell != null)
         {
            switch(markType)
            {
               case 1:
                  associatedSpell.isGlyph = true;
                  associatedSpell.isTrap = false;
                  associatedSpell.isRune = false;
                  break;
               case 2:
                  associatedSpell.isTrap = true;
                  associatedSpell.isGlyph = false;
                  associatedSpell.isRune = false;
                  break;
               case 5:
                  associatedSpell.isRune = true;
                  associatedSpell.isTrap = false;
                  associatedSpell.isGlyph = false;
            }
         }
      }
      
      public function adaptSpellToType() : void
      {
         if(markType != 0 && associatedSpell != null)
         {
            switch(markType)
            {
               case 1:
                  associatedSpell.isGlyph = true;
                  associatedSpell.isTrap = false;
                  associatedSpell.isRune = false;
                  break;
               case 2:
                  associatedSpell.isTrap = true;
                  associatedSpell.isGlyph = false;
                  associatedSpell.isRune = false;
                  break;
               case 5:
                  associatedSpell.isRune = true;
                  associatedSpell.isTrap = false;
                  associatedSpell.isGlyph = false;
            }
         }
      }
   }
}
