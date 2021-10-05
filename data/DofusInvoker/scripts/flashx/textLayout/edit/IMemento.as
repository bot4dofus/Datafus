package flashx.textLayout.edit
{
   [ExcludeClass]
   public interface IMemento
   {
       
      
      function undo() : *;
      
      function redo() : *;
   }
}
