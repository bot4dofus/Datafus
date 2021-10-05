package mx.styles
{
   public interface IAdvancedStyleClient extends IStyleClient
   {
       
      
      function get id() : String;
      
      function get styleParent() : IAdvancedStyleClient;
      
      function set styleParent(param1:IAdvancedStyleClient) : void;
      
      function stylesInitialized() : void;
      
      function matchesCSSState(param1:String) : Boolean;
      
      function matchesCSSType(param1:String) : Boolean;
      
      function hasCSSState() : Boolean;
   }
}
