package mx.rpc
{
   public class Responder implements IResponder
   {
       
      
      private var _resultHandler:Function;
      
      private var _faultHandler:Function;
      
      public function Responder(result:Function, fault:Function)
      {
         super();
         this._resultHandler = result;
         this._faultHandler = fault;
      }
      
      public function result(data:Object) : void
      {
         this._resultHandler(data);
      }
      
      public function fault(info:Object) : void
      {
         this._faultHandler(info);
      }
   }
}
