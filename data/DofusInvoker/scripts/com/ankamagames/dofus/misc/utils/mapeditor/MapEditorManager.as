package com.ankamagames.dofus.misc.utils.mapeditor
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.resources.adapters.ElementsAdapter;
   import com.ankamagames.atouin.resources.adapters.MapsAdapter;
   import com.ankamagames.atouin.types.events.RenderMapEvent;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightCommonInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
   import com.ankamagames.dofus.network.types.game.house.HouseInformations;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
   import com.ankamagames.dofus.network.types.game.interactive.StatedElement;
   import com.ankamagames.jerakine.benchmark.FileLoggerEnum;
   import com.ankamagames.jerakine.benchmark.LogInFile;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.resources.ResourceObserverWrapper;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.getQualifiedClassName;
   import flash.utils.setTimeout;
   
   public class MapEditorManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MapEditorManager));
      
      private static const COLOR_CONNECTED:uint = 12579390;
      
      private static const COLOR_CLOSE:uint = 15892246;
       
      
      private var _mapEditorConnector:MapEditorConnector;
      
      private var _currentPopup:Sprite;
      
      private var _currentNpcInfos:MapComplementaryInformationsDataMessage;
      
      private var _currentRenderId:uint;
      
      private var _lastRenderedId:uint;
      
      public function MapEditorManager()
      {
         super();
         if(BuildInfos.BUILD_TYPE < BuildTypeEnum.INTERNAL)
         {
            return;
         }
         this.init();
      }
      
      private function init() : void
      {
         this._mapEditorConnector = new MapEditorConnector();
         LogInFile.getInstance().logLine("MapEditorManager _mapEditorConnector.addEventListener onNewData",FileLoggerEnum.EVENTLISTENERS);
         LogInFile.getInstance().logLine("MapEditorManager _mapEditorConnector.addEventListener onConnect",FileLoggerEnum.EVENTLISTENERS);
         LogInFile.getInstance().logLine("MapEditorManager _mapEditorConnector.addEventListener onClose",FileLoggerEnum.EVENTLISTENERS);
         LogInFile.getInstance().logLine("MapEditorManager _mapEditorConnector.addEventListener onDataProgress",FileLoggerEnum.EVENTLISTENERS);
         this._mapEditorConnector.addEventListener(MapEditorDataEvent.NEW_DATA,this.onNewData);
         this._mapEditorConnector.addEventListener(Event.CONNECT,this.onConnect);
         this._mapEditorConnector.addEventListener(Event.CLOSE,this.onClose);
         this._mapEditorConnector.addEventListener(ProgressEvent.SOCKET_DATA,this.onDataProgress);
      }
      
      private function displayPopup(txt:String, color:uint, autoClose:Boolean = false) : void
      {
         if(this._currentPopup)
         {
            this.closePopup();
         }
         this._currentPopup = new Sprite();
         this._currentPopup.mouseChildren = false;
         this._currentPopup.addEventListener(MouseEvent.CLICK,this.closePopup);
         var tf:TextField = new TextField();
         tf.defaultTextFormat = new TextFormat("Verdana",12,0,true);
         tf.autoSize = TextFieldAutoSize.LEFT;
         tf.height = 30;
         tf.text = txt;
         this._currentPopup.addChild(tf);
         this._currentPopup.graphics.beginFill(color);
         this._currentPopup.graphics.lineStyle(1,6710886);
         this._currentPopup.graphics.drawRect(-5,-5,20 + tf.textWidth,tf.height + 10);
         this._currentPopup.graphics.endFill();
         StageShareManager.stage.addChild(this._currentPopup);
         this._currentPopup.x = (StageShareManager.startWidth - tf.textWidth) / 2;
         this._currentPopup.y = 10;
         if(autoClose)
         {
            setTimeout(this.closePopup,5000,null,this._currentPopup);
         }
      }
      
      private function closePopup(e:Event = null, currentPopup:Sprite = null) : void
      {
         if(!currentPopup)
         {
            currentPopup = this._currentPopup;
         }
         if(!currentPopup)
         {
            return;
         }
         currentPopup.removeEventListener(MouseEvent.CLICK,this.closePopup);
         if(currentPopup.parent)
         {
            currentPopup.parent.removeChild(currentPopup);
         }
         if(currentPopup == this._currentPopup)
         {
            this._currentPopup = null;
         }
      }
      
      private function onNewData(e:MapEditorDataEvent) : void
      {
         var ma:MapsAdapter = null;
         var ea:ElementsAdapter = null;
         var mapId:Number = NaN;
         var npcCount:uint = 0;
         var npcInfos:Vector.<GameRolePlayActorInformations> = null;
         var mciMsg:MapComplementaryInformationsDataMessage = null;
         var subArea:SubArea = null;
         var npcInd:uint = 0;
         var npcInfo:GameRolePlayNpcInformations = null;
         var cellId:int = 0;
         var npcId:int = 0;
         var direction:int = 0;
         var entityDisposition:EntityDispositionInformations = null;
         LogInFile.getInstance().logLine("MapEditorManager onNewData",FileLoggerEnum.EVENTLISTENERS);
         this.displayPopup("Données provenant de l\'éditeur " + e.data.type,COLOR_CONNECTED);
         switch(e.data.type)
         {
            case MapEditorMessage.MESSAGE_TYPE_DLM:
               this.displayPopup("Rendu d\'une map provenant de l\'éditeur",COLOR_CONNECTED);
               _log.info("Rendu d\'une map provenant de l\'éditeur");
               ma = new MapsAdapter();
               ma.loadFromData(new Uri(),e.data.data,new ResourceObserverWrapper(this.onDmlLoaded),false);
               break;
            case MapEditorMessage.MESSAGE_TYPE_ELE:
               this.displayPopup("Donnée sur les éléments",COLOR_CONNECTED);
               _log.info("Parsing du fichier .ele provenant de l\'éditeur");
               ea = new ElementsAdapter();
               ea.loadFromData(new Uri(),e.data.data,new ResourceObserverWrapper(),false);
               break;
            case MapEditorMessage.MESSAGE_TYPE_NPC:
               mapId = e.data.data.readInt();
               npcCount = e.data.data.readInt();
               npcInfos = new Vector.<GameRolePlayActorInformations>();
               for(npcInd = 0; npcInd < npcCount; npcInd++)
               {
                  npcInfo = new GameRolePlayNpcInformations();
                  cellId = e.data.data.readShort();
                  npcId = e.data.data.readInt();
                  direction = e.data.data.readByte();
                  entityDisposition = new EntityDispositionInformations();
                  entityDisposition.initEntityDispositionInformations(cellId,direction);
                  npcInfo.initGameRolePlayNpcInformations(npcId,entityDisposition,EntityLookAdapter.toNetwork(TiphonEntityLook.fromString(Npc.getNpcById(npcId).look)),npcId);
                  npcInfos.push(npcInfo);
               }
               mciMsg = new MapComplementaryInformationsDataMessage();
               subArea = SubArea.getSubAreaByMapId(mapId);
               mciMsg.initMapComplementaryInformationsDataMessage(!!subArea ? uint(subArea.id) : uint(0),mapId,new Vector.<HouseInformations>(),npcInfos,new Vector.<InteractiveElement>(),new Vector.<StatedElement>(),new Vector.<MapObstacle>(),new Vector.<FightCommonInformations>());
               if(this._lastRenderedId == MapDisplayManager.getInstance().currentRenderId)
               {
                  Kernel.getWorker().process(mciMsg);
                  this._currentNpcInfos = null;
               }
               else
               {
                  this._currentNpcInfos = mciMsg;
               }
               break;
            case MapEditorMessage.MESSAGE_TYPE_HELLO:
               this.displayPopup("Hello Alea",COLOR_CONNECTED);
         }
      }
      
      private function onMapRenderEnd(e:RenderMapEvent) : void
      {
         this._lastRenderedId = e.renderId;
         if(e.renderId == this._currentRenderId)
         {
            Atouin.getInstance().loadElementsFile();
            if(this._currentNpcInfos)
            {
               Kernel.getWorker().process(this._currentNpcInfos);
               this._currentNpcInfos = null;
            }
         }
         this.displayPopup("Taille des picto : " + StringUtils.formateIntToString(uint(MapDisplayManager.getInstance().renderer.gfxMemorySize / 1024)) + " Ko",COLOR_CONNECTED);
      }
      
      private function onDmlLoaded(uri:Uri, resourceType:uint, resource:*) : void
      {
         MapDisplayManager.getInstance().renderer.useDefautState = true;
         var map:Map = new Map();
         map.fromRaw(resource);
         this._currentRenderId = MapDisplayManager.getInstance().fromMap(map);
      }
      
      private function onConnect(e:Event) : void
      {
         LogInFile.getInstance().logLine("MapEditorManager onConnect",FileLoggerEnum.EVENTLISTENERS);
         this.displayPopup("Connecté à l\'éditeur",COLOR_CONNECTED);
         _log.info("Connecté à l\'éditeur de map");
         MapDisplayManager.getInstance().renderer.addEventListener(RenderMapEvent.MAP_RENDER_END,this.onMapRenderEnd);
      }
      
      private function onDataProgress(e:Event) : void
      {
         LogInFile.getInstance().logLine("MapEditorManager onDataProgress",FileLoggerEnum.EVENTLISTENERS);
         this.displayPopup("Réception de données",COLOR_CONNECTED);
         _log.info("Réception de données");
      }
      
      private function onClose(e:Event) : void
      {
         LogInFile.getInstance().logLine("MapEditorManager onClose",FileLoggerEnum.EVENTLISTENERS);
         this.displayPopup("Connexion à l\'éditeur de map perdue",COLOR_CLOSE);
         _log.info("Connexion à l\'éditeur de map perdue");
         MapDisplayManager.getInstance().renderer.removeEventListener(RenderMapEvent.MAP_RENDER_END,this.onMapRenderEnd);
      }
   }
}
