package flashx.textLayout.factory
{
   import flashx.textLayout.compose.SimpleCompose;
   import flashx.textLayout.compose.StandardFlowComposer;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.elements.BackgroundManager;
   import flashx.textLayout.tlf_internal;
   
   [ExcludeClass]
   public class FactoryDisplayComposer extends StandardFlowComposer
   {
       
      
      public function FactoryDisplayComposer()
      {
         super();
      }
      
      override tlf_internal function callTheComposer(absoluteEndPosition:int, controllerEndIndex:int) : ContainerController
      {
         clearCompositionResults();
         var state:SimpleCompose = TextLineFactoryBase._factoryComposer;
         state.composeTextFlow(textFlow,-1,-1);
         state.releaseAnyReferences();
         return getControllerAt(0);
      }
      
      override protected function preCompose() : Boolean
      {
         return true;
      }
      
      override tlf_internal function createBackgroundManager() : BackgroundManager
      {
         return new FactoryBackgroundManager();
      }
   }
}

import flash.text.engine.TextLine;
import flashx.textLayout.compose.TextFlowLine;
import flashx.textLayout.elements.BackgroundManager;

class FactoryBackgroundManager extends BackgroundManager
{
    
   
   function FactoryBackgroundManager()
   {
      super();
   }
   
   override public function finalizeLine(line:TextFlowLine) : void
   {
      var obj:Object = null;
      var textLine:TextLine = line.getTextLine();
      var array:Array = _lineDict[textLine];
      if(array)
      {
         obj = array[0];
         if(obj)
         {
            obj.columnRect = line.controller.columnState.getColumnAt(line.columnIndex);
         }
      }
   }
}
