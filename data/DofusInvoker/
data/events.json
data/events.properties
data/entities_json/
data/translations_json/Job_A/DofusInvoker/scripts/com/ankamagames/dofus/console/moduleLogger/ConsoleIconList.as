package com.ankamagames.dofus.console.moduleLogger
{
   import flash.display.Sprite;
   
   public class ConsoleIconList extends Sprite
   {
       
      
      private var _numIcons:uint;
      
      public function ConsoleIconList()
      {
         super();
      }
      
      public function addIcon(child:ConsoleIcon) : void
      {
         addChild(child).x = this._numIcons * (Console.ICON_SIZE + Console.ICON_INTERVAL);
         ++this._numIcons;
      }
   }
}
