package Ankama_Mount
{
   import Ankama_Common.Common;
   import Ankama_Mount.ui.MountAncestors;
   import Ankama_Mount.ui.MountInfo;
   import Ankama_Mount.ui.MountPaddock;
   import Ankama_Mount.ui.PaddockSellBuy;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceMount;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountInfoRequestAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.MountHookList;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.display.Sprite;
   
   public class Mount extends Sprite
   {
       
      
      private var include_mountInfo:MountInfo;
      
      private var include_mountAncestors:MountAncestors;
      
      private var include_mountPaddock:MountPaddock;
      
      private var include_paddockSellBuy:PaddockSellBuy;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _mountIdWaitingForAncestors:Number = 0;
      
      public function Mount()
      {
         super();
      }
      
      public function main() : void
      {
         this.sysApi.addHook(HookList.OpenMount,this.onOpenMount);
         this.sysApi.addHook(MountHookList.ExchangeStartOkMount,this.onExchangeStartOkMount);
         this.sysApi.addHook(MountHookList.CertificateMountData,this.onCertificateMountData);
         this.sysApi.addHook(MountHookList.PaddockedMountData,this.onCertificateMountData);
         this.sysApi.addHook(HookList.PaddockBuyResult,this.paddockBuyResult);
         this.sysApi.addHook(MountHookList.ViewMountAncestors,this.onViewMountAncestors);
         this.sysApi.addHook(HookList.CurrentMap,this.onCurrentMap);
         this.sysApi.addHook(HookList.GameFightStarting,this.onGameFightStarting);
         this.sysApi.addHook(MountHookList.PaddockSellBuyDialog,this.onPaddockSellBuyDialog);
      }
      
      private function onExchangeStartOkMount(stabledList:Object, paddockedList:Object) : void
      {
         this.uiApi.unloadUi(UIEnum.MOUNT_INFO);
         var paddockUi:UiRootContainer = this.uiApi.getUi("mountPaddock");
         if(paddockUi)
         {
            paddockUi.uiClass.showUi(stabledList,paddockedList);
         }
         else
         {
            this.uiApi.loadUi("mountPaddock","mountPaddock",{
               "stabledList":stabledList,
               "paddockedList":paddockedList
            },StrataEnum.STRATA_TOP);
         }
      }
      
      private function onCurrentMap(mapId:Number) : void
      {
         this.uiApi.unloadUi("mountPaddock");
      }
      
      private function onGameFightStarting(fightType:uint) : void
      {
         this.uiApi.unloadUi("mountPaddock");
      }
      
      private function onOpenMount() : void
      {
         var mountPaddock:UiRootContainer = null;
         var mountInfo:UiRootContainer = this.uiApi.getUi(UIEnum.MOUNT_INFO);
         if(mountInfo)
         {
            mountPaddock = this.uiApi.getUi("mountPaddock");
            if(!mountPaddock || mountPaddock.uiClass.visible == false)
            {
               if(mountInfo.visible == false)
               {
                  mountInfo.visible = true;
               }
               else
               {
                  this.uiApi.unloadUi(UIEnum.MOUNT_INFO);
               }
               this.uiApi.unloadUi(UIEnum.MOUNT_ANCESTORS);
            }
            else if(mountInfo.visible == false)
            {
               mountPaddock.uiClass.showCurrentMountInfo();
               mountInfo.visible = true;
            }
         }
         else
         {
            if(this.uiApi.getUi(UIEnum.MOUNT_INFO))
            {
               this.uiApi.unloadUi(UIEnum.MOUNT_INFO);
            }
            if(this.playerApi.getMount())
            {
               this.uiApi.loadUi(UIEnum.MOUNT_INFO,UIEnum.MOUNT_INFO,{
                  "paddockMode":false,
                  "posX":890,
                  "posY":150,
                  "mountData":this.playerApi.getMount()
               });
            }
         }
      }
      
      private function onPaddockSellBuyDialog(sellMode:Boolean, ownerId:Number, price:Number, ... args) : void
      {
         this.uiApi.loadUi("paddockSellBuy","paddockSellBuy",{
            "sellMode":sellMode,
            "id":ownerId,
            "price":price
         });
      }
      
      private function paddockBuyResult(paddockId:Number, bought:Boolean, realPrice:Number) : void
      {
         if(bought)
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.login.news"),this.uiApi.getText("ui.common.houseBuy",this.uiApi.getText("ui.common.mountPark"),this.utilApi.kamasToString(realPrice,"")),[this.uiApi.getText("ui.common.ok")]);
         }
         else
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.login.news"),this.uiApi.getText("ui.common.cantBuyPaddock",this.utilApi.kamasToString(realPrice,"")),[this.uiApi.getText("ui.common.ok")]);
         }
      }
      
      private function onCertificateMountData(mount:Object) : void
      {
         if(this._mountIdWaitingForAncestors > 0)
         {
            if(!this.uiApi.getUi(UIEnum.MOUNT_ANCESTORS))
            {
               this.uiApi.loadUi(UIEnum.MOUNT_ANCESTORS,UIEnum.MOUNT_ANCESTORS,{"mount":mount},StrataEnum.STRATA_TOP);
            }
            this._mountIdWaitingForAncestors = 0;
            return;
         }
         var mountPaddockUi:UiRootContainer = this.uiApi.getUi("mountPaddock");
         if(!mountPaddockUi || !mountPaddockUi.uiClass.visible)
         {
            if(this.uiApi.getUi(UIEnum.MOUNT_INFO))
            {
               this.uiApi.unloadUi(UIEnum.MOUNT_INFO);
            }
            this.uiApi.loadUi(UIEnum.MOUNT_INFO,UIEnum.MOUNT_INFO,{
               "centeredMode":true,
               "posX":550,
               "posY":150,
               "mountData":mount
            });
         }
         else
         {
            mountPaddockUi.uiClass.showMountInfo(mount,1);
         }
      }
      
      private function onViewMountAncestors(item:ItemWrapper) : void
      {
         var effect:EffectInstance = null;
         if(!item || !item.effects || item.effects.length == 0)
         {
            return;
         }
         for each(effect in item.effects)
         {
            if(effect is EffectInstanceMount)
            {
               this._mountIdWaitingForAncestors = (effect as EffectInstanceMount).id;
            }
         }
         this.sysApi.sendAction(new MountInfoRequestAction([item]));
      }
      
      private function onPaddockedMountData(mount:Object) : void
      {
         if(this.uiApi.getUi(UIEnum.MOUNT_INFO))
         {
            this.uiApi.unloadUi(UIEnum.MOUNT_INFO);
         }
         this.uiApi.loadUi(UIEnum.MOUNT_INFO,UIEnum.MOUNT_INFO,{
            "centeredMode":true,
            "posX":452,
            "posY":152,
            "mountData":mount
         });
      }
   }
}
