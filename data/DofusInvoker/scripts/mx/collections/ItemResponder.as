package mx.collections
{
   import mx.core.mx_internal;
   import mx.rpc.IResponder;
   
   use namespace mx_internal;
   
   public class ItemResponder implements IResponder
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
       
      
      private var _resultHandler:Function;
      
      private var _faultHandler:Function;
      
      private var _token:Object;
      
      public function ItemResponder(result:Function, fault:Function, token:Object = null)
      {
         super();
         this._resultHandler = result;
         this._faultHandler = fault;
         this._token = token;
      }
      
      public function result(data:Object) : void
      {
         this._resultHandler(data,this._token);
      }
      
      public function fault(info:Object) : void
      {
         this._faultHandler(info,this._token);
      }
   }
}
