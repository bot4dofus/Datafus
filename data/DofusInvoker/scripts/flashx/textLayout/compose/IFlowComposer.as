package flashx.textLayout.compose
{
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.edit.ISelectionManager;
   import flashx.textLayout.elements.ContainerFormattedElement;
   
   public interface IFlowComposer
   {
       
      
      function get rootElement() : ContainerFormattedElement;
      
      function setRootElement(param1:ContainerFormattedElement) : void;
      
      function get damageAbsoluteStart() : int;
      
      function updateAllControllers() : Boolean;
      
      function updateToController(param1:int = 2147483647) : Boolean;
      
      function setFocus(param1:int, param2:Boolean = false) : void;
      
      function compose() : Boolean;
      
      function composeToPosition(param1:int = 2147483647) : Boolean;
      
      function composeToController(param1:int = 2147483647) : Boolean;
      
      function get numControllers() : int;
      
      function addController(param1:ContainerController) : void;
      
      function addControllerAt(param1:ContainerController, param2:int) : void;
      
      function removeController(param1:ContainerController) : void;
      
      function removeControllerAt(param1:int) : void;
      
      function removeAllControllers() : void;
      
      function getControllerAt(param1:int) : ContainerController;
      
      function getControllerIndex(param1:ContainerController) : int;
      
      function findControllerIndexAtPosition(param1:int, param2:Boolean = false) : int;
      
      function findLineIndexAtPosition(param1:int, param2:Boolean = false) : int;
      
      function findLineAtPosition(param1:int, param2:Boolean = false) : TextFlowLine;
      
      function getLineAt(param1:int) : TextFlowLine;
      
      function get numLines() : int;
      
      function isDamaged(param1:int) : Boolean;
      
      function isPotentiallyDamaged(param1:int) : Boolean;
      
      function get composing() : Boolean;
      
      function get swfContext() : ISWFContext;
      
      function set swfContext(param1:ISWFContext) : void;
      
      function interactionManagerChanged(param1:ISelectionManager) : void;
      
      function updateLengths(param1:int, param2:int) : void;
      
      function damage(param1:int, param2:int, param3:String) : void;
   }
}
