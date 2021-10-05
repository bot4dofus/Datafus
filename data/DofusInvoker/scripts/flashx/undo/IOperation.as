package flashx.undo
{
   public interface IOperation
   {
       
      
      function performRedo() : void;
      
      function performUndo() : void;
   }
}
