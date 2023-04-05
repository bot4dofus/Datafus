package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CharacterCreationAction extends AbstractAction implements Action
   {
       
      
      public var name:String;
      
      public var breed:uint;
      
      public var head:int;
      
      public var sex:Boolean;
      
      public var colors:Array;
      
      public function CharacterCreationAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(name:String, breed:uint, sex:Boolean, colors:Array, head:int) : CharacterCreationAction
      {
         var a:CharacterCreationAction = new CharacterCreationAction(arguments);
         a.name = name;
         a.breed = breed;
         a.sex = sex;
         a.colors = colors;
         a.head = head;
         return a;
      }
   }
}
