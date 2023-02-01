package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.data.map.CellData;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.FrustumManager;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
   import com.ankamagames.atouin.messages.AdjacentMapOutMessage;
   import com.ankamagames.atouin.messages.AdjacentMapOverMessage;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.atouin.renderers.ZoneDARenderer;
   import com.ankamagames.atouin.types.FrustumShape;
   import com.ankamagames.atouin.types.GraphicCell;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.atouin.utils.CellIdConverter;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.factories.MenusFactory;
   import com.ankamagames.berilia.frames.ShortcutsFrame;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.datacenter.interactives.Interactive;
   import com.ankamagames.dofus.datacenter.interactives.Sign;
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.dofus.datacenter.npcs.NpcAction;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
   import com.ankamagames.dofus.datacenter.world.Area;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.breach.BreachBranchWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.actions.EmptyStackAction;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFightJoinRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeOnHumanVendorRequestAction;
   import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
   import com.ankamagames.dofus.logic.game.common.frames.BreachFrame;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowAllNamesAction;
   import com.ankamagames.dofus.logic.game.fight.frames.FightPreparationFrame;
   import com.ankamagames.dofus.logic.game.roleplay.actions.NpcGenericActionRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShowEntitiesTooltipsAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShowFightPositionsAction;
   import com.ankamagames.dofus.logic.game.roleplay.managers.MountAutoTripManager;
   import com.ankamagames.dofus.logic.game.roleplay.managers.RoleplayManager;
   import com.ankamagames.dofus.logic.game.roleplay.managers.SkillManager;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementActivationMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementMouseOutMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementMouseOverMessage;
   import com.ankamagames.dofus.logic.game.roleplay.types.CharacterTooltipInformation;
   import com.ankamagames.dofus.logic.game.roleplay.types.FightTeam;
   import com.ankamagames.dofus.logic.game.roleplay.types.GameContextPaddockItemInformations;
   import com.ankamagames.dofus.logic.game.roleplay.types.MutantTooltipInformation;
   import com.ankamagames.dofus.logic.game.roleplay.types.PortalTooltipInformation;
   import com.ankamagames.dofus.logic.game.roleplay.types.PrismTooltipInformation;
   import com.ankamagames.dofus.logic.game.roleplay.types.RoleplayTeamFightersTooltipInformation;
   import com.ankamagames.dofus.logic.game.roleplay.types.TaxCollectorTooltipInformation;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.network.enums.TeamTypeEnum;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightJoinRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapFightStartPositionsUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseKickIndoorMerchantRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyInvitationRequestMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeOnHumanVendorRequestMessage;
   import com.ankamagames.dofus.network.types.common.PlayerSearchCharacterNameInformation;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.GameRolePlayTaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.context.TaxCollectorStaticExtendedInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightStartingPositions;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberTaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterWaveInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMutantInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNamedActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPortalInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayPrismInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayTreasureHintInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GroupMonsterStaticInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupLightInformations;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElementSkill;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
   import com.ankamagames.dofus.uiApi.RoleplayApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.interfaces.IInteractive;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.entities.messages.EntityClickMessage;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import com.ankamagames.jerakine.enum.OptionEnum;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.CursorSpriteManager;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.messages.events.FramePushedEvent;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.jerakine.utils.display.Rectangle2;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class RoleplayWorldFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayWorldFrame));
      
      private static const NO_CURSOR:int = -1;
      
      private static const FIGHT_CURSOR:int = 3;
      
      private static const NPC_CURSOR:int = 1;
      
      private static const DIRECTIONAL_PANEL_ID:int = 316;
      
      private static var _entitiesTooltipsFrame:EntitiesTooltipsFrame = new EntitiesTooltipsFrame();
       
      
      private const _common:String = XmlConfig.getInstance().getEntry("config.ui.skin");
      
      private var _mouseLabel:Label;
      
      private var _mouseTop:Texture;
      
      private var _mouseBottom:Texture;
      
      private var _mouseRight:Texture;
      
      private var _mouseLeft:Texture;
      
      private var _mouseTopBlue:Texture;
      
      private var _mouseBottomBlue:Texture;
      
      private var _mouseRightBlue:Texture;
      
      private var _mouseLeftBlue:Texture;
      
      private var _texturesReady:Boolean;
      
      private var _playerEntity:AnimatedCharacter;
      
      private var _playerName:String;
      
      private var _allowOnlyCharacterInteraction:Boolean;
      
      public var cellClickEnabled:Boolean;
      
      private var _infoEntitiesFrame:InfoEntitiesFrame;
      
      private var _mouseOverEntityId:Number;
      
      private var sysApi:SystemApi;
      
      private var _entityTooltipData:Dictionary;
      
      private var _redColor:String;
      
      private var _mouseDown:Boolean;
      
      private var _roleplayApi:RoleplayApi;
      
      private var _socialApi:SocialApi;
      
      private var _fightPositions:FightStartingPositions;
      
      private var _fightPositionsVisible:Boolean;
      
      public var pivotingCharacter:Boolean;
      
      public function RoleplayWorldFrame()
      {
         this._infoEntitiesFrame = new InfoEntitiesFrame();
         this.sysApi = new SystemApi();
         this._entityTooltipData = new Dictionary();
         this._roleplayApi = new RoleplayApi();
         this._socialApi = new SocialApi();
         super();
      }
      
      public function get mouseOverEntityId() : Number
      {
         return this._mouseOverEntityId;
      }
      
      public function set allowOnlyCharacterInteraction(pAllow:Boolean) : void
      {
         this._allowOnlyCharacterInteraction = pAllow;
      }
      
      public function get allowOnlyCharacterInteraction() : Boolean
      {
         return this._allowOnlyCharacterInteraction;
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      private function get roleplayContextFrame() : RoleplayContextFrame
      {
         return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
      }
      
      private function get roleplayMovementFrame() : RoleplayMovementFrame
      {
         return Kernel.getWorker().getFrame(RoleplayMovementFrame) as RoleplayMovementFrame;
      }
      
      public function pushed() : Boolean
      {
         FrustumManager.getInstance().setBorderInteraction(true);
         this._allowOnlyCharacterInteraction = false;
         this.cellClickEnabled = true;
         this.pivotingCharacter = false;
         var shortcutsFrame:ShortcutsFrame = Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame;
         if(shortcutsFrame.heldShortcuts.indexOf("showEntitiesTooltips") != -1 && !Kernel.getWorker().contains(EntitiesTooltipsFrame))
         {
            if(Kernel.getWorker().contains(RoleplayEntitiesFrame))
            {
               Kernel.getWorker().addFrame(_entitiesTooltipsFrame);
            }
            else
            {
               Kernel.getWorker().addEventListener(FramePushedEvent.EVENT_FRAME_PUSHED,this.onFramePushed);
            }
         }
         else if(Kernel.getWorker().contains(EntitiesTooltipsFrame))
         {
            Kernel.getWorker().removeFrame(_entitiesTooltipsFrame);
         }
         StageShareManager.stage.addEventListener(Event.DEACTIVATE,this.onWindowDeactivate);
         if(this._texturesReady)
         {
            return true;
         }
         this._mouseBottom = new Texture();
         this._mouseBottom.uri = new Uri(this._common + "assets.swf|cursorBottom");
         this._mouseBottom.finalize();
         this._mouseTop = new Texture();
         this._mouseTop.uri = new Uri(this._common + "assets.swf|cursorTop");
         this._mouseTop.finalize();
         this._mouseRight = new Texture();
         this._mouseRight.uri = new Uri(this._common + "assets.swf|cursorRight");
         this._mouseRight.finalize();
         this._mouseLeft = new Texture();
         this._mouseLeft.uri = new Uri(this._common + "assets.swf|cursorLeft");
         this._mouseLeft.finalize();
         this._mouseBottomBlue = new Texture();
         this._mouseBottomBlue.uri = new Uri(this._common + "assets.swf|cursorBottomBlue");
         this._mouseBottomBlue.finalize();
         this._mouseTopBlue = new Texture();
         this._mouseTopBlue.uri = new Uri(this._common + "assets.swf|cursorTopBlue");
         this._mouseTopBlue.finalize();
         this._mouseRightBlue = new Texture();
         this._mouseRightBlue.uri = new Uri(this._common + "assets.swf|cursorRightBlue");
         this._mouseRightBlue.finalize();
         this._mouseLeftBlue = new Texture();
         this._mouseLeftBlue.uri = new Uri(this._common + "assets.swf|cursorLeftBlue");
         this._mouseLeftBlue.finalize();
         this._mouseLabel = new Label();
         this._mouseLabel.css = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "css/normal.css");
         this._texturesReady = true;
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var sf:ShortcutsFrame = null;
         var breachFrame:BreachFrame = null;
         var amomsg:AdjacentMapOverMessage = null;
         var targetCell:Point = null;
         var cellSprite:GraphicCell = null;
         var cellGlobalPos:Point = null;
         var item:LinkedCursorData = null;
         var worldPoint:WorldPointWrapper = null;
         var neighborId:Number = NaN;
         var neighborSubarea:SubArea = null;
         var subareaChange:Boolean = false;
         var x:int = 0;
         var y:int = 0;
         var info:String = null;
         var text:String = null;
         var text2:String = null;
         var text3:String = null;
         var zoneBound:Rectangle = null;
         var mcidmsg:MapComplementaryInformationsDataMessage = null;
         var mousePos:Point = null;
         var mfspmsg:MapFightStartPositionsUpdateMessage = null;
         var emomsg:EntityMouseOverMessage = null;
         var tooltipName:String = null;
         var entity:IInteractive = null;
         var animatedCharacter:AnimatedCharacter = null;
         var infos:* = undefined;
         var npcEntity:Npc = null;
         var targetBounds:IRectangle = null;
         var tooltipMaker:String = null;
         var cacheName:String = null;
         var tooltipOffset:Number = NaN;
         var mrcmsg:MouseRightClickMessage = null;
         var modContextMenu:Object = null;
         var menu:Object = null;
         var rightClickedEntity:IInteractive = null;
         var rpInteractivesFrame:RoleplayInteractivesFrame = null;
         var rightClickedInteractiveElement:InteractiveElement = null;
         var roleplayEntitiesFrame2:RoleplayEntitiesFrame = null;
         var emoutmsg:EntityMouseOutMessage = null;
         var ecmsg:EntityClickMessage = null;
         var entityc:IInteractive = null;
         var entityClickInfo:GameContextActorInformations = null;
         var npcInfo:GameRolePlayNpcInformations = null;
         var menuResult:Boolean = false;
         var sendInteractiveUseRequest:Boolean = false;
         var ieamsg:InteractiveElementActivationMessage = null;
         var interactiveFrame:RoleplayInteractivesFrame = null;
         var iemovmsg:InteractiveElementMouseOverMessage = null;
         var infosIe:Object = null;
         var ttMaker:String = null;
         var tooltipCacheName:String = null;
         var interactiveElem:InteractiveElement = null;
         var interactiveSkill:InteractiveElementSkill = null;
         var interactive:Interactive = null;
         var elementId:uint = 0;
         var roleplayEntitiesFrame:RoleplayEntitiesFrame = null;
         var houseWrapper:HouseWrapper = null;
         var isDirectionalPanel:Boolean = false;
         var iemomsg:InteractiveElementMouseOutMessage = null;
         var seta:ShowEntitiesTooltipsAction = null;
         var sfpa:ShowFightPositionsAction = null;
         var mum:MouseUpMessage = null;
         var climsg:CellClickMessage = null;
         var sq:SerialSequencer = null;
         var amcmsg:AdjacentMapClickMessage = null;
         var playedEntity:IEntity = null;
         var currentSubarea:SubArea = null;
         var target2:Rectangle = null;
         var tooltipData:TextTooltipInfo = null;
         var objectsUnder:Array = null;
         var o:DisplayObject = null;
         var oContainer:DisplayObjectContainer = null;
         var tooltipTarget:TiphonSprite = null;
         var rider:TiphonSprite = null;
         var isCreatureMode:Boolean = false;
         var head:DisplayObject = null;
         var r1:Rectangle = null;
         var r2:Rectangle2 = null;
         var p:Point = null;
         var fight:FightTeam = null;
         var allianceInfos:AllianceInformations = null;
         var levelDiffInfo:int = 0;
         var grtci:GameRolePlayTaxCollectorInformations = null;
         var guildtcinfos:GuildInformations = null;
         var gwtc:GuildWrapper = null;
         var awtc:AllianceWrapper = null;
         var npcInfos:GameRolePlayNpcInformations = null;
         var npc:Npc = null;
         var allianceFrame:AllianceFrame = null;
         var treasureHintInfos:GameRolePlayTreasureHintInformations = null;
         var npch:Npc = null;
         var targetLevel:uint = 0;
         var monster:MonsterInGroupLightInformations = null;
         var monstersInfo:Vector.<MonsterInGroupLightInformations> = null;
         var grpgmwi:GameRolePlayGroupMonsterWaveInformations = null;
         var currentBranch:BreachBranchWrapper = null;
         var waveInfo:GroupMonsterStaticInformations = null;
         var rcf:RoleplayContextFrame = null;
         var actorInfos:GameContextActorInformations = null;
         var rightClickedinfos:GameContextActorInformations = null;
         var houseWrapper2:HouseWrapper = null;
         var linkType:String = null;
         var linkParams:Object = null;
         var prismInfo:GameRolePlayPrismInformations = null;
         var prismName:String = null;
         var taxCollectorInfo:GameRolePlayTaxCollectorInformations = null;
         var npcActions:Vector.<uint> = null;
         var ngara:NpcGenericActionRequestAction = null;
         var fightId:uint = 0;
         var fightTeamLeader:Number = NaN;
         var teamType:uint = 0;
         var gfjrmsg:GameFightJoinRequestMessage = null;
         var playerEntity3:IEntity = null;
         var guildId:int = 0;
         var team:FightTeam = null;
         var fighter:FightTeamMemberInformations = null;
         var guild:GuildWrapper = null;
         var playerEntity:IEntity = null;
         var forbiddenCellsIds:Array = null;
         var i:int = 0;
         var j:int = 0;
         var mp:MapPoint = null;
         var mp2:MapPoint = null;
         var cells:Vector.<CellData> = null;
         var cellData:CellData = null;
         var dmp:DataMapProvider = null;
         var nearestCell:MapPoint = null;
         var ieCellData:CellData = null;
         var skills:Vector.<InteractiveElementSkill> = null;
         var minimalRange:int = 0;
         var skillForRange:InteractiveElementSkill = null;
         var distanceElementToPlayer:int = 0;
         var forbidden:Boolean = false;
         var numWalkableCells:uint = 0;
         var skillData:Skill = null;
         var iRange:int = 0;
         var foundDuplicate:Boolean = false;
         var interactiveSkill2:InteractiveElementSkill = null;
         var firstBoss:Boolean = false;
         var breachBranchInfo:* = null;
         var bossInfo:MonsterInGroupLightInformations = null;
         var element:Object = null;
         var elem:Object = null;
         var target:Rectangle = null;
         switch(true)
         {
            case msg is CellClickMessage:
               if(this.pivotingCharacter)
               {
                  return false;
               }
               if(!(msg as CellClickMessage).fromAutotrip)
               {
                  MountAutoTripManager.getInstance().stopCurrentTrip();
               }
               if(this.allowOnlyCharacterInteraction)
               {
                  return false;
               }
               if(this.cellClickEnabled)
               {
                  climsg = msg as CellClickMessage;
                  try
                  {
                     sq = new SerialSequencer();
                     sq.addStep(new AddGfxEntityStep(3506,climsg.cellId));
                     sq.start();
                  }
                  catch(e:Error)
                  {
                  }
                  (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).currentEmoticon = 0;
                  this.roleplayMovementFrame.resetNextMoveMapChange();
                  this.roleplayMovementFrame.setFollowingInteraction(null);
                  this.roleplayMovementFrame.askMoveTo(MapPoint.fromCellId(climsg.cellId));
               }
               return true;
               break;
            case msg is AdjacentMapClickMessage:
               if(this.allowOnlyCharacterInteraction)
               {
                  return false;
               }
               if(!(msg as AdjacentMapClickMessage).fromAutotrip)
               {
                  MountAutoTripManager.getInstance().stopCurrentTrip();
               }
               if(this.cellClickEnabled)
               {
                  amcmsg = msg as AdjacentMapClickMessage;
                  playedEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                  if(!playedEntity)
                  {
                     _log.warn("The player tried to move before its character was added to the scene. Aborting.");
                     return false;
                  }
                  this.roleplayMovementFrame.setNextMoveMapChange(amcmsg.adjacentMapId,(msg as AdjacentMapClickMessage).fromAutotrip);
                  if(!playedEntity.position.equals(MapPoint.fromCellId(amcmsg.cellId)))
                  {
                     this.roleplayMovementFrame.setFollowingInteraction(null);
                     this.roleplayMovementFrame.askMoveTo(MapPoint.fromCellId(amcmsg.cellId));
                  }
                  else
                  {
                     this.roleplayMovementFrame.setFollowingInteraction(null);
                     this.roleplayMovementFrame.askMapChange();
                  }
               }
               return true;
               break;
            case msg is AdjacentMapOutMessage:
               if(this.allowOnlyCharacterInteraction)
               {
                  return false;
               }
               TooltipManager.hide("subareaChange");
               LinkedCursorSpriteManager.getInstance().removeItem("changeMapCursor");
               return true;
               break;
            case msg is AdjacentMapOverMessage:
               if(this.allowOnlyCharacterInteraction)
               {
                  return false;
               }
               amomsg = AdjacentMapOverMessage(msg);
               targetCell = CellIdConverter.cellIdToCoord(amomsg.cellId);
               cellSprite = InteractiveCellManager.getInstance().getCell(amomsg.cellId);
               cellGlobalPos = cellSprite.parent.localToGlobal(new Point(cellSprite.x,cellSprite.y));
               item = new LinkedCursorData();
               if(PlayedCharacterManager.getInstance().currentMap.leftNeighbourId == -1 && PlayedCharacterManager.getInstance().currentMap.rightNeighbourId == -1 && PlayedCharacterManager.getInstance().currentMap.topNeighbourId == -1 && PlayedCharacterManager.getInstance().currentMap.bottomNeighbourId == -1)
               {
                  worldPoint = new WorldPointWrapper(MapDisplayManager.getInstance().getDataMapContainer().id);
               }
               else
               {
                  worldPoint = PlayedCharacterManager.getInstance().currentMap;
               }
               if(amomsg.direction == DirectionsEnum.RIGHT)
               {
                  neighborId = worldPoint.rightNeighbourId;
               }
               else if(amomsg.direction == DirectionsEnum.DOWN)
               {
                  neighborId = worldPoint.bottomNeighbourId;
               }
               else if(amomsg.direction == DirectionsEnum.LEFT)
               {
                  neighborId = worldPoint.leftNeighbourId;
               }
               else if(amomsg.direction == DirectionsEnum.UP)
               {
                  neighborId = worldPoint.topNeighbourId;
               }
               neighborSubarea = SubArea.getSubAreaByMapId(neighborId);
               subareaChange = false;
               x = 0;
               y = 0;
               if(neighborSubarea)
               {
                  currentSubarea = PlayedCharacterManager.getInstance().currentSubArea;
                  if(neighborSubarea.id != currentSubarea.id)
                  {
                     subareaChange = true;
                     text = I18n.getUiText("ui.common.toward",[neighborSubarea.name]);
                     text2 = I18n.getUiText("ui.common.level") + " " + neighborSubarea.level;
                  }
                  if(PlayerManager.getInstance().isBasicAccount() && !neighborSubarea.basicAccountAllowed)
                  {
                     text3 = I18n.getUiText("ui.payzone.payzone");
                  }
                  if(text && text != "")
                  {
                     if(!text2 || text.length > text2.length)
                     {
                        if(!text3 || text.length > text3.length)
                        {
                           this._mouseLabel.text = text;
                        }
                        else
                        {
                           this._mouseLabel.text = text3;
                        }
                     }
                     else if(!text3 || text2.length > text3.length)
                     {
                        this._mouseLabel.text = text2;
                     }
                     else
                     {
                        this._mouseLabel.text = text3;
                     }
                     info = text;
                     if(text2)
                     {
                        info += "\n" + text2;
                     }
                     if(text3)
                     {
                        if(!this._redColor)
                        {
                           this._redColor = XmlConfig.getInstance().getEntry("colors.hyperlink.warning");
                           this._redColor = this._redColor.replace("0x","#");
                        }
                        info += "\n<font color=\'" + this._redColor + "\'>" + text3 + "</font>";
                     }
                  }
               }
               zoneBound = amomsg.zone.getBounds(amomsg.zone);
               switch(amomsg.direction)
               {
                  case DirectionsEnum.LEFT:
                     item.sprite = !!subareaChange ? this._mouseLeftBlue : this._mouseLeft;
                     item.lockX = true;
                     item.sprite.x = zoneBound.right;
                     item.offset = new Point(0,0);
                     item.lockY = true;
                     item.sprite.y = cellGlobalPos.y + AtouinConstants.CELL_HEIGHT / 2 * Atouin.getInstance().currentZoom;
                     if(subareaChange)
                     {
                        x = 0;
                        y = item.sprite.height / 2;
                     }
                     break;
                  case DirectionsEnum.UP:
                     item.sprite = !!subareaChange ? this._mouseTopBlue : this._mouseTop;
                     item.lockY = true;
                     item.sprite.y = zoneBound.bottom;
                     item.offset = new Point(0,0);
                     item.lockX = true;
                     item.sprite.x = cellGlobalPos.x + AtouinConstants.CELL_WIDTH / 2 * Atouin.getInstance().currentZoom;
                     if(subareaChange)
                     {
                        x = -this._mouseLabel.textWidth / 2;
                        y = item.sprite.height + 5;
                     }
                     break;
                  case DirectionsEnum.DOWN:
                     item.sprite = !!subareaChange ? this._mouseBottomBlue : this._mouseBottom;
                     item.lockY = true;
                     item.sprite.y = zoneBound.top;
                     item.offset = new Point(0,0);
                     item.lockX = true;
                     item.sprite.x = cellGlobalPos.x + AtouinConstants.CELL_WIDTH / 2 * Atouin.getInstance().currentZoom;
                     if(subareaChange)
                     {
                        x = -this._mouseLabel.textWidth / 2;
                        y = -item.sprite.height - this._mouseLabel.textHeight - 34;
                     }
                     break;
                  case DirectionsEnum.RIGHT:
                     item.sprite = !!subareaChange ? this._mouseRightBlue : this._mouseRight;
                     item.lockX = true;
                     item.sprite.x = zoneBound.left;
                     item.offset = new Point(0,0);
                     item.lockY = true;
                     item.sprite.y = cellGlobalPos.y + AtouinConstants.CELL_HEIGHT / 2 * Atouin.getInstance().currentZoom;
                     if(subareaChange)
                     {
                        x = -this._mouseLabel.textWidth;
                        y = item.sprite.height / 2;
                     }
               }
               if(subareaChange)
               {
                  target2 = new Rectangle(item.sprite.x + x,item.sprite.y + y,1,1);
                  tooltipData = new TextTooltipInfo(info,null,"center");
                  TooltipManager.show(tooltipData,target2,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"subareaChange",0,0,0,true,null,null,null,"Text" + neighborId);
               }
               LinkedCursorSpriteManager.getInstance().addItem("changeMapCursor",item);
               return true;
               break;
            case msg is MapComplementaryInformationsDataMessage:
               mcidmsg = msg as MapComplementaryInformationsDataMessage;
               this._fightPositions = mcidmsg.fightStartPositions;
               sf = Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame;
               if(sf.heldShortcuts.indexOf("showFightPositions") != -1 && this._fightPositionsVisible)
               {
                  this.showFightPositions();
               }
               MountAutoTripManager.getInstance().startNextTripStage(mcidmsg.mapId);
               if(!StageShareManager.mouseOnStage)
               {
                  return false;
               }
               mousePos = new Point(StageShareManager.stage.mouseX,StageShareManager.stage.mouseY);
               if(Atouin.getInstance().options.getOption("frustum").containsPoint(mousePos))
               {
                  objectsUnder = StageShareManager.stage.getObjectsUnderPoint(mousePos);
                  for each(o in objectsUnder)
                  {
                     if(o is FrustumShape)
                     {
                        o.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER));
                        break;
                     }
                  }
               }
               return false;
               break;
            case msg is MapFightStartPositionsUpdateMessage:
               mfspmsg = msg as MapFightStartPositionsUpdateMessage;
               if(PlayedCharacterManager.getInstance().currentMap && mfspmsg.mapId == PlayedCharacterManager.getInstance().currentMap.mapId)
               {
                  this._fightPositions = mfspmsg.fightStartPositions;
               }
               return true;
            case msg is EntityMouseOverMessage:
               emomsg = msg as EntityMouseOverMessage;
               this._mouseOverEntityId = emomsg.entity.id;
               tooltipName = "entity_" + emomsg.entity.id;
               this.displayCursor(NO_CURSOR);
               entity = emomsg.entity as IInteractive;
               animatedCharacter = entity as AnimatedCharacter;
               infos = this.roleplayContextFrame.entitiesFrame.getEntityInfos(entity.id) as GameRolePlayActorInformations;
               if(infos is GameRolePlayNpcInformations && (npcEntity = Npc.getNpcById((infos as GameRolePlayNpcInformations).npcId)) != null && !npcEntity.tooltipVisible)
               {
                  return false;
               }
               if(animatedCharacter)
               {
                  animatedCharacter = animatedCharacter.getRootEntity();
                  animatedCharacter.highLightCharacterAndFollower(true);
                  entity = animatedCharacter;
                  if(OptionManager.getOptionManager("tiphon").getOption("auraMode") == OptionEnum.AURA_ON_ROLLOVER && animatedCharacter.getDirection() == DirectionsEnum.DOWN)
                  {
                     animatedCharacter.visibleAura = true;
                  }
                  infos = this.roleplayContextFrame.entitiesFrame.getEntityInfos(entity.id) as GameRolePlayActorInformations;
               }
               if(entity is TiphonSprite)
               {
                  tooltipTarget = entity as TiphonSprite;
                  rider = (entity as TiphonSprite).getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0) as TiphonSprite;
                  isCreatureMode = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) && RoleplayEntitiesFrame(Kernel.getWorker().getFrame(RoleplayEntitiesFrame)).isCreatureMode;
                  if(rider && !isCreatureMode)
                  {
                     tooltipTarget = rider;
                  }
                  head = tooltipTarget.getSlot("Tete");
                  if(head)
                  {
                     r1 = head.getBounds(StageShareManager.stage);
                     r2 = new Rectangle2(r1.x,r1.y,r1.width,r1.height);
                     targetBounds = r2;
                  }
                  else if(tooltipTarget.rect)
                  {
                     p = tooltipTarget.localToGlobal(new Point(tooltipTarget.rect.x,tooltipTarget.rect.y));
                     targetBounds = new Rectangle2(p.x,p.y,tooltipTarget.rect.width,tooltipTarget.rect.height);
                  }
                  else
                  {
                     p = tooltipTarget.localToGlobal(new Point(tooltipTarget.x,tooltipTarget.y));
                     targetBounds = new Rectangle2(p.x,p.y,tooltipTarget.width,tooltipTarget.height);
                  }
               }
               if(!targetBounds || targetBounds.width == 0 && targetBounds.height == 0)
               {
                  targetBounds = (entity as IDisplayable).absoluteBounds;
               }
               tooltipMaker = null;
               tooltipOffset = 0;
               if(this.roleplayContextFrame.entitiesFrame.isFight(entity.id))
               {
                  if(this.allowOnlyCharacterInteraction)
                  {
                     return false;
                  }
                  fight = this.roleplayContextFrame.entitiesFrame.getFightTeam(entity.id);
                  infos = new RoleplayTeamFightersTooltipInformation(fight);
                  tooltipMaker = "roleplayFight";
                  this.displayCursor(FIGHT_CURSOR,!PlayedCharacterManager.getInstance().restrictions.cantAttackMonster);
                  if(fight.hasOptions() || fight.hasGroupMember())
                  {
                     tooltipOffset = 35;
                  }
               }
               else
               {
                  switch(true)
                  {
                     case infos is GameRolePlayCharacterInformations:
                        if(infos.contextualId == PlayedCharacterManager.getInstance().id)
                        {
                           levelDiffInfo = 0;
                        }
                        else
                        {
                           targetLevel = int(infos.alignmentInfos.characterPower - infos.contextualId);
                           levelDiffInfo = PlayedCharacterManager.getInstance().levelDiff(targetLevel);
                        }
                        infos = new CharacterTooltipInformation(infos as GameRolePlayCharacterInformations,levelDiffInfo);
                        cacheName = "CharacterCache";
                        break;
                     case infos is GameRolePlayMerchantInformations:
                        cacheName = "MerchantCharacterCache";
                        break;
                     case infos is GameRolePlayMutantInformations:
                        if((infos as GameRolePlayMutantInformations).humanoidInfo.restrictions.cantAttack)
                        {
                           infos = new CharacterTooltipInformation(infos,0);
                        }
                        else
                        {
                           infos = new MutantTooltipInformation(infos as GameRolePlayMutantInformations);
                        }
                        break;
                     case infos is GameRolePlayTaxCollectorInformations:
                        if(this.allowOnlyCharacterInteraction)
                        {
                           return false;
                        }
                        grtci = infos as GameRolePlayTaxCollectorInformations;
                        guildtcinfos = grtci.identification.guildIdentity;
                        allianceInfos = grtci.identification is TaxCollectorStaticExtendedInformations ? (grtci.identification as TaxCollectorStaticExtendedInformations).allianceIdentity : null;
                        gwtc = GuildWrapper.create(guildtcinfos.guildId,guildtcinfos.guildName,guildtcinfos.guildEmblem);
                        awtc = !!allianceInfos ? AllianceWrapper.create(allianceInfos.allianceId,allianceInfos.allianceTag,allianceInfos.allianceName,allianceInfos.allianceEmblem) : null;
                        infos = new TaxCollectorTooltipInformation(TaxCollectorName.getTaxCollectorNameById((infos as GameRolePlayTaxCollectorInformations).identification.lastNameId).name,TaxCollectorFirstname.getTaxCollectorFirstnameById((infos as GameRolePlayTaxCollectorInformations).identification.firstNameId).firstname,gwtc,awtc,(infos as GameRolePlayTaxCollectorInformations).taxCollectorAttack,emomsg.checkSuperposition,grtci.disposition.cellId);
                        cacheName = "TaxCollectorCache";
                        break;
                     case infos is GameRolePlayNpcInformations:
                        if(this.allowOnlyCharacterInteraction)
                        {
                           return false;
                        }
                        npcInfos = infos as GameRolePlayNpcInformations;
                        npc = Npc.getNpcById(npcInfos.npcId);
                        infos = new TextTooltipInfo(npc.name,XmlConfig.getInstance().getEntry("config.ui.skin") + "css/tooltip_npc.css","green",0,emomsg.checkSuperposition,npcInfos.disposition.cellId);
                        infos.bgCornerRadius = 10;
                        cacheName = !emomsg.virtual ? "NPCCacheName" : "NPCCacheName_" + this._mouseOverEntityId;
                        if(npc.actions.length == 0)
                        {
                           break;
                        }
                        if(!emomsg.virtual)
                        {
                           this.displayCursor(NPC_CURSOR);
                        }
                        break;
                     case infos is GameRolePlayGroupMonsterInformations:
                        if(this.allowOnlyCharacterInteraction)
                        {
                           return false;
                        }
                        if(!emomsg.virtual)
                        {
                           this.displayCursor(FIGHT_CURSOR,!PlayedCharacterManager.getInstance().restrictions.cantAttackMonster);
                        }
                        cacheName = !emomsg.virtual ? "GroupMonsterCache" : "GroupMonsterCache_" + this._mouseOverEntityId;
                        if((emomsg.entity as AnimatedCharacter).followed)
                        {
                           tooltipName = "entity_" + (emomsg.entity as AnimatedCharacter).followed.id;
                        }
                        if(PlayedCharacterManager.getInstance().isInBreach)
                        {
                           monstersInfo = new Vector.<MonsterInGroupLightInformations>();
                           monstersInfo.push(infos.staticInfos.mainCreatureLightInfos);
                           for each(monster in infos.staticInfos.underlings)
                           {
                              monstersInfo.push(monster);
                           }
                           grpgmwi = infos as GameRolePlayGroupMonsterWaveInformations;
                           if(grpgmwi)
                           {
                              for each(waveInfo in grpgmwi.alternatives)
                              {
                                 monstersInfo.push(waveInfo.mainCreatureLightInfos);
                                 for each(monster in waveInfo.underlings)
                                 {
                                    monstersInfo.push(monster);
                                 }
                              }
                           }
                           cacheName = "BreachGroupMonsterCache";
                           tooltipMaker = "breachMonsterGroup";
                           breachFrame = Kernel.getWorker().getFrame(BreachFrame) as BreachFrame;
                           if(breachFrame && breachFrame.wrappedBranches && breachFrame.wrappedBranches.length > 0)
                           {
                              currentBranch = breachFrame.wrappedBranches[0] as BreachBranchWrapper;
                           }
                           infos = {
                              "monsterGroup":monstersInfo,
                              "score":currentBranch.score,
                              "relativeScore":currentBranch.relativeScore
                           };
                        }
                        break;
                     case infos is GameRolePlayPrismInformations:
                        allianceFrame = Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame;
                        infos = new PrismTooltipInformation(allianceFrame.getPrismSubAreaById(PlayedCharacterManager.getInstance().currentSubArea.id).alliance,emomsg.checkSuperposition,infos.disposition.cellId);
                        cacheName = "PrismCache";
                        break;
                     case infos is GameRolePlayPortalInformations:
                        infos = new PortalTooltipInformation((infos as GameRolePlayPortalInformations).portal.areaId,emomsg.checkSuperposition,infos.disposition.cellId);
                        cacheName = "PortalCache";
                        break;
                     case infos is GameContextPaddockItemInformations:
                        cacheName = "PaddockItemCache";
                        break;
                     case infos is GameRolePlayTreasureHintInformations:
                        if(this.allowOnlyCharacterInteraction)
                        {
                           return false;
                        }
                        treasureHintInfos = infos as GameRolePlayTreasureHintInformations;
                        npch = Npc.getNpcById(treasureHintInfos.npcId);
                        infos = new TextTooltipInfo(npch.name,XmlConfig.getInstance().getEntry("config.ui.skin") + "css/tooltip_npc.css","orange",0);
                        infos.bgCornerRadius = 10;
                        cacheName = "TrHintCacheName";
                        break;
                  }
               }
               if(!infos)
               {
                  _log.warn("Rolling over a unknown entity (" + emomsg.entity.id + ").");
                  return false;
               }
               if(this.roleplayContextFrame.entitiesFrame.hasIcon(entity.id))
               {
                  tooltipOffset = 45;
               }
               if(animatedCharacter && !animatedCharacter.rawAnimation && !this._entityTooltipData[animatedCharacter])
               {
                  this._entityTooltipData[animatedCharacter] = {
                     "data":infos,
                     "name":tooltipName,
                     "tooltipMaker":tooltipMaker,
                     "tooltipOffset":tooltipOffset,
                     "cacheName":cacheName
                  };
                  animatedCharacter.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityAnimRendered);
                  animatedCharacter.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityAnimRendered);
               }
               else
               {
                  TooltipManager.show(infos,targetBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,tooltipName,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,tooltipOffset,true,tooltipMaker,null,null,cacheName,false,StrataEnum.STRATA_WORLD,this.sysApi.getCurrentZoom());
               }
               return true;
               break;
            case msg is MouseRightClickMessage:
               mrcmsg = msg as MouseRightClickMessage;
               modContextMenu = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
               rightClickedEntity = mrcmsg.target as IInteractive;
               if(rightClickedEntity)
               {
                  rcf = this.roleplayContextFrame;
                  if(!(rightClickedEntity as AnimatedCharacter) || (rightClickedEntity as AnimatedCharacter).followed == null)
                  {
                     actorInfos = rcf.entitiesFrame.getEntityInfos(rightClickedEntity.id);
                  }
                  else
                  {
                     actorInfos = rcf.entitiesFrame.getEntityInfos((rightClickedEntity as AnimatedCharacter).followed.id);
                  }
                  if(actorInfos is GameRolePlayNamedActorInformations)
                  {
                     if(!(rightClickedEntity is AnimatedCharacter))
                     {
                        _log.error("L\'entity " + rightClickedEntity.id + " est un GameRolePlayNamedActorInformations mais n\'est pas un AnimatedCharacter");
                        return true;
                     }
                     rightClickedEntity = (rightClickedEntity as AnimatedCharacter).getRootEntity();
                     rightClickedinfos = this.roleplayContextFrame.entitiesFrame.getEntityInfos(rightClickedEntity.id);
                     menu = MenusFactory.create(rightClickedinfos,"multiplayer",[rightClickedEntity]);
                     if(menu)
                     {
                        modContextMenu.createContextMenu(menu,null,null,"multiplayerMenu");
                     }
                     return true;
                  }
                  if(actorInfos is GameRolePlayGroupMonsterInformations)
                  {
                     menu = MenusFactory.create(actorInfos,"monsterGroup",[rightClickedEntity]);
                     if(menu)
                     {
                        modContextMenu.createContextMenu(menu);
                     }
                     return true;
                  }
                  if(actorInfos is GameRolePlayPortalInformations || actorInfos is GameRolePlayPrismInformations || actorInfos is GameRolePlayTaxCollectorInformations || actorInfos is GameRolePlayNpcInformations)
                  {
                     menu = MenusFactory.create(actorInfos,null,{
                        "entity":rightClickedEntity,
                        "rightClick":true
                     });
                     if(menu)
                     {
                        modContextMenu.createContextMenu(menu);
                     }
                     return true;
                  }
               }
               rpInteractivesFrame = Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
               rightClickedInteractiveElement = rpInteractivesFrame.getInteractiveElement(mrcmsg.target);
               roleplayEntitiesFrame2 = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
               if(rightClickedInteractiveElement && roleplayEntitiesFrame2.housesInformations && roleplayEntitiesFrame2.housesInformations[rightClickedInteractiveElement.elementId])
               {
                  houseWrapper2 = roleplayEntitiesFrame2.housesInformations[rightClickedInteractiveElement.elementId];
                  menu = MenusFactory.create(houseWrapper2,"house");
                  if(menu)
                  {
                     TooltipManager.hide();
                     modContextMenu.createContextMenu(menu);
                  }
                  return true;
               }
               if(rightClickedInteractiveElement && rightClickedInteractiveElement.elementTypeId != -1)
               {
                  menu = MenusFactory.create(rightClickedInteractiveElement,"interactiveElement");
                  if(menu)
                  {
                     TooltipManager.hide();
                     modContextMenu.createContextMenu(menu);
                  }
                  return true;
               }
               return false;
               break;
            case msg is EntityMouseOutMessage:
               emoutmsg = msg as EntityMouseOutMessage;
               this._mouseOverEntityId = 0;
               this.displayCursor(NO_CURSOR);
               animatedCharacter = emoutmsg.entity as AnimatedCharacter;
               if(emoutmsg.entity)
               {
                  TooltipManager.hide("entity_" + emoutmsg.entity.id);
               }
               if(animatedCharacter)
               {
                  if(animatedCharacter.followed)
                  {
                     TooltipManager.hide("entity_" + animatedCharacter.followed.id);
                  }
                  animatedCharacter = animatedCharacter.getRootEntity();
                  animatedCharacter.highLightCharacterAndFollower(false);
                  if(OptionManager.getOptionManager("tiphon").getOption("auraMode") == OptionEnum.AURA_ON_ROLLOVER)
                  {
                     animatedCharacter.visibleAura = false;
                  }
               }
               return true;
            case msg is EntityClickMessage:
               ecmsg = msg as EntityClickMessage;
               MountAutoTripManager.getInstance().stopCurrentTrip();
               entityc = ecmsg.entity as IInteractive;
               if(entityc is AnimatedCharacter)
               {
                  entityc = (entityc as AnimatedCharacter).getRootEntity();
               }
               entityClickInfo = this.roleplayContextFrame.entitiesFrame.getEntityInfos(entityc.id);
               if(ShortcutsFrame.shiftKey)
               {
                  linkType = "Map";
                  linkParams = {
                     "x":PlayedCharacterManager.getInstance().currentMap.outdoorX,
                     "y":PlayedCharacterManager.getInstance().currentMap.outdoorY,
                     "worldMapId":PlayedCharacterManager.getInstance().currentSubArea.worldmap.id,
                     "elementName":""
                  };
                  switch(true)
                  {
                     case entityClickInfo is GameRolePlayPortalInformations:
                        linkParams.elementName = I18n.getUiText("ui.dimension.portal",[Area.getAreaById((entityClickInfo as GameRolePlayPortalInformations).portal.areaId).name]) + " ";
                        break;
                     case entityClickInfo is GameRolePlayPrismInformations:
                        prismInfo = entityClickInfo as GameRolePlayPrismInformations;
                        prismName = this._socialApi.getAllianceNameAndTag(prismInfo.prism);
                        linkParams.elementName = I18n.getUiText("ui.prism.prismInState",[I18n.getUiText("ui.prism.state" + prismInfo.prism.state)]) + " " + LangManager.getInstance().replaceKey(prismName,true) + " ";
                        break;
                     case entityClickInfo is GameRolePlayTaxCollectorInformations:
                        taxCollectorInfo = entityClickInfo as GameRolePlayTaxCollectorInformations;
                        linkParams.elementName = I18n.getUiText("ui.guild.taxCollector",[taxCollectorInfo.identification.guildIdentity.guildName]) + " ";
                        break;
                     case entityClickInfo is GameRolePlayNpcInformations:
                        linkParams.elementName = Npc.getNpcById((entityClickInfo as GameRolePlayNpcInformations).npcId).name + " ";
                        break;
                     case entityClickInfo is GameRolePlayGroupMonsterInformations:
                        linkType = PlayedCharacterManager.getInstance().isInAnomaly || PlayedCharacterManager.getInstance().isInBreach ? "MonsterGroupScale" : "MonsterGroup";
                        linkParams.monsterName = Monster.getMonsterById((entityClickInfo as GameRolePlayGroupMonsterInformations).staticInfos.mainCreatureLightInfos.genericId).name;
                        linkParams.infos = this._roleplayApi.getMonsterGroupString(entityClickInfo);
                        break;
                     case entityClickInfo is GameRolePlayCharacterInformations:
                        linkParams.elementName = (entityClickInfo as GameRolePlayCharacterInformations).name + " ";
                  }
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseShiftClick,{
                     "data":linkType,
                     "params":linkParams
                  });
                  Kernel.getWorker().process(EmptyStackAction.create());
                  return true;
               }
               npcInfo = entityClickInfo as GameRolePlayNpcInformations;
               if(npcInfo)
               {
                  npcActions = Npc.getNpcById(npcInfo.npcId).actions;
                  if(!MenusFactory.getMenuMaker("npc").maker.disabled && npcActions.length == 1)
                  {
                     ngara = new NpcGenericActionRequestAction();
                     ngara.npcId = entityc.id;
                     this.process(new EntityMouseOutMessage(entityc));
                     ngara.actionId = NpcAction.getNpcActionById(npcActions[0]).realId;
                     Kernel.getWorker().process(ngara);
                     return true;
                  }
               }
               else if(entityClickInfo is GameRolePlayMerchantInformations)
               {
                  Kernel.getWorker().process(ExchangeOnHumanVendorRequestAction.create(entityClickInfo.contextualId,entityClickInfo.disposition.cellId));
                  return true;
               }
               menuResult = RoleplayManager.getInstance().displayContextualMenu(entityClickInfo,entityc);
               if(this.roleplayContextFrame.entitiesFrame.isFight(entityc.id))
               {
                  fightId = this.roleplayContextFrame.entitiesFrame.getFightId(entityc.id);
                  fightTeamLeader = this.roleplayContextFrame.entitiesFrame.getFightLeaderId(entityc.id);
                  teamType = this.roleplayContextFrame.entitiesFrame.getFightTeamType(entityc.id);
                  if(teamType == TeamTypeEnum.TEAM_TYPE_TAXCOLLECTOR)
                  {
                     team = this.roleplayContextFrame.entitiesFrame.getFightTeam(entityc.id) as FightTeam;
                     for each(fighter in team.teamInfos.teamMembers)
                     {
                        if(fighter is FightTeamMemberTaxCollectorInformations)
                        {
                           guildId = (fighter as FightTeamMemberTaxCollectorInformations).guildId;
                        }
                     }
                     guild = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame).guild;
                     if(guild && guildId == guild.guildId)
                     {
                        KernelEventsManager.getInstance().processCallback(SocialHookList.OpenSocial,1,2);
                        Kernel.getWorker().process(GuildFightJoinRequestAction.create(PlayedCharacterManager.getInstance().currentMap.mapId));
                        return true;
                     }
                  }
                  gfjrmsg = new GameFightJoinRequestMessage();
                  gfjrmsg.initGameFightJoinRequestMessage(fightTeamLeader,fightId);
                  playerEntity3 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                  if((playerEntity3 as IMovable).isMoving)
                  {
                     this.roleplayMovementFrame.setFollowingMessage(gfjrmsg);
                     (playerEntity3 as IMovable).stop();
                  }
                  else
                  {
                     ConnectionsHandler.getConnection().send(gfjrmsg);
                  }
               }
               else if(entityc.id != PlayedCharacterManager.getInstance().id && !menuResult)
               {
                  this.roleplayMovementFrame.setFollowingInteraction(null);
                  if(entityClickInfo is GameRolePlayActorInformations && entityClickInfo is GameRolePlayGroupMonsterInformations)
                  {
                     this.roleplayMovementFrame.setFollowingMonsterFight(entityc);
                  }
                  this.roleplayMovementFrame.askMoveTo(entityc.position);
               }
               return true;
               break;
            case msg is InteractiveElementActivationMessage:
               if(!MountAutoTripManager.getInstance().isTravelling && (this.allowOnlyCharacterInteraction || OptionManager.getOptionManager("dofus").getOption("enableForceWalk") == true && (ShortcutsFrame.ctrlKeyDown || SystemManager.getSingleton().os == OperatingSystem.MAC_OS && ShortcutsFrame.altKeyDown)))
               {
                  return false;
               }
               if(!(msg as InteractiveElementActivationMessage).fromAutotrip)
               {
                  MountAutoTripManager.getInstance().stopCurrentTrip();
               }
               sendInteractiveUseRequest = true;
               ieamsg = msg as InteractiveElementActivationMessage;
               interactiveFrame = Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
               if(!(interactiveFrame && interactiveFrame.usingInteractive))
               {
                  playerEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                  if(!playerEntity)
                  {
                     return true;
                  }
                  forbiddenCellsIds = new Array();
                  cells = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells;
                  dmp = DataMapProvider.getInstance();
                  for(i = 0; i < 8; i++)
                  {
                     mp = ieamsg.position.getNearestCellInDirection(i);
                     if(mp)
                     {
                        cellData = cells[mp.cellId];
                        forbidden = !cellData.mov || cellData.farmCell;
                        if(!forbidden)
                        {
                           numWalkableCells = 8;
                           for(j = 0; j < 8; j++)
                           {
                              mp2 = mp.getNearestCellInDirection(j);
                              if(mp2 && (!dmp.pointMov(mp2.x,mp2.y,true,mp.cellId) || !dmp.pointMov(mp2.x - 1,mp2.y,true,mp.cellId) && !dmp.pointMov(mp2.x,mp2.y - 1,true,mp.cellId)))
                              {
                                 numWalkableCells--;
                              }
                           }
                           if(!numWalkableCells)
                           {
                              forbidden = true;
                           }
                        }
                        if(forbidden)
                        {
                           if(!forbiddenCellsIds)
                           {
                              forbiddenCellsIds = [];
                           }
                           forbiddenCellsIds.push(mp.cellId);
                        }
                     }
                  }
                  ieCellData = cells[ieamsg.position.cellId];
                  skills = ieamsg.interactiveElement.enabledSkills;
                  minimalRange = 63;
                  for each(skillForRange in skills)
                  {
                     skillData = Skill.getSkillById(skillForRange.skillId);
                     if(skillData)
                     {
                        if(!skillData.useRangeInClient)
                        {
                           minimalRange = 1;
                        }
                        else if(skillData.range < minimalRange)
                        {
                           minimalRange = skillData.range;
                        }
                     }
                  }
                  distanceElementToPlayer = ieamsg.position.distanceToCell(playerEntity.position);
                  if(distanceElementToPlayer <= minimalRange && (!ieCellData.mov || ieCellData.farmCell))
                  {
                     nearestCell = MapPoint.fromCellId(playerEntity.position.cellId);
                  }
                  else
                  {
                     nearestCell = ieamsg.position.getNearestFreeCellInDirection(ieamsg.position.advancedOrientationTo(playerEntity.position),DataMapProvider.getInstance(),true,true,false,forbiddenCellsIds);
                     if(minimalRange > 1)
                     {
                        for(iRange = 1; iRange < minimalRange; )
                        {
                           forbiddenCellsIds.push(nearestCell.cellId);
                           nearestCell = nearestCell.getNearestFreeCellInDirection(nearestCell.advancedOrientationTo(playerEntity.position,false),DataMapProvider.getInstance(),true,true,false,forbiddenCellsIds);
                           if(!nearestCell || nearestCell.cellId == playerEntity.position.cellId)
                           {
                              break;
                           }
                           iRange++;
                        }
                     }
                  }
                  if(skills.length == 1 && SkillManager.getInstance().isDoorCursorSkill(skills[0].skillId))
                  {
                     nearestCell.cellId = ieamsg.position.cellId;
                     sendInteractiveUseRequest = false;
                  }
                  if(!nearestCell || forbiddenCellsIds.indexOf(nearestCell.cellId) != -1)
                  {
                     nearestCell = ieamsg.position;
                  }
                  if(sendInteractiveUseRequest)
                  {
                     this.roleplayMovementFrame.setFollowingInteraction({
                        "ie":ieamsg.interactiveElement,
                        "skillInstanceId":ieamsg.skillInstanceId,
                        "additionalParam":ieamsg.additionalParam
                     });
                  }
                  this.roleplayMovementFrame.resetNextMoveMapChange();
                  this.roleplayMovementFrame.askMoveTo(nearestCell);
               }
               return true;
               break;
            case msg is InteractiveElementMouseOverMessage:
               if(this.allowOnlyCharacterInteraction || OptionManager.getOptionManager("dofus").getOption("enableForceWalk") == true && (ShortcutsFrame.ctrlKeyDown || SystemManager.getSingleton().os == OperatingSystem.MAC_OS && ShortcutsFrame.altKeyDown))
               {
                  return false;
               }
               iemovmsg = msg as InteractiveElementMouseOverMessage;
               interactiveElem = iemovmsg.interactiveElement;
               for each(interactiveSkill in interactiveElem.enabledSkills)
               {
                  if(interactiveSkill.skillId == DataEnum.SKILL_ACCESS_PADDOCK)
                  {
                     infosIe = this.roleplayContextFrame.currentPaddock;
                     break;
                  }
               }
               for each(interactiveSkill in interactiveElem.disabledSkills)
               {
                  if(SkillManager.getInstance().isDoorCursorSkill(interactiveSkill.skillId))
                  {
                     foundDuplicate = false;
                     for each(interactiveSkill2 in interactiveElem.enabledSkills)
                     {
                        if(interactiveSkill2.skillId == interactiveSkill.skillId)
                        {
                           foundDuplicate = true;
                           break;
                        }
                     }
                     if(!foundDuplicate)
                     {
                        interactiveElem.enabledSkills.push(interactiveSkill);
                     }
                     break;
                  }
               }
               interactive = Interactive.getInteractiveById(interactiveElem.elementTypeId);
               elementId = iemovmsg.interactiveElement.elementId;
               roleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
               if(roleplayEntitiesFrame.housesInformations && roleplayEntitiesFrame.housesInformations[elementId])
               {
                  houseWrapper = roleplayEntitiesFrame.housesInformations[elementId];
               }
               breachFrame = Kernel.getWorker().getFrame(BreachFrame) as BreachFrame;
               if(breachFrame && breachFrame.branches && breachFrame.branches[elementId])
               {
                  firstBoss = true;
                  breachBranchInfo = I18n.getUiText("ui.breach.roomNumber",[breachFrame.branches[elementId].room]) + " (" + SubArea.getSubAreaByMapId(breachFrame.branches[elementId].map).name + ")\n";
                  for each(bossInfo in breachFrame.branches[elementId].bosses)
                  {
                     breachBranchInfo += (!firstBoss ? ", " : "") + Monster.getMonsterById(bossInfo.genericId).name;
                     firstBoss = false;
                  }
                  element = new Object();
                  element.interactive = breachBranchInfo;
                  SkillManager.getInstance().prepareTooltip(element,interactiveElem);
                  infosIe = element;
                  ttMaker = "interactiveElement";
                  tooltipCacheName = "InteractiveElementCache_" + element.interactive;
               }
               isDirectionalPanel = false;
               for each(interactiveSkill in interactiveElem.enabledSkills)
               {
                  if(SkillManager.getInstance().isDirectionalPanel(interactiveSkill.skillId))
                  {
                     isDirectionalPanel = true;
                     break;
                  }
               }
               if(houseWrapper)
               {
                  infosIe = houseWrapper;
               }
               else if(interactiveElem.elementTypeId == DIRECTIONAL_PANEL_ID || isDirectionalPanel)
               {
                  infosIe = Sign.getSignById(interactiveElem.elementId);
                  ttMaker = "directionalSign";
               }
               else if(infosIe == null && interactive)
               {
                  elem = new Object();
                  elem.interactive = interactive.name;
                  SkillManager.getInstance().prepareTooltip(elem,interactiveElem);
                  infosIe = elem;
                  ttMaker = "interactiveElement";
                  tooltipCacheName = "InteractiveElementCache_" + elem.interactive;
               }
               if(infosIe)
               {
                  target = iemovmsg.sprite.getRect(StageShareManager.stage);
                  TooltipManager.show(infosIe,new Rectangle(target.right,int(target.y + target.height - AtouinConstants.CELL_HEIGHT),0,0),UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,TooltipManager.TOOLTIP_STANDARD_NAME,LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_TOP,0,true,ttMaker,null,null,tooltipCacheName);
               }
               return true;
               break;
            case msg is InteractiveElementMouseOutMessage:
               if(this.allowOnlyCharacterInteraction)
               {
                  return false;
               }
               iemomsg = msg as InteractiveElementMouseOutMessage;
               TooltipManager.hide();
               return true;
               break;
            case msg is ShowAllNamesAction:
               if(Kernel.getWorker().contains(InfoEntitiesFrame))
               {
                  Kernel.getWorker().removeFrame(this._infoEntitiesFrame);
                  KernelEventsManager.getInstance().processCallback(HookList.ShowPlayersNames,false);
               }
               else
               {
                  Kernel.getWorker().addFrame(this._infoEntitiesFrame);
                  KernelEventsManager.getInstance().processCallback(HookList.ShowPlayersNames,true);
               }
               return true;
            case msg is ShowEntitiesTooltipsAction:
               seta = msg as ShowEntitiesTooltipsAction;
               _entitiesTooltipsFrame.triggeredByShortcut = seta.fromShortcut;
               if(Kernel.getWorker().contains(EntitiesTooltipsFrame))
               {
                  Kernel.getWorker().removeFrame(_entitiesTooltipsFrame);
               }
               else if(StageShareManager.isActive && !(!_entitiesTooltipsFrame.triggeredByShortcut && !this._mouseDown))
               {
                  if(Kernel.getWorker().contains(RoleplayEntitiesFrame))
                  {
                     Kernel.getWorker().addFrame(_entitiesTooltipsFrame);
                  }
                  else
                  {
                     Kernel.getWorker().addEventListener(FramePushedEvent.EVENT_FRAME_PUSHED,this.onFramePushed);
                  }
               }
               return true;
            case msg is ShowFightPositionsAction:
               sfpa = msg as ShowFightPositionsAction;
               sf = Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame;
               if(this._fightPositionsVisible)
               {
                  this.removeFightPositions();
               }
               else if(StageShareManager.isActive && (sfpa.fromShortcut && sf.heldShortcuts.indexOf("showFightPositions") != -1 || this._mouseDown))
               {
                  this.showFightPositions();
               }
               return true;
            case msg is MouseDownMessage:
               this._mouseDown = true;
               break;
            case msg is MouseUpMessage:
               this._mouseDown = false;
               mum = msg as MouseUpMessage;
               sf = Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame;
               if(sf.heldShortcuts.indexOf("showEntitiesTooltips") == -1 && Kernel.getWorker().contains(EntitiesTooltipsFrame))
               {
                  Kernel.getWorker().removeFrame(_entitiesTooltipsFrame);
               }
               else if(sf.heldShortcuts.indexOf("showFightPositions") == -1 && this._fightPositionsVisible)
               {
                  this.removeFightPositions();
               }
         }
         return false;
      }
      
      private function showFightPositions() : void
      {
         if(this._fightPositions)
         {
            this.displayZone(FightPreparationFrame.SELECTION_CHALLENGER,this._fightPositions.positionsForChallengers,FightPreparationFrame.COLOR_CHALLENGER,FightPreparationFrame.PLAYER_TEAM_ALPHA);
            this.displayZone(FightPreparationFrame.SELECTION_DEFENDER,this._fightPositions.positionsForDefenders,FightPreparationFrame.COLOR_DEFENDER,FightPreparationFrame.ENEMY_TEAM_ALPHA);
            this._fightPositionsVisible = true;
            KernelEventsManager.getInstance().processCallback(HookList.ShowFightPositions,this._fightPositionsVisible);
         }
      }
      
      private function removeFightPositions() : void
      {
         var sc:Selection = SelectionManager.getInstance().getSelection(FightPreparationFrame.SELECTION_CHALLENGER);
         if(sc)
         {
            sc.remove();
         }
         var sd:Selection = SelectionManager.getInstance().getSelection(FightPreparationFrame.SELECTION_DEFENDER);
         if(sd)
         {
            sd.remove();
         }
         this._fightPositionsVisible = false;
         KernelEventsManager.getInstance().processCallback(HookList.ShowFightPositions,this._fightPositionsVisible);
      }
      
      private function displayZone(name:String, cells:Vector.<uint>, color:Color, alpha:Number = 1.0) : void
      {
         var s:Selection = new Selection();
         var strata:uint = !!Atouin.getInstance().options.getOption("transparentOverlayMode") ? uint(PlacementStrataEnums.STRATA_HIGHEST_OF_DOOM) : uint(PlacementStrataEnums.STRATA_AREA);
         s.renderer = new ZoneDARenderer(strata,alpha);
         s.color = color;
         s.zone = new Custom(cells);
         (s.renderer as ZoneDARenderer).currentStrata = strata;
         SelectionManager.getInstance().addSelection(s,name);
         SelectionManager.getInstance().update(name,0,true);
      }
      
      public function pulled() : Boolean
      {
         StageShareManager.stage.removeEventListener(Event.DEACTIVATE,this.onWindowDeactivate);
         Mouse.show();
         LinkedCursorSpriteManager.getInstance().removeItem("changeMapCursor");
         CursorSpriteManager.resetCursor();
         FrustumManager.getInstance().setBorderInteraction(false);
         if(this._fightPositionsVisible)
         {
            this.removeFightPositions();
         }
         return true;
      }
      
      private function onFramePushed(pEvent:FramePushedEvent) : void
      {
         var shortcutsFrame:ShortcutsFrame = null;
         if(pEvent.frame is RoleplayEntitiesFrame)
         {
            pEvent.currentTarget.removeEventListener(FramePushedEvent.EVENT_FRAME_PUSHED,this.onFramePushed);
            shortcutsFrame = Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame;
            if(shortcutsFrame.heldShortcuts.indexOf("showEntitiesTooltips") != -1 && !Kernel.getWorker().contains(EntitiesTooltipsFrame))
            {
               Kernel.getWorker().addFrame(_entitiesTooltipsFrame);
            }
         }
      }
      
      private function onEntityAnimRendered(pEvent:TiphonEvent) : void
      {
         var ac:AnimatedCharacter = pEvent.currentTarget as AnimatedCharacter;
         ac.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityAnimRendered);
         var tooltipData:Object = this._entityTooltipData[ac];
         TooltipManager.show(tooltipData.data,ac.absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,tooltipData.name,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,tooltipData.tooltipOffset,true,tooltipData.tooltipMaker,null,null,tooltipData.cacheName,false,StrataEnum.STRATA_WORLD,this.sysApi.getCurrentZoom());
         delete this._entityTooltipData[ac];
      }
      
      private function displayCursor(type:int, pEnable:Boolean = true) : void
      {
         if(type == -1)
         {
            CursorSpriteManager.resetCursor();
            return;
         }
         if(PlayedCharacterManager.getInstance().state != PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING)
         {
            return;
         }
         var cursorSprite:Sprite = RoleplayInteractivesFrame.getCursor(type,pEnable);
         CursorSpriteManager.displaySpecificCursor("interactiveCursor" + type,cursorSprite);
      }
      
      private function onWhisperMessage(playerName:String) : void
      {
         KernelEventsManager.getInstance().processCallback(ChatHookList.ChatFocus,playerName);
      }
      
      private function onMerchantPlayerBuyClick(vendorId:Number, vendorCellId:uint) : void
      {
         var eohvrmsg:ExchangeOnHumanVendorRequestMessage = new ExchangeOnHumanVendorRequestMessage();
         eohvrmsg.initExchangeOnHumanVendorRequestMessage(vendorId,vendorCellId);
         ConnectionsHandler.getConnection().send(eohvrmsg);
      }
      
      private function onInviteMenuClicked(playerName:String) : void
      {
         var invitemsg:PartyInvitationRequestMessage = new PartyInvitationRequestMessage();
         var player_INVITEMSG:PlayerSearchCharacterNameInformation = new PlayerSearchCharacterNameInformation().initPlayerSearchCharacterNameInformation(playerName);
         invitemsg.initPartyInvitationRequestMessage(player_INVITEMSG);
         ConnectionsHandler.getConnection().send(invitemsg);
      }
      
      private function onMerchantHouseKickOff(cellId:uint) : void
      {
         var kickRequest:HouseKickIndoorMerchantRequestMessage = new HouseKickIndoorMerchantRequestMessage();
         kickRequest.initHouseKickIndoorMerchantRequestMessage(cellId);
         ConnectionsHandler.getConnection().send(kickRequest);
      }
      
      private function onWindowDeactivate(pEvent:Event) : void
      {
         if(Kernel.getWorker().contains(EntitiesTooltipsFrame))
         {
            Kernel.getWorker().removeFrame(_entitiesTooltipsFrame);
         }
         else if(this._fightPositionsVisible)
         {
            this.removeFightPositions();
         }
      }
   }
}
