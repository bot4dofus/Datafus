package mx.rpc
{
   public class Fault extends Error
   {
       
      
      public var content:Object;
      
      public var rootCause:Object;
      
      protected var _faultCode:String;
      
      protected var _faultString:String;
      
      protected var _faultDetail:String;
      
      public function Fault(faultCode:String, faultString:String, faultDetail:String = null)
      {
         super("faultCode:" + faultCode + " faultString:\'" + faultString + "\' faultDetail:\'" + faultDetail + "\'");
         this._faultCode = faultCode;
         this._faultString = !!faultString ? faultString : "";
         this._faultDetail = faultDetail;
      }
      
      public function get faultCode() : String
      {
         return this._faultCode;
      }
      
      public function get faultDetail() : String
      {
         return this._faultDetail;
      }
      
      public function get faultString() : String
      {
         return this._faultString;
      }
      
      public function toString() : String
      {
         var s:String = "[RPC Fault";
         s += " faultString=\"" + this.faultString + "\"";
         s += " faultCode=\"" + this.faultCode + "\"";
         return s + (" faultDetail=\"" + this.faultDetail + "\"]");
      }
   }
}
