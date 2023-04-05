package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CharacterRemodelSelectionAction extends AbstractAction implements Action
   {
       
      
      public var id:Number;
      
      public var sex:Boolean;
      
      public var breed:uint;
      
      public var cosmeticId:uint;
      
      public var name:String;
      
      public var colors:Vector.<int>;
      
      public function CharacterRemodelSelectionAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(id:Number, sex:Boolean, breed:uint, cosmeticId:uint, name:String, colors:Vector.<int>) : CharacterRemodelSelectionAction
      {
         var a:CharacterRemodelSelectionAction = new CharacterRemodelSelectionAction(arguments);
         a.id = id;
         a.sex = sex;
         a.breed = breed;
         a.cosmeticId = cosmeticId;
         a.name = name;
         a.colors = colors;
         return a;
      }
   }
}
