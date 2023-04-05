package com.ankamagames.atouin.data.map.elements
{
   import com.ankamagames.atouin.data.map.Cell;
   import com.ankamagames.atouin.enums.ElementTypesEnum;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.IDataInput;
   import flash.utils.getQualifiedClassName;
   
   public class BasicElement
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(BasicElement));
       
      
      private var _cell:Cell;
      
      public function BasicElement(cell:Cell)
      {
         super();
         this._cell = cell;
      }
      
      public static function getElementFromType(type:int, cell:Cell) : BasicElement
      {
         switch(type)
         {
            case ElementTypesEnum.GRAPHICAL:
               return new GraphicalElement(cell);
            case ElementTypesEnum.SOUND:
               return new SoundElement(cell);
            default:
               throw new UnknownElementError("Un élément de type inconnu " + type + " a été trouvé sur la cellule " + cell.cellId + "!");
         }
      }
      
      public function get cell() : Cell
      {
         return this._cell;
      }
      
      public function get elementType() : int
      {
         return -1;
      }
      
      public function fromRaw(raw:IDataInput, mapVersion:int) : void
      {
         throw new Error("Cette méthode doit être surchargée !");
      }
   }
}
