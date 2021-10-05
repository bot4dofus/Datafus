package mx.rpc
{
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   [ExcludeClass]
   public class ActiveCalls
   {
       
      
      private var calls:Object;
      
      private var callOrder:Array;
      
      public function ActiveCalls()
      {
         super();
         this.calls = {};
         this.callOrder = [];
      }
      
      public function addCall(id:String, token:AsyncToken) : void
      {
         this.calls[id] = token;
         this.callOrder.push(id);
      }
      
      public function getAllMessages() : Array
      {
         var id:* = null;
         var msgs:Array = [];
         for(id in this.calls)
         {
            msgs.push(this.calls[id]);
         }
         return msgs;
      }
      
      public function cancelLast() : AsyncToken
      {
         if(this.callOrder.length > 0)
         {
            return this.removeCall(this.callOrder[this.callOrder.length - 1] as String);
         }
         return null;
      }
      
      public function hasActiveCalls() : Boolean
      {
         return this.callOrder.length > 0;
      }
      
      public function removeCall(id:String) : AsyncToken
      {
         var token:AsyncToken = this.calls[id];
         if(token != null)
         {
            delete this.calls[id];
            this.callOrder.splice(this.callOrder.lastIndexOf(id),1);
         }
         return token;
      }
      
      public function wasLastCall(id:String) : Boolean
      {
         if(this.callOrder.length > 0)
         {
            return this.callOrder[this.callOrder.length - 1] == id;
         }
         return false;
      }
   }
}
