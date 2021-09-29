package Ankama_House
{
   import Ankama_Common.Common;
   import Ankama_House.ui.HavenbagFurnituresTypes;
   import Ankama_House.ui.HavenbagManager;
   import Ankama_House.ui.HavenbagUi;
   import Ankama_House.ui.HouseGuildManager;
   import Ankama_House.ui.HouseManager;
   import Ankama_House.ui.HouseSale;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.actions.LeaveDialogAction;
   import com.ankamagames.dofus.logic.game.common.actions.LockableChangeCodeAction;
   import com.ankamagames.dofus.logic.game.common.actions.LockableUseCodeAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.LockableResultEnum;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalInformations;
   import com.ankamagames.dofus.network.types.game.havenbag.HavenBagRoomPreviewInformation;
   import com.ankamagames.dofus.uiApi.MapApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.display.Sprite;
   
   public class House extends Sprite
   {
      
      public static var currentHouse:HouseWrapper;
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="MapApi")]
      public var mapApi:MapApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var include_HouseManager:HouseManager = null;
      
      private var include_HouseSale:HouseSale = null;
      
      private var include_HouseGuildManager:HouseGuildManager = null;
      
      private var include_HavenbagManager:HavenbagManager = null;
      
      private var include_HavenbagUi:HavenbagUi = null;
      
      private var include_HavenbagFurnituresTypes:HavenbagFurnituresTypes = null;
      
      private var _subAreaAlliance:Boolean;
      
      private var _price:Number = 0;
      
      public function House()
      {
         super();
      }
      
      public function main() : void
      {
         this._price = 0;
         this.sysApi.addHook(HookList.CurrentMap,this.onCurrentMap);
         this.sysApi.addHook(HookList.HouseEntered,this.houseEntered);
         this.sysApi.addHook(HookList.HouseExit,this.houseExit);
         this.sysApi.addHook(HookList.HouseSold,this.onHouseSold);
         this.sysApi.addHook(HookList.HouseSellingUpdate,this.onHouseSellingUpdate);
         this.sysApi.addHook(HookList.PurchasableDialog,this.purchasableDialog);
         this.sysApi.addHook(HookList.HouseBuyResult,this.houseBuyResult);
         this.sysApi.addHook(HookList.OpenHouseGuildManager,this.onOpenHouseGuildManager);
         this.sysApi.addHook(HookList.LockableShowCode,this.lockableShowCode);
         this.sysApi.addHook(HookList.LockableCodeResult,this.lockableCodeResult);
         this.sysApi.addHook(HookList.LockableStateUpdateHouseDoor,this.lockableStateUpdateHouseDoor);
         this.sysApi.addHook(HookList.HavenbagDisplayUi,this.onHavenbagDisplayUi);
         this.sysApi.addHook(HookList.HavenBagLotteryGift,this.onHavenBagLotteryGift);
         this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
      }
      
      private function lockableShowCode(changeOrUse:Boolean, codeSize:uint) : void
      {
         this.modCommon.openPasswordMenu(codeSize,changeOrUse,this.selectCode,this.codeCancelChange);
      }
      
      private function selectCode(changeOrUse:Boolean, code:String) : void
      {
         if(changeOrUse)
         {
            this.sysApi.sendAction(new LockableChangeCodeAction([code]));
         }
         else
         {
            this.sysApi.sendAction(new LockableUseCodeAction([code]));
         }
      }
      
      private function codeCancelChange() : void
      {
         this.sysApi.sendAction(new LeaveDialogAction([]));
      }
      
      private function lockableCodeResult(result:uint) : void
      {
         if(result == LockableResultEnum.LOCKABLE_UNLOCKED)
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.common.code"),this.uiApi.getText("ui.house.codeChanged"),[this.uiApi.getText("ui.common.ok")]);
         }
         else if(result == LockableResultEnum.LOCKABLE_CODE_ERROR)
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.common.code"),this.uiApi.getText("ui.error.badCode"),[this.uiApi.getText("ui.common.ok")]);
         }
         else if(result == LockableResultEnum.LOCKABLE_UNLOCK_FORBIDDEN)
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.common.code"),this.uiApi.getText("ui.error.forbiddenUnlock"),[this.uiApi.getText("ui.common.ok")]);
         }
      }
      
      private function lockableStateUpdateHouseDoor(houseId:int, instanceId:int, locked:Boolean) : void
      {
         var uiHouseManager:UiRootContainer = this.uiApi.getUi("houseManager");
         if(uiHouseManager != null)
         {
            (uiHouseManager.uiClass as HouseManager).locked = locked;
            (uiHouseManager.uiClass as HouseManager).updateIcon();
         }
      }
      
      private function purchasableDialog(buyOrSell:Boolean, price:Number, houseWrapper:HouseWrapper, instanceId:int) : void
      {
         currentHouse = houseWrapper;
         this._price = price;
         if(buyOrSell)
         {
            this.uiApi.loadUi("houseSale","houseSale",{
               "buyMode":true,
               "price":price,
               "instanceId":instanceId
            });
         }
         else
         {
            this.uiApi.loadUi("houseSale","houseSale",{
               "buyMode":false,
               "inside":false,
               "price":price,
               "instanceId":instanceId
            });
         }
      }
      
      private function houseBuyResult(houseId:uint, bought:Boolean, realPrice:Number, ownerName:String) : void
      {
         if(bought)
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.login.news"),this.uiApi.getText("ui.common.houseBuy",this.uiApi.getText("ui.common.houseOwnerName",ownerName),this.utilApi.kamasToString(realPrice,"")),[this.uiApi.getText("ui.common.ok")]);
         }
         else
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.login.news"),this.uiApi.getText("ui.common.cantBuyHouse",this.utilApi.kamasToString(realPrice,"")),[this.uiApi.getText("ui.common.ok")]);
         }
      }
      
      private function onHouseSellingUpdate(houseId:uint, instanceId:uint, realPrice:Number, buyerName:String, buyerTagNumber:String) : void
      {
         var textSell:String = null;
         var uiHouseManager:UiRootContainer = this.uiApi.getUi("houseManager");
         if(uiHouseManager != null)
         {
            (uiHouseManager.uiClass as HouseManager).updatePrice(realPrice);
         }
         var formattedName:String = PlayerManager.getInstance().formatTagName(buyerName,buyerTagNumber,null,false);
         if(realPrice == 0)
         {
            textSell = this.uiApi.getText("ui.common.houseNosell",this.uiApi.getText("ui.common.houseOwnerName",formattedName));
         }
         else
         {
            textSell = this.uiApi.getText("ui.common.houseSell",this.uiApi.getText("ui.common.houseOwnerName",formattedName),this.utilApi.kamasToString(realPrice,""));
         }
         this.modCommon.openPopup(this.uiApi.getText("ui.login.news"),textSell,[this.uiApi.getText("ui.common.ok")]);
      }
      
      private function onHouseSold(houseId:uint, instanceId:uint, realPrice:Number, buyerName:String, buyertagNumber:String, subAreaName:String, worldX:int, worldY:int) : void
      {
         var uiHouseManager:UiRootContainer = this.uiApi.getUi("houseManager");
         if(uiHouseManager != null)
         {
            (uiHouseManager.uiClass as HouseManager).updatePrice(realPrice);
         }
         var textSell:String = this.uiApi.getText("ui.common.houseSold",subAreaName,worldX,worldY);
         this.modCommon.openPopup(this.uiApi.getText("ui.login.news"),textSell,[this.uiApi.getText("ui.common.ok")]);
      }
      
      private function houseEntered(isPlayerHouse:Boolean, worldX:int, worldY:int, houseWrapper:HouseWrapper) : void
      {
         currentHouse = houseWrapper;
         if(isPlayerHouse)
         {
            if(!this.uiApi.getUi("houseManager"))
            {
               this.uiApi.loadUi("houseManager","houseManager",{
                  "houseWrapper":houseWrapper,
                  "subAreaAlliance":this._subAreaAlliance
               },0);
            }
         }
         else if(this.uiApi.getUi("houseManager"))
         {
            this.uiApi.unloadUi("houseManager");
         }
      }
      
      private function houseExit() : void
      {
         if(this.uiApi.getUi("houseManager"))
         {
            this.uiApi.unloadUi("houseManager");
         }
      }
      
      private function onCurrentMap(pMapId:Number) : void
      {
         var prismInfo:PrismSubAreaWrapper = null;
         var subArea:SubArea = this.mapApi.getMapPositionById(pMapId).subArea;
         this._subAreaAlliance = false;
         if(subArea)
         {
            prismInfo = this.socialApi.getPrismSubAreaById(subArea.id);
            if(prismInfo && prismInfo.mapId != -1)
            {
               this._subAreaAlliance = true;
            }
         }
      }
      
      private function onOpenHouseGuildManager(house:HouseWrapper) : void
      {
         if(this.uiApi.getUi("houseGuildManager"))
         {
            this.uiApi.unloadUi("houseGuildManager");
         }
         else
         {
            this.uiApi.loadUi("houseGuildManager","houseGuildManager",house,3);
         }
      }
      
      private function onHavenbagDisplayUi(display:Boolean, havenbagCurrentRoomId:uint, havenBagAvailableRooms:Vector.<HavenBagRoomPreviewInformation>, havenbagCurrentRoomThemeId:int, havenbagAvailableThemes:*, havenbagOwnerInfos:CharacterMinimalInformations) : void
      {
         if(display)
         {
            this.uiApi.loadUi("havenbagManager","havenbagManager",{
               "currentRoomId":havenbagCurrentRoomId,
               "availableRooms":havenBagAvailableRooms,
               "currentRoomThemeId":havenbagCurrentRoomThemeId,
               "availableThemes":havenbagAvailableThemes,
               "ownerInfos":havenbagOwnerInfos
            });
         }
         else
         {
            this.uiApi.unloadUi("havenbagUi");
            this.uiApi.unloadUi("havenbagFurnituresTypes");
            this.uiApi.unloadUi("havenbagManager");
         }
      }
      
      private function onHavenBagLotteryGift(pGiftName:String) : void
      {
         this.modCommon.openPopup(this.uiApi.getText("ui.popup.information"),this.uiApi.getText("ui.common.giftReceived",pGiftName),[this.uiApi.getText("ui.common.ok")]);
      }
      
      private function onUiLoaded(pUiName:String) : void
      {
         if(pUiName == "havenbagManager")
         {
            this.uiApi.loadUi("havenbagUi",null,null,StrataEnum.STRATA_LOW);
            this.uiApi.loadUi("havenbagFurnituresTypes");
         }
      }
   }
}
