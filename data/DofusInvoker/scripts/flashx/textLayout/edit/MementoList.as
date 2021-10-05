package flashx.textLayout.edit
{
   import flashx.textLayout.elements.TextFlow;
   
   [ExcludeClass]
   public class MementoList implements IMemento
   {
       
      
      private var _mementoList:Array;
      
      public function MementoList(textFlow:TextFlow)
      {
         super();
      }
      
      public function push(memento:IMemento) : void
      {
         if(memento)
         {
            this.mementoList.push(memento);
         }
      }
      
      private function get mementoList() : Array
      {
         if(!this._mementoList)
         {
            this._mementoList = [];
         }
         return this._mementoList;
      }
      
      public function undo() : *
      {
         var memento:IMemento = null;
         var retVal:Array = [];
         if(this._mementoList)
         {
            this._mementoList.reverse();
            for each(memento in this._mementoList)
            {
               retVal.push(memento.undo());
            }
            this._mementoList.reverse();
         }
         return retVal;
      }
      
      public function redo() : *
      {
         var memento:IMemento = null;
         var retVal:Array = [];
         for each(memento in this._mementoList)
         {
            retVal.push(memento.redo());
         }
         return retVal;
      }
   }
}
