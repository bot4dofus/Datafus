package flashx.textLayout.compose
{
   import flash.display.Sprite;
   import flash.system.Capabilities;
   import flashx.textLayout.accessibility.TextAccImpl;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.container.ScrollPolicy;
   import flashx.textLayout.edit.ISelectionManager;
   import flashx.textLayout.elements.BackgroundManager;
   import flashx.textLayout.elements.ContainerFormattedElement;
   import flashx.textLayout.elements.TableCellElement;
   import flashx.textLayout.elements.TableElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.events.CompositionCompleteEvent;
   import flashx.textLayout.events.ModelChange;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class StandardFlowComposer extends FlowComposerBase implements IFlowComposer
   {
       
      
      protected var _rootElement:ContainerFormattedElement;
      
      private var _controllerList:Array;
      
      private var _composing:Boolean;
      
      private var lastBPDirectionScrollPosition:Number = -Infinity;
      
      public function StandardFlowComposer()
      {
         super();
         this._controllerList = [];
         this._composing = false;
      }
      
      private static function clearContainerAccessibilityImplementation(cont:Sprite) : void
      {
         if(cont.accessibilityImplementation)
         {
            if(cont.accessibilityImplementation is TextAccImpl)
            {
               TextAccImpl(cont.accessibilityImplementation).detachListeners();
            }
            cont.accessibilityImplementation = null;
         }
      }
      
      private static function getBPDirectionScrollPosition(bp:String, cont:ContainerController) : Number
      {
         return bp == BlockProgression.TB ? Number(cont.verticalScrollPosition) : Number(cont.horizontalScrollPosition);
      }
      
      public function get composing() : Boolean
      {
         return this._composing;
      }
      
      public function getAbsoluteStart(controller:ContainerController) : int
      {
         var stopIdx:int = this.getControllerIndex(controller);
         var rslt:int = this._rootElement.getAbsoluteStart();
         for(var idx:int = 0; idx < stopIdx; idx++)
         {
            rslt += this._controllerList[idx].textLength;
         }
         return rslt;
      }
      
      public function get rootElement() : ContainerFormattedElement
      {
         return this._rootElement;
      }
      
      public function setRootElement(newRootElement:ContainerFormattedElement) : void
      {
         if(this._rootElement != newRootElement)
         {
            if(newRootElement is TextFlow && (newRootElement as TextFlow).flowComposer != this)
            {
               (newRootElement as TextFlow).flowComposer = this;
            }
            else
            {
               this.clearCompositionResults();
               this.detachAllContainers();
               this._rootElement = newRootElement;
               _textFlow = !!this._rootElement ? this._rootElement.getTextFlow() : null;
               this.attachAllContainers();
            }
         }
      }
      
      tlf_internal function detachAllContainers() : void
      {
         var cont:ContainerController = null;
         var firstContainerController:ContainerController = null;
         var firstContainer:Sprite = null;
         if(this._controllerList.length > 0 && _textFlow)
         {
            firstContainerController = this.getControllerAt(0);
            firstContainer = firstContainerController.container;
            if(firstContainer)
            {
               clearContainerAccessibilityImplementation(firstContainer);
            }
         }
         for each(cont in this._controllerList)
         {
            cont.dispose();
         }
      }
      
      tlf_internal function attachAllContainers() : void
      {
         var cont:ContainerController = null;
         var curContainer:Sprite = null;
         var i:int = 0;
         var firstContainer:Sprite = null;
         for each(cont in this._controllerList)
         {
            ContainerController(cont).setRootElement(this._rootElement);
         }
         if(this._controllerList.length > 0 && _textFlow)
         {
            if(textFlow.configuration.enableAccessibility && Capabilities.hasAccessibility)
            {
               firstContainer = this.getControllerAt(0).container;
               if(firstContainer)
               {
                  clearContainerAccessibilityImplementation(firstContainer);
                  firstContainer.accessibilityImplementation = new TextAccImpl(firstContainer,_textFlow);
               }
            }
            for(i = 0; i < this._controllerList.length; i++)
            {
               curContainer = this.getControllerAt(i).container;
               if(curContainer)
               {
                  curContainer.focusRect = false;
               }
            }
         }
         this.clearCompositionResults();
      }
      
      public function get numControllers() : int
      {
         return !!this._controllerList ? int(this._controllerList.length) : 0;
      }
      
      public function addController(controller:ContainerController) : void
      {
         var curContainer:Sprite = null;
         var damageStart:int = 0;
         var damageLen:int = 0;
         this._controllerList.push(ContainerController(controller));
         if(this.numControllers == 1)
         {
            this.attachAllContainers();
         }
         else
         {
            controller.setRootElement(this._rootElement);
            curContainer = controller.container;
            if(curContainer)
            {
               curContainer.focusRect = false;
            }
            if(textFlow)
            {
               controller = this.getControllerAt(this.numControllers - 2);
               damageStart = controller.absoluteStart;
               damageLen = controller.textLength;
               if(damageLen == 0)
               {
                  if(damageStart != textFlow.textLength)
                  {
                     damageLen++;
                  }
                  else if(damageStart != 0)
                  {
                     damageStart--;
                     damageLen++;
                  }
               }
               if(damageLen)
               {
                  textFlow.damage(damageStart,damageLen,FlowDamageType.GEOMETRY,false);
               }
            }
         }
      }
      
      public function addControllerAt(controller:ContainerController, index:int) : void
      {
         this.detachAllContainers();
         this._controllerList.splice(index,0,ContainerController(controller));
         this.attachAllContainers();
      }
      
      private function fastRemoveController(index:int) : Boolean
      {
         var firstContainer:Sprite = null;
         if(index == -1)
         {
            return true;
         }
         var cont:ContainerController = this._controllerList[index];
         if(!cont)
         {
            return true;
         }
         if(!_textFlow || cont.absoluteStart == _textFlow.textLength)
         {
            if(index == 0)
            {
               firstContainer = cont.container;
               if(firstContainer)
               {
                  clearContainerAccessibilityImplementation(firstContainer);
               }
            }
            cont.setRootElement(null);
            this._controllerList.splice(index,1);
            return true;
         }
         return false;
      }
      
      public function removeController(controller:ContainerController) : void
      {
         var index:int = this.getControllerIndex(controller);
         if(!this.fastRemoveController(index))
         {
            this.detachAllContainers();
            this._controllerList.splice(index,1);
            this.attachAllContainers();
         }
      }
      
      public function removeControllerAt(index:int) : void
      {
         if(!this.fastRemoveController(index))
         {
            this.detachAllContainers();
            this._controllerList.splice(index,1);
            this.attachAllContainers();
         }
      }
      
      public function removeAllControllers() : void
      {
         this.detachAllContainers();
         this._controllerList.splice(0,this._controllerList.length);
      }
      
      public function getControllerAt(index:int) : ContainerController
      {
         return this._controllerList[index];
      }
      
      public function getControllerIndex(controller:ContainerController) : int
      {
         for(var idx:int = 0; idx < this._controllerList.length; idx++)
         {
            if(this._controllerList[idx] == controller)
            {
               return idx;
            }
         }
         return -1;
      }
      
      public function findControllerIndexAtPosition(absolutePosition:int, preferPrevious:Boolean = false) : int
      {
         var mid:int = 0;
         var cont:ContainerController = null;
         var lo:int = 0;
         var hi:int = this._controllerList.length - 1;
         while(lo <= hi)
         {
            mid = (lo + hi) / 2;
            cont = this._controllerList[mid];
            if(cont.absoluteStart <= absolutePosition)
            {
               if(preferPrevious)
               {
                  if(cont.absoluteStart + cont.textLength >= absolutePosition)
                  {
                     while(mid != 0 && cont.absoluteStart == absolutePosition)
                     {
                        mid--;
                        cont = this._controllerList[mid];
                     }
                     return mid;
                  }
               }
               else
               {
                  if(cont.absoluteStart == absolutePosition && cont.textLength != 0)
                  {
                     while(mid != 0)
                     {
                        cont = this._controllerList[mid - 1];
                        if(cont.textLength != 0)
                        {
                           break;
                        }
                        mid--;
                     }
                     return mid;
                  }
                  if(cont.absoluteStart + cont.textLength > absolutePosition)
                  {
                     return mid;
                  }
               }
               lo = mid + 1;
            }
            else
            {
               hi = mid - 1;
            }
         }
         return -1;
      }
      
      tlf_internal function clearCompositionResults() : void
      {
         var cont:ContainerController = null;
         initializeLines();
         for each(cont in this._controllerList)
         {
            cont.clearCompositionResults();
         }
      }
      
      public function updateAllControllers() : Boolean
      {
         return this.updateToController();
      }
      
      public function updateToController(index:int = 2147483647) : Boolean
      {
         var controller:ContainerController = null;
         var table:TableElement = null;
         if(this._composing)
         {
            return false;
         }
         var cellHeight:Number = 0;
         if(textFlow.nestedInTable())
         {
            controller = this.getControllerAt(0);
            if(controller)
            {
               cellHeight = controller.container.height;
            }
         }
         var sm:ISelectionManager = textFlow.interactionManager;
         if(sm)
         {
            sm.flushPendingOperations();
         }
         this.internalCompose(-1,index);
         var shapesDamaged:Boolean = this.areShapesDamaged();
         if(shapesDamaged)
         {
            this.updateCompositionShapes();
         }
         if(cellHeight && controller.container.height != cellHeight)
         {
            table = (textFlow.parentElement as TableCellElement).getTable();
            table.modelChanged(ModelChange.ELEMENT_MODIFIED,table,0,table.textLength);
            table.getTextFlow().flowComposer.updateAllControllers();
            if(sm && sm.focused)
            {
               controller.setFocus();
            }
         }
         if(sm)
         {
            sm.refreshSelection();
         }
         return shapesDamaged;
      }
      
      public function setFocus(absolutePosition:int, leanLeft:Boolean = false) : void
      {
         var idx:int = this.findControllerIndexAtPosition(absolutePosition,leanLeft);
         if(idx == -1)
         {
            idx = this.numControllers - 1;
         }
         if(idx != -1)
         {
            this._controllerList[idx].setFocus();
         }
      }
      
      public function interactionManagerChanged(newInteractionManager:ISelectionManager) : void
      {
         var controller:ContainerController = null;
         for each(controller in this._controllerList)
         {
            controller.interactionManagerChanged(newInteractionManager);
         }
      }
      
      private function updateCompositionShapes() : void
      {
         var controller:ContainerController = null;
         for each(controller in this._controllerList)
         {
            controller.updateCompositionShapes();
         }
      }
      
      override public function isPotentiallyDamaged(absolutePosition:int) : Boolean
      {
         var container:ContainerController = null;
         if(!super.isPotentiallyDamaged(absolutePosition))
         {
            if(absolutePosition == _textFlow.textLength)
            {
               container = this.getControllerAt(this.numControllers - 1);
               if(container && (container.verticalScrollPolicy != ScrollPolicy.OFF || container.horizontalScrollPolicy != ScrollPolicy.OFF))
               {
                  return true;
               }
            }
            return false;
         }
         return true;
      }
      
      protected function preCompose() : Boolean
      {
         this.rootElement.preCompose();
         if(numLines == 0)
         {
            initializeLines();
         }
         return isDamaged(this.rootElement.getAbsoluteStart() + this.rootElement.textLength);
      }
      
      tlf_internal function getComposeState() : ComposeState
      {
         return ComposeState.getComposeState();
      }
      
      tlf_internal function releaseComposeState(state:ComposeState) : void
      {
         ComposeState.releaseComposeState(state);
      }
      
      tlf_internal function callTheComposer(composeToPosition:int, controllerEndIndex:int) : ContainerController
      {
         if(_damageAbsoluteStart == this.rootElement.getAbsoluteStart() + this.rootElement.textLength)
         {
            return this.getControllerAt(this.numControllers - 1);
         }
         var state:ComposeState = this.getComposeState();
         var lastComposedPosition:int = state.composeTextFlow(textFlow,composeToPosition,controllerEndIndex);
         if(_damageAbsoluteStart < lastComposedPosition)
         {
            _damageAbsoluteStart = lastComposedPosition;
         }
         finalizeLinesAfterCompose();
         var startController:ContainerController = state.startController;
         this.releaseComposeState(state);
         if(textFlow.hasEventListener(CompositionCompleteEvent.COMPOSITION_COMPLETE))
         {
            textFlow.dispatchEvent(new CompositionCompleteEvent(CompositionCompleteEvent.COMPOSITION_COMPLETE,false,false,textFlow,0,lastComposedPosition));
         }
         return startController;
      }
      
      private function internalCompose(composeToPosition:int = -1, composeToControllerIndex:int = -1) : ContainerController
      {
         var bp:String = null;
         var startController:ContainerController = null;
         var damageLimit:int = 0;
         var controller:ContainerController = null;
         var lastVisibleLine:TextFlowLine = null;
         var idx:int = 0;
         var sm:ISelectionManager = textFlow.interactionManager;
         if(sm)
         {
            sm.flushPendingOperations();
         }
         this._composing = true;
         try
         {
            if(this.preCompose())
            {
               if(textFlow && this.numControllers != 0)
               {
                  damageLimit = _textFlow.textLength;
                  var composeToControllerIndex:int = Math.min(composeToControllerIndex,this.numControllers - 1);
                  if(composeToPosition != -1 || composeToControllerIndex != -1)
                  {
                     if(composeToControllerIndex < 0)
                     {
                        if(composeToPosition >= 0)
                        {
                           damageLimit = composeToPosition;
                        }
                     }
                     else
                     {
                        controller = this.getControllerAt(composeToControllerIndex);
                        if(controller.textLength != 0)
                        {
                           damageLimit = controller.absoluteStart + controller.textLength;
                        }
                        if(composeToControllerIndex == this.numControllers - 1)
                        {
                           bp = this.rootElement.computedFormat.blockProgression;
                           lastVisibleLine = controller.getLastVisibleLine();
                           if(lastVisibleLine && getBPDirectionScrollPosition(bp,controller) == this.lastBPDirectionScrollPosition)
                           {
                              damageLimit = lastVisibleLine.absoluteStart + lastVisibleLine.textLength;
                           }
                        }
                     }
                  }
                  this.lastBPDirectionScrollPosition = Number.NEGATIVE_INFINITY;
                  if(_damageAbsoluteStart < damageLimit)
                  {
                     startController = this.callTheComposer(composeToPosition,composeToControllerIndex);
                     if(startController)
                     {
                        idx = this.getControllerIndex(startController);
                        while(idx < this.numControllers)
                        {
                           this.getControllerAt(idx++).shapesInvalid = true;
                        }
                     }
                  }
               }
            }
         }
         catch(e:Error)
         {
            _composing = false;
            throw e;
         }
         this._composing = false;
         if(controller && composeToControllerIndex == this.numControllers - 1)
         {
            this.lastBPDirectionScrollPosition = getBPDirectionScrollPosition(bp,controller);
         }
         return startController;
      }
      
      tlf_internal function areShapesDamaged() : Boolean
      {
         var cont:ContainerController = null;
         for each(cont in this._controllerList)
         {
            if(cont.shapesInvalid)
            {
               return true;
            }
         }
         return false;
      }
      
      public function compose() : Boolean
      {
         return !!this._composing ? false : this.internalCompose() != null;
      }
      
      public function composeToPosition(absolutePosition:int = 2147483647) : Boolean
      {
         return !!this._composing ? false : this.internalCompose(absolutePosition,-1) != null;
      }
      
      public function composeToController(index:int = 2147483647) : Boolean
      {
         return !!this._composing ? false : this.internalCompose(-1,index) != null;
      }
      
      tlf_internal function createBackgroundManager() : BackgroundManager
      {
         return new BackgroundManager();
      }
   }
}
