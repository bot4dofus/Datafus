package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.atouin.messages.CellOutMessage;
   import com.ankamagames.atouin.messages.CellOverMessage;
   import com.ankamagames.atouin.renderers.ZoneDARenderer;
   import com.ankamagames.atouin.types.GraphicCell;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.messages.game.context.ShowCellRequestMessage;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.messages.EntityClickMessage;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.zones.Cross;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.getQualifiedClassName;
   
   public class PointCellFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PointCellFrame));
      
      private static var _instance:PointCellFrame;
      
      private static const TARGET_COLOR:Color = new Color(16548386);
      
      private static const SELECTION_TARGET:String = "SpellCastTarget";
      
      private static const LINKED_CURSOR_NAME:String = "PointCellFrame_Pointer";
       
      
      private var _targetSelection:Selection;
      
      private var _InteractiveCellManager_click:Boolean;
      
      private var _InteractiveCellManager_over:Boolean;
      
      private var _InteractiveCellManager_out:Boolean;
      
      private var _freeCellOnly:Boolean;
      
      private var _callBack:Function;
      
      private var _customCellValidatorFct:Function;
      
      private var _entitiesFrame:AbstractEntitiesFrame;
      
      private var _untargetableEntities:Boolean;
      
      private var _untargetableEntitiesBackup:Boolean;
      
      public function PointCellFrame()
      {
         super();
      }
      
      public static function getInstance() : PointCellFrame
      {
         if(_instance == null)
         {
            _instance = new PointCellFrame();
         }
         return _instance;
      }
      
      public function get priority() : int
      {
         return Priority.ULTIMATE_HIGHEST_DEPTH_OF_DOOM;
      }
      
      public function pushed() : Boolean
      {
         _instance = this;
         this._InteractiveCellManager_click = InteractiveCellManager.getInstance().cellClickEnabled;
         this._InteractiveCellManager_over = InteractiveCellManager.getInstance().cellOverEnabled;
         this._InteractiveCellManager_out = InteractiveCellManager.getInstance().cellOutEnabled;
         InteractiveCellManager.getInstance().setInteraction(true,true,true);
         return true;
      }
      
      public function setPointCellParameters(callBack:Function = null, cursorIcon:Sprite = null, freeCellOnly:Boolean = false, customCellValidatorFct:Function = null, untargetableEntities:Boolean = false) : void
      {
         var lkd:LinkedCursorData = null;
         if(Kernel.getWorker().getFrame(RoleplayEntitiesFrame))
         {
            this._entitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         }
         else
         {
            this._entitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         }
         this._callBack = callBack;
         this._freeCellOnly = freeCellOnly;
         this._customCellValidatorFct = customCellValidatorFct;
         this._untargetableEntities = untargetableEntities;
         this._untargetableEntitiesBackup = this._entitiesFrame.untargetableEntities;
         this._entitiesFrame.untargetableEntities = this._untargetableEntities;
         if(cursorIcon)
         {
            lkd = new LinkedCursorData();
            lkd.sprite = cursorIcon;
            lkd.offset = new Point(-20,-20);
            LinkedCursorSpriteManager.getInstance().addItem(LINKED_CURSOR_NAME,lkd);
         }
      }
      
      public function process(msg:Message) : Boolean
      {
         var kkumsg:KeyboardKeyUpMessage = null;
         var conmsg:CellOverMessage = null;
         var emomsg:EntityMouseOverMessage = null;
         var ccmsg:CellClickMessage = null;
         var ecmsg:EntityClickMessage = null;
         var mcmsg:MouseClickMessage = null;
         switch(true)
         {
            case msg is KeyboardKeyUpMessage:
               kkumsg = msg as KeyboardKeyUpMessage;
               if(kkumsg.keyboardEvent.keyCode == 27)
               {
                  this.cancelShow();
                  return true;
               }
               return false;
               break;
            case msg is CellOverMessage:
               conmsg = msg as CellOverMessage;
               this.refreshTarget(conmsg.cellId);
               return true;
            case msg is CellOutMessage:
               this.refreshTarget(-1);
               return true;
            case msg is EntityMouseOverMessage:
               emomsg = msg as EntityMouseOverMessage;
               this.refreshTarget(emomsg.entity.position.cellId);
               return false;
            case msg is CellClickMessage:
               ccmsg = msg as CellClickMessage;
               this.showCell(ccmsg.cellId);
               return true;
            case msg is EntityClickMessage:
               ecmsg = msg as EntityClickMessage;
               this.showCell(ecmsg.entity.position.cellId,ecmsg.entity.id);
               return true;
            case msg is AdjacentMapClickMessage:
               this.cancelShow();
               if(this._callBack != null)
               {
                  this._callBack(false,0,-1);
               }
               return true;
            case msg is MouseClickMessage:
               mcmsg = msg as MouseClickMessage;
               if(mcmsg.target is GraphicCell || mcmsg.target is TiphonSprite)
               {
                  return false;
               }
               this.cancelShow();
               if(this._callBack != null)
               {
                  this._callBack(false,0,-1);
               }
               return false;
               break;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         _instance = null;
         this.removeTarget();
         LinkedCursorSpriteManager.getInstance().removeItem(LINKED_CURSOR_NAME);
         InteractiveCellManager.getInstance().setInteraction(this._InteractiveCellManager_click,this._InteractiveCellManager_over,this._InteractiveCellManager_out);
         if(this._entitiesFrame)
         {
            this._entitiesFrame.untargetableEntities = this._untargetableEntitiesBackup;
         }
         if(this._callBack != null)
         {
            this._callBack(false,0,-1);
         }
         this._callBack = null;
         this._freeCellOnly = false;
         this._customCellValidatorFct = null;
         this._untargetableEntities = false;
         return true;
      }
      
      private function refreshTarget(target:int) : void
      {
         var entity:IEntity = null;
         if(target != -1 && this.isValidCell(target))
         {
            if(!this._targetSelection)
            {
               this._targetSelection = new Selection();
               this._targetSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_NO_Z_ORDER);
               this._targetSelection.color = TARGET_COLOR;
               this._targetSelection.zone = new Cross(0,0,DataMapProvider.getInstance());
               SelectionManager.getInstance().addSelection(this._targetSelection,SELECTION_TARGET);
            }
            entity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
            if(!entity)
            {
               return;
            }
            this._targetSelection.zone.direction = MapPoint(entity.position).advancedOrientationTo(MapPoint.fromCellId(target));
            SelectionManager.getInstance().update(SELECTION_TARGET,target);
         }
         else
         {
            this.removeTarget();
         }
      }
      
      private function removeTarget() : void
      {
         var s:Selection = SelectionManager.getInstance().getSelection(SELECTION_TARGET);
         if(s)
         {
            s.remove();
            this._targetSelection = null;
         }
      }
      
      private function showCell(cell:uint, entityId:Number = -1) : void
      {
         var scrmsg:ShowCellRequestMessage = null;
         if(this.isValidCell(cell))
         {
            if(this._callBack != null)
            {
               this._callBack(true,cell,entityId);
            }
            else
            {
               scrmsg = new ShowCellRequestMessage();
               scrmsg.initShowCellRequestMessage(cell);
               ConnectionsHandler.getConnection().send(scrmsg);
            }
         }
         this.cancelShow();
      }
      
      public function cancelShow() : void
      {
         this.removeTarget();
         KernelEventsManager.getInstance().processCallback(HookList.ShowCell);
         Kernel.getWorker().removeFrame(this);
      }
      
      private function isValidCell(cell:uint) : Boolean
      {
         if(this._customCellValidatorFct != null)
         {
            return this._customCellValidatorFct(cell);
         }
         return DataMapProvider.getInstance().pointMov(MapPoint.fromCellId(cell).x,MapPoint.fromCellId(cell).y,true) && (!this._freeCellOnly || EntitiesManager.getInstance().getEntityOnCell(cell) == null);
      }
   }
}
