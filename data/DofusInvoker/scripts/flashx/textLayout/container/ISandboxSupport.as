package flashx.textLayout.container
{
   import flash.events.Event;
   
   public interface ISandboxSupport
   {
       
      
      function beginMouseCapture() : void;
      
      function endMouseCapture() : void;
      
      function mouseUpSomewhere(param1:Event) : void;
      
      function mouseMoveSomewhere(param1:Event) : void;
   }
}
