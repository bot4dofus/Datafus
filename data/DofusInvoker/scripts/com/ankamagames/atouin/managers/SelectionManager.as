package com.ankamagames.atouin.managers
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.renderers.ZoneDARenderer;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.atouin.utils.errors.AtouinError;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import flash.utils.getQualifiedClassName;
   
   public class SelectionManager
   {
      
      private static var _self:SelectionManager;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SelectionManager));
       
      
      private var _aSelection:Array;
      
      public function SelectionManager()
      {
         super();
         if(_self)
         {
            throw new AtouinError("SelectionManager is a singleton class. Please acces it through getInstance()");
         }
         this.init();
      }
      
      public static function getInstance() : SelectionManager
      {
         if(!_self)
         {
            _self = new SelectionManager();
         }
         return _self;
      }
      
      public function init() : void
      {
         this._aSelection = new Array();
         Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
      }
      
      public function addSelection(s:Selection, name:String, cellId:uint = 561.0) : void
      {
         if(this._aSelection[name])
         {
            Selection(this._aSelection[name]).remove();
         }
         this._aSelection[name] = s;
         if(cellId != AtouinConstants.MAP_CELLS_COUNT + 1)
         {
            this.update(name,cellId);
         }
      }
      
      public function getSelection(name:String) : Selection
      {
         return this._aSelection[name];
      }
      
      public function update(name:String, cellId:uint = 0, updateStrata:Boolean = false) : void
      {
         var aCell:Vector.<uint> = null;
         var aOldCells:Vector.<uint> = null;
         var s:Selection = this.getSelection(name);
         if(!s)
         {
            return;
         }
         if(s.zone)
         {
            aCell = s.zone.getCells(cellId);
            aOldCells = !s.cells ? null : s.cells.concat();
            s.remove(aOldCells);
            s.cells = aCell;
            if(s.renderer)
            {
               s.update(updateStrata);
            }
            else
            {
               _log.error("No renderer set for selection [" + name + "]");
            }
         }
      }
      
      public function isInside(cellId:uint, selectionName:String) : Boolean
      {
         var s:Selection = this.getSelection(selectionName);
         if(!s)
         {
            return false;
         }
         return s.isInside(cellId);
      }
      
      private function onPropertyChanged(pEvent:PropertyChangeEvent) : void
      {
         var s:Selection = null;
         var renderer:ZoneDARenderer = null;
         if(pEvent.propertyName == "transparentOverlayMode")
         {
            for each(s in this._aSelection)
            {
               renderer = s.renderer as ZoneDARenderer;
               if(renderer && s.visible && !renderer.fixedStrata)
               {
                  if(pEvent.propertyValue == true)
                  {
                     renderer.currentStrata = PlacementStrataEnums.STRATA_NO_Z_ORDER;
                  }
                  else
                  {
                     renderer.restoreStrata();
                  }
                  s.update(true);
               }
            }
         }
      }
      
      private function diff(a1:Vector.<uint>, a2:Vector.<uint>) : Vector.<uint>
      {
         var elem:* = undefined;
         var res:Vector.<uint> = new Vector.<uint>();
         for each(elem in a2)
         {
            if(-1 == a1.indexOf(elem))
            {
               res.push(elem);
            }
         }
         return res;
      }
   }
}
