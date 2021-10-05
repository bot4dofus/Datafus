package mx.styles
{
   public interface ISimpleStyleClient
   {
       
      
      function get styleName() : Object;
      
      function set styleName(param1:Object) : void;
      
      function styleChanged(param1:String) : void;
   }
}
