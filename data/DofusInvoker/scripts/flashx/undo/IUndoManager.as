package flashx.undo
{
   public interface IUndoManager
   {
       
      
      function clearAll() : void;
      
      function get undoAndRedoItemLimit() : int;
      
      function set undoAndRedoItemLimit(param1:int) : void;
      
      function canUndo() : Boolean;
      
      function peekUndo() : IOperation;
      
      function popUndo() : IOperation;
      
      function pushUndo(param1:IOperation) : void;
      
      function clearRedo() : void;
      
      function canRedo() : Boolean;
      
      function peekRedo() : IOperation;
      
      function popRedo() : IOperation;
      
      function pushRedo(param1:IOperation) : void;
      
      function undo() : void;
      
      function redo() : void;
   }
}
