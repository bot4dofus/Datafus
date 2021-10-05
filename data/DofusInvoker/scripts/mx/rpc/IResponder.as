package mx.rpc
{
   public interface IResponder
   {
       
      
      function result(param1:Object) : void;
      
      function fault(param1:Object) : void;
   }
}
