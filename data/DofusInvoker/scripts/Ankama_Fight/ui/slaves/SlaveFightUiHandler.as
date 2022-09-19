package Ankama_Fight.ui.slaves
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.event.UiUnloadEvent;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class SlaveFightUiHandler
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(SlaveFightUiHandler));
       
      
      private var _uis:Vector.<UiRootContainer>;
      
      private var _slaveIdUiIdMap:Dictionary;
      
      private var _uiApi:UiApi = null;
      
      public function SlaveFightUiHandler(uiApi:UiApi)
      {
         this._uis = new Vector.<UiRootContainer>(0);
         this._slaveIdUiIdMap = new Dictionary();
         super();
         this._uiApi = uiApi;
         Berilia.getInstance().addEventListener(UiUnloadEvent.UNLOAD_UI_STARTED,this.onUiUnloadStarted);
         _log.debug("Slave fight UI handler loaded.");
      }
      
      public function unload() : void
      {
         this.clearUis();
         Berilia.getInstance().removeEventListener(UiUnloadEvent.UNLOAD_UI_STARTED,this.onUiUnloadStarted);
         _log.debug("Slave fight UI handler unloaded.");
      }
      
      public function addUi(entityId:Number) : void
      {
         var uiId:uint = this.getFirstUiIdAvailable();
         var uiDescr:SlaveFightUiDescr = new SlaveFightUiDescr(uiId,entityId);
         var uiRootContainer:UiRootContainer = this._uiApi.loadUi(UIEnum.SLAVE_FIGHT_UI,SlaveFightUi.getUiInstanceNameFromId(uiId),uiDescr,StrataEnum.STRATA_TOP,null,true);
         if(uiId >= this._uis.length)
         {
            this._uis.push(uiRootContainer);
         }
         else
         {
            this._uis[uiId] = uiRootContainer;
         }
         this._slaveIdUiIdMap[entityId] = uiId;
      }
      
      public function removeUi(uiId:uint) : Boolean
      {
         if(!this.isUiLoaded(uiId))
         {
            return false;
         }
         this._uiApi.unloadUi(SlaveFightUi.getUiInstanceNameFromId(uiId));
         return true;
      }
      
      public function clearUis() : void
      {
         for(var uiId:uint = 0; uiId < this._uis.length; uiId++)
         {
            if(this._uis[uiId] !== null)
            {
               if(!this.removeUi(uiId))
               {
                  _log.error("Could not remove slave fight UI with ID: " + uiId.toString());
               }
            }
         }
      }
      
      public function isUiLoaded(uiId:uint) : Boolean
      {
         return uiId < this._uis.length && this._uis[uiId] !== null;
      }
      
      public function getUiIdFromSlaveId(slaveId:Number) : uint
      {
         if(slaveId in this._slaveIdUiIdMap)
         {
            return this._slaveIdUiIdMap[slaveId];
         }
         return SlaveFightUi.INVALID_UI_ID;
      }
      
      private function getFirstUiIdAvailable() : uint
      {
         var index:uint = 0;
         while(index < this._uis.length)
         {
            if(this._uis[index] === null)
            {
               return index;
            }
            index++;
         }
         return this._uis.length;
      }
      
      private function onUiUnloadStarted(event:UiUnloadEvent) : void
      {
         if(event.name === null || event.name.indexOf(SlaveFightUi.SLAVE_UI_NAME_PREFIX) === -1)
         {
            return;
         }
         var uiId:uint = uint(event.name.substr(SlaveFightUi.SLAVE_UI_NAME_PREFIX.length));
         if(isNaN(uiId))
         {
            _log.error("Unable to retrieve Slave Fight UI ID with UI name " + event.name + ". ID is " + uiId + "!");
            return;
         }
         if(uiId >= this._uis.length)
         {
            return;
         }
         var uiRootContainer:UiRootContainer = this._uis[uiId];
         if(uiRootContainer !== null)
         {
            delete this._slaveIdUiIdMap[(uiRootContainer.uiClass as SlaveFightUi).slaveId];
         }
         else
         {
            _log.error("Unable to handle Slave Fight UI unload with UI name " + event.name + " and parsed ID " + uiId + "!");
         }
         this._uis[uiId] = null;
      }
   }
}
