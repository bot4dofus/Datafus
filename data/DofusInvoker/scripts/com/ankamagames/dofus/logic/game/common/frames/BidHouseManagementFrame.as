package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.actions.bid.BidHouseStringSearchAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.BidSwitchToBuyerModeAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.BidSwitchToSellerModeAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseBuyAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseListAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHousePriceAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseSearchAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseTypeAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectModifyPricedAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.NpcGenericActionRequestMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseBuyMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseBuyResultMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseGenericItemAddedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseGenericItemRemovedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseInListAddedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseInListRemovedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseInListUpdatedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseItemAddOkMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseItemRemoveOkMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseListMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHousePriceMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseSearchMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidHouseTypeMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidPriceForSellerMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeBidPriceMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeLeaveMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectModifyPricedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedBidBuyerMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedBidSellerMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeTypesExchangerDescriptionForUserMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeTypesItemsExchangerDescriptionForUserMessage;
   import com.ankamagames.dofus.network.types.game.data.items.BidExchangerObjectInfo;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInBid;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class BidHouseManagementFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(BidHouseManagementFrame));
       
      
      private var _bidHouseObjects:Array;
      
      private var _vendorObjects:Array;
      
      private var _GIDAsk:uint;
      
      private var _NPCId:uint;
      
      private var _listItemsSearchMode:Array;
      
      private var _itemsTypesAllowed:Vector.<uint>;
      
      private var _switching:Boolean = false;
      
      private var _success:Boolean;
      
      public function BidHouseManagementFrame()
      {
         super();
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function get switching() : Boolean
      {
         return this._switching;
      }
      
      public function set switching(switching:Boolean) : void
      {
         this._switching = switching;
      }
      
      public function processExchangeStartedBidSellerMessage(msg:ExchangeStartedBidSellerMessage) : void
      {
         var objectInfo:ObjectItemToSellInBid = null;
         var iw:ItemWrapper = null;
         var price:Number = NaN;
         var unsoldDelay:uint = 0;
         this._switching = false;
         var esbsmsg:ExchangeStartedBidSellerMessage = msg as ExchangeStartedBidSellerMessage;
         this._NPCId = esbsmsg.sellerDescriptor.npcContextualId;
         this.initSearchMode(esbsmsg.sellerDescriptor.types);
         this._vendorObjects = [];
         for each(objectInfo in esbsmsg.objectsInfos)
         {
            iw = ItemWrapper.create(63,objectInfo.objectUID,objectInfo.objectGID,objectInfo.quantity,objectInfo.effects);
            price = objectInfo.objectPrice;
            unsoldDelay = objectInfo.unsoldDelay;
            this._vendorObjects.push(new ItemSellByPlayer(iw,price,unsoldDelay));
         }
         this._vendorObjects.sortOn("unsoldDelay",Array.NUMERIC);
         this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedBidSeller,esbsmsg.sellerDescriptor,esbsmsg.objectsInfos);
         this._kernelEventsManager.processCallback(ExchangeHookList.SellerObjectListUpdate,this._vendorObjects);
      }
      
      public function processExchangeStartedBidBuyerMessage(msg:ExchangeStartedBidBuyerMessage) : void
      {
         var typeObject:uint = 0;
         this._switching = false;
         var esbbmsg:ExchangeStartedBidBuyerMessage = msg as ExchangeStartedBidBuyerMessage;
         this._NPCId = esbbmsg.buyerDescriptor.npcContextualId;
         this.initSearchMode(esbbmsg.buyerDescriptor.types);
         this._bidHouseObjects = [];
         for each(typeObject in esbbmsg.buyerDescriptor.types)
         {
            this._bidHouseObjects.push(new TypeObjectData(typeObject,[]));
         }
         this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedBidBuyer,esbbmsg.buyerDescriptor);
      }
      
      public function process(msg:Message) : Boolean
      {
         var ebhsa:ExchangeBidHouseSearchAction = null;
         var ebhsmsg:ExchangeBidHouseSearchMessage = null;
         var ebhla:ExchangeBidHouseListAction = null;
         var ebhta:ExchangeBidHouseTypeAction = null;
         var ebhtmsg:ExchangeBidHouseTypeMessage = null;
         var ebhba:ExchangeBidHouseBuyAction = null;
         var ebhbmsg:ExchangeBidHouseBuyMessage = null;
         var ebhpa:ExchangeBidHousePriceAction = null;
         var ebhpmsg:ExchangeBidHousePriceMessage = null;
         var ebpfsmsg:ExchangeBidPriceForSellerMessage = null;
         var ebhbrmsg:ExchangeBidHouseBuyResultMessage = null;
         var ebpmsg:ExchangeBidPriceMessage = null;
         var ebhiaomsg:ExchangeBidHouseItemAddOkMessage = null;
         var iwrapper:ItemWrapper = null;
         var priceObject:Number = NaN;
         var unsoldDelay:uint = 0;
         var ebhiromsg:ExchangeBidHouseItemRemoveOkMessage = null;
         var comptSellItem:uint = 0;
         var ebhgiamsg:ExchangeBidHouseGenericItemAddedMessage = null;
         var typeAsk:int = 0;
         var typeObjectDt:TypeObjectData = null;
         var ebhgirmsg:ExchangeBidHouseGenericItemRemovedMessage = null;
         var typeAsked:uint = 0;
         var typeObjectD:TypeObjectData = null;
         var gidIndex:int = 0;
         var eompa:ExchangeObjectModifyPricedAction = null;
         var eomfpmsg:ExchangeObjectModifyPricedMessage = null;
         var ebhilumsg:ExchangeBidHouseInListUpdatedMessage = null;
         var utypeObjects:TypeObjectData = null;
         var ugodat:GIDObjectData = null;
         var ebhilamsg:ExchangeBidHouseInListAddedMessage = null;
         var typeObjects:TypeObjectData = null;
         var godat:GIDObjectData = null;
         var ebhilrmsg:ExchangeBidHouseInListRemovedMessage = null;
         var typeAsked_1:uint = 0;
         var GIDobj:GIDObjectData = null;
         var comptGID:uint = 0;
         var etedfumsg:ExchangeTypesExchangerDescriptionForUserMessage = null;
         var tod:TypeObjectData = null;
         var etiedfumsg:ExchangeTypesItemsExchangerDescriptionForUserMessage = null;
         var typeAsked_2:uint = 0;
         var goData0:GIDObjectData = null;
         var goData:GIDObjectData = null;
         var bhssa:BidHouseStringSearchAction = null;
         var searchText:String = null;
         var i:int = 0;
         var nItems:int = 0;
         var time:int = 0;
         var itemsMatch:Vector.<uint> = null;
         var buyngarmsg:NpcGenericActionRequestMessage = null;
         var sellngarmsg:NpcGenericActionRequestMessage = null;
         var elm:ExchangeLeaveMessage = null;
         var ebhlmsg:ExchangeBidHouseListMessage = null;
         var ebhlmsg2:ExchangeBidHouseListMessage = null;
         var objectToSell:ItemSellByPlayer = null;
         var ugoda:GIDObjectData = null;
         var objectUpdate:ItemSellByBid = null;
         var objectsuPrice:Vector.<Number> = null;
         var priceu:Number = NaN;
         var goda:GIDObjectData = null;
         var itemwra:ItemWrapper = null;
         var objectsPrice:Vector.<Number> = null;
         var pric:Number = NaN;
         var newGIDObject:GIDObjectData = null;
         var itemwra2:ItemWrapper = null;
         var objectsPrice2:Vector.<Number> = null;
         var pric2:Number = NaN;
         var isbbid:ItemSellByBid = null;
         var tod1:TypeObjectData = null;
         var tempObjects:Array = null;
         var objectGIDD:GIDObjectData = null;
         var objectGID:uint = 0;
         var tod0:TypeObjectData = null;
         var goTest:GIDObjectData = null;
         var objectInfo:BidExchangerObjectInfo = null;
         var itemW:ItemWrapper = null;
         var objectsPrices:Vector.<Number> = null;
         var pri:Number = NaN;
         var lsItems:Array = null;
         var itemForSearch:Item = null;
         var currentName:String = null;
         switch(true)
         {
            case msg is ExchangeBidHouseSearchAction:
               ebhsa = msg as ExchangeBidHouseSearchAction;
               ebhsmsg = new ExchangeBidHouseSearchMessage();
               ebhsmsg.initExchangeBidHouseSearchMessage(ebhsa.genId,ebhsa.follow);
               this._GIDAsk = ebhsa.genId;
               ConnectionsHandler.getConnection().send(ebhsmsg);
               return true;
            case msg is ExchangeBidHouseListAction:
               ebhla = msg as ExchangeBidHouseListAction;
               if(this._GIDAsk != ebhla.id)
               {
                  this._GIDAsk = ebhla.id;
                  ebhlmsg = new ExchangeBidHouseListMessage();
                  ebhlmsg.initExchangeBidHouseListMessage(ebhla.id,ebhla.follow);
                  ConnectionsHandler.getConnection().send(ebhlmsg);
               }
               else
               {
                  ebhlmsg2 = new ExchangeBidHouseListMessage();
                  ebhlmsg2.initExchangeBidHouseListMessage(ebhla.id,ebhla.follow);
                  ConnectionsHandler.getConnection().send(ebhlmsg2);
               }
               return true;
            case msg is ExchangeBidHouseTypeAction:
               ebhta = msg as ExchangeBidHouseTypeAction;
               ebhtmsg = new ExchangeBidHouseTypeMessage();
               ebhtmsg.initExchangeBidHouseTypeMessage(ebhta.type,ebhta.follow);
               ConnectionsHandler.getConnection().send(ebhtmsg);
               return true;
            case msg is ExchangeBidHouseBuyAction:
               ebhba = msg as ExchangeBidHouseBuyAction;
               ebhbmsg = new ExchangeBidHouseBuyMessage();
               ebhbmsg.initExchangeBidHouseBuyMessage(ebhba.uid,ebhba.qty,ebhba.price);
               ConnectionsHandler.getConnection().send(ebhbmsg);
               return true;
            case msg is ExchangeBidHousePriceAction:
               ebhpa = msg as ExchangeBidHousePriceAction;
               ebhpmsg = new ExchangeBidHousePriceMessage();
               ebhpmsg.initExchangeBidHousePriceMessage(ebhpa.genId);
               ConnectionsHandler.getConnection().send(ebhpmsg);
               return true;
            case msg is ExchangeBidPriceForSellerMessage:
               ebpfsmsg = msg as ExchangeBidPriceForSellerMessage;
               this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeBidPriceForSeller,ebpfsmsg.genericId,ebpfsmsg.averagePrice,ebpfsmsg.minimalPrices,ebpfsmsg.allIdentical);
               return true;
            case msg is ExchangeBidHouseBuyResultMessage:
               ebhbrmsg = msg as ExchangeBidHouseBuyResultMessage;
               this._kernelEventsManager.processCallback(ExchangeHookList.BidHouseBuyResult,ebhbrmsg.bought,ebhbrmsg.uid);
               return true;
            case msg is ExchangeBidPriceMessage:
               ebpmsg = msg as ExchangeBidPriceMessage;
               this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeBidPrice,ebpmsg.genericId,ebpmsg.averagePrice);
               return true;
            case msg is ExchangeBidHouseItemAddOkMessage:
               ebhiaomsg = msg as ExchangeBidHouseItemAddOkMessage;
               iwrapper = ItemWrapper.create(63,ebhiaomsg.itemInfo.objectUID,ebhiaomsg.itemInfo.objectGID,ebhiaomsg.itemInfo.quantity,ebhiaomsg.itemInfo.effects);
               priceObject = ebhiaomsg.itemInfo.objectPrice;
               unsoldDelay = ebhiaomsg.itemInfo.unsoldDelay;
               this._vendorObjects.push(new ItemSellByPlayer(iwrapper,priceObject,unsoldDelay));
               this._kernelEventsManager.processCallback(ExchangeHookList.SellerObjectListUpdate,this._vendorObjects);
               return true;
            case msg is ExchangeBidHouseItemRemoveOkMessage:
               ebhiromsg = msg as ExchangeBidHouseItemRemoveOkMessage;
               comptSellItem = 0;
               for each(objectToSell in this._vendorObjects)
               {
                  if(objectToSell.itemWrapper.objectUID == ebhiromsg.sellerId)
                  {
                     this._vendorObjects.splice(comptSellItem,1);
                  }
                  comptSellItem++;
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.SellerObjectListUpdate,this._vendorObjects);
               return true;
            case msg is ExchangeBidHouseGenericItemAddedMessage:
               ebhgiamsg = msg as ExchangeBidHouseGenericItemAddedMessage;
               typeAsk = Item.getItemById(ebhgiamsg.objGenericId).typeId;
               typeObjectDt = this.getTypeObject(typeAsk);
               typeObjectDt.objects.push(new GIDObjectData(ebhgiamsg.objGenericId,[]));
               this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate,typeObjectDt.objects,typeObjectDt.typeObject);
               return true;
            case msg is ExchangeBidHouseGenericItemRemovedMessage:
               ebhgirmsg = msg as ExchangeBidHouseGenericItemRemovedMessage;
               typeAsked = Item.getItemById(ebhgirmsg.objGenericId).typeId;
               typeObjectD = this.getTypeObject(typeAsked);
               gidIndex = this.getGIDObjectIndex(typeAsked,ebhgirmsg.objGenericId);
               if(gidIndex == -1)
               {
                  return true;
               }
               typeObjectD.objects.splice(gidIndex,1);
               this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate,typeObjectD.objects,typeObjectD.typeObject);
               return true;
               break;
            case msg is ExchangeObjectModifyPricedAction:
               eompa = msg as ExchangeObjectModifyPricedAction;
               eomfpmsg = new ExchangeObjectModifyPricedMessage();
               eomfpmsg.initExchangeObjectModifyPricedMessage(eompa.objectUID,eompa.quantity,eompa.price);
               ConnectionsHandler.getConnection().send(eomfpmsg);
               return true;
            case msg is ExchangeBidHouseInListUpdatedMessage:
               ebhilumsg = msg as ExchangeBidHouseInListUpdatedMessage;
               utypeObjects = this.getTypeObject(ebhilumsg.objectType);
               if(!utypeObjects)
               {
                  return true;
               }
               for each(ugoda in utypeObjects.objects)
               {
                  if(ugoda.GIDObject == ebhilumsg.objectGID)
                  {
                     ugodat = ugoda;
                     for each(objectUpdate in ugoda.objects)
                     {
                        if(objectUpdate.itemWrapper.objectUID == ebhilumsg.itemUID)
                        {
                           objectUpdate.itemWrapper.update(63,ebhilumsg.itemUID,ebhilumsg.objectGID,1,ebhilumsg.effects);
                           objectsuPrice = new Vector.<Number>();
                           for each(priceu in ebhilumsg.prices)
                           {
                              objectsuPrice.push(priceu as Number);
                           }
                           objectUpdate.prices = objectsuPrice;
                        }
                     }
                  }
               }
               if(!ugodat)
               {
                  return true;
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate,ugodat.objects,ebhilumsg.objectGID);
               return true;
               break;
            case msg is ExchangeBidHouseInListAddedMessage:
               ebhilamsg = msg as ExchangeBidHouseInListAddedMessage;
               typeObjects = this.getTypeObject(ebhilamsg.objectType);
               for each(goda in typeObjects.objects)
               {
                  if(goda.GIDObject == ebhilamsg.objectGID)
                  {
                     godat = goda;
                     if(goda.objects == null)
                     {
                        goda.objects = [];
                     }
                     itemwra = ItemWrapper.create(63,ebhilamsg.itemUID,ebhilamsg.objectGID,1,ebhilamsg.effects);
                     objectsPrice = new Vector.<Number>();
                     for each(pric in ebhilamsg.prices)
                     {
                        objectsPrice.push(pric as Number);
                     }
                     goda.objects.push(new ItemSellByBid(itemwra,objectsPrice));
                  }
               }
               if(!godat)
               {
                  newGIDObject = new GIDObjectData(ebhilamsg.objectGID,[]);
                  godat = newGIDObject;
                  itemwra2 = ItemWrapper.create(63,ebhilamsg.itemUID,ebhilamsg.objectGID,1,ebhilamsg.effects);
                  objectsPrice2 = new Vector.<Number>();
                  for each(pric2 in ebhilamsg.prices)
                  {
                     objectsPrice2.push(pric2 as Number);
                  }
                  newGIDObject.objects.push(new ItemSellByBid(itemwra2,objectsPrice2));
                  typeObjects.objects.push(newGIDObject);
                  this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate,typeObjects.objects,typeObjects.typeObject);
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate,godat.objects,ebhilamsg.objectGID);
               return true;
            case msg is ExchangeBidHouseInListRemovedMessage:
               ebhilrmsg = msg as ExchangeBidHouseInListRemovedMessage;
               typeAsked_1 = ebhilrmsg.objectType;
               GIDobj = this.getGIDObject(typeAsked_1,ebhilrmsg.objectGID);
               comptGID = 0;
               if(GIDobj == null)
               {
                  return true;
               }
               for each(isbbid in GIDobj.objects)
               {
                  if(ebhilrmsg.itemUID == isbbid.itemWrapper.objectUID)
                  {
                     GIDobj.objects.splice(comptGID,1);
                  }
                  comptGID++;
               }
               if(GIDobj.objects.length == 0)
               {
                  tod1 = this.getTypeObject(typeAsked_1);
                  tempObjects = [];
                  for each(objectGIDD in tod1.objects)
                  {
                     if(objectGIDD.GIDObject != ebhilrmsg.objectGID)
                     {
                        tempObjects.push(objectGIDD);
                     }
                  }
                  tod1.objects = tempObjects;
                  this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate,tod1.objects,tod1.typeObject);
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate,GIDobj.objects,ebhilrmsg.objectGID);
               return true;
               break;
            case msg is ExchangeTypesExchangerDescriptionForUserMessage:
               etedfumsg = msg as ExchangeTypesExchangerDescriptionForUserMessage;
               tod = this.getTypeObject(etedfumsg.objectType);
               tod.objects = [];
               for each(objectGID in etedfumsg.typeDescription)
               {
                  tod.objects.push(new GIDObjectData(objectGID,[]));
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate,tod.objects,tod.typeObject);
               return true;
            case msg is ExchangeTypesItemsExchangerDescriptionForUserMessage:
               etiedfumsg = msg as ExchangeTypesItemsExchangerDescriptionForUserMessage;
               typeAsked_2 = etiedfumsg.objectType;
               if(etiedfumsg.itemTypeDescriptions.length > 0)
               {
                  this._GIDAsk = (etiedfumsg.itemTypeDescriptions[0] as BidExchangerObjectInfo).objectGID;
               }
               goData0 = this.getGIDObject(typeAsked_2,this._GIDAsk);
               if(!goData0)
               {
                  tod0 = this.getTypeObject(typeAsked_2);
                  goTest = new GIDObjectData(this._GIDAsk,[]);
                  if(tod0)
                  {
                     if(!tod0.objects)
                     {
                        tod0.objects = [];
                     }
                     if(tod0.objects.indexOf(goTest) == -1)
                     {
                        tod0.objects.push(goTest);
                     }
                  }
               }
               goData = this.getGIDObject(typeAsked_2,this._GIDAsk);
               if(goData)
               {
                  goData.objects = [];
                  for each(objectInfo in etiedfumsg.itemTypeDescriptions)
                  {
                     itemW = ItemWrapper.create(63,objectInfo.objectUID,objectInfo.objectGID,1,objectInfo.effects);
                     objectsPrices = new Vector.<Number>();
                     for each(pri in objectInfo.prices)
                     {
                        objectsPrices.push(pri as Number);
                     }
                     goData.objects.push(new ItemSellByBid(itemW,objectsPrices));
                  }
                  this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate,goData.objects,this._GIDAsk,false,true);
               }
               else
               {
                  this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectListUpdate,null,this._GIDAsk,false,true);
               }
               return true;
            case msg is BidHouseStringSearchAction:
               bhssa = msg as BidHouseStringSearchAction;
               searchText = StringUtils.noAccent(bhssa.searchString);
               time = getTimer();
               itemsMatch = new Vector.<uint>();
               if(this._listItemsSearchMode == null)
               {
                  this._listItemsSearchMode = new Array();
                  lsItems = Item.getItems();
                  nItems = lsItems.length;
                  for each(itemForSearch in lsItems)
                  {
                     if(itemForSearch && this._itemsTypesAllowed.indexOf(itemForSearch.typeId) != -1 && itemForSearch.name)
                     {
                        this._listItemsSearchMode.push(itemForSearch.undiatricalName,itemForSearch.id);
                     }
                  }
                  _log.debug("Initialisation recherche HDV en " + (getTimer() - time) + " ms.");
               }
               nItems = this._listItemsSearchMode.length;
               for(i = 0; i < nItems; i += 2)
               {
                  currentName = StringUtils.noAccent(this._listItemsSearchMode[i]);
                  if(currentName.indexOf(searchText) != -1)
                  {
                     itemsMatch.push(this._listItemsSearchMode[i + 1]);
                  }
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.BidObjectTypeListUpdate,itemsMatch,0,true);
               return true;
            case msg is BidSwitchToBuyerModeAction:
               this._switching = true;
               buyngarmsg = new NpcGenericActionRequestMessage();
               buyngarmsg.initNpcGenericActionRequestMessage(this._NPCId,6,PlayedCharacterManager.getInstance().currentMap.mapId);
               ConnectionsHandler.getConnection().send(buyngarmsg);
               return true;
            case msg is BidSwitchToSellerModeAction:
               this._switching = true;
               sellngarmsg = new NpcGenericActionRequestMessage();
               sellngarmsg.initNpcGenericActionRequestMessage(this._NPCId,5,PlayedCharacterManager.getInstance().currentMap.mapId);
               ConnectionsHandler.getConnection().send(sellngarmsg);
               return true;
            case msg is ExchangeLeaveMessage:
               elm = msg as ExchangeLeaveMessage;
               if(elm.dialogType == DialogTypeEnum.DIALOG_EXCHANGE && !this.switching)
               {
                  PlayedCharacterManager.getInstance().isInExchange = false;
                  this._success = elm.success;
                  Kernel.getWorker().removeFrame(this);
               }
               return true;
            default:
               return false;
         }
      }
      
      public function pushed() : Boolean
      {
         this._success = false;
         return true;
      }
      
      public function pulled() : Boolean
      {
         if(!this.switching)
         {
            if(Kernel.getWorker().contains(CommonExchangeManagementFrame))
            {
               Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CommonExchangeManagementFrame));
            }
            KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeLeave,this._success);
         }
         return true;
      }
      
      private function get _kernelEventsManager() : KernelEventsManager
      {
         return KernelEventsManager.getInstance();
      }
      
      private function getTypeObject(pType:uint) : TypeObjectData
      {
         var tod:TypeObjectData = null;
         if(this._bidHouseObjects == null)
         {
            return null;
         }
         for each(tod in this._bidHouseObjects)
         {
            if(tod.typeObject == pType)
            {
               return tod;
            }
         }
         return null;
      }
      
      private function getGIDObject(pType:uint, pGID:uint) : GIDObjectData
      {
         var god:GIDObjectData = null;
         if(this._bidHouseObjects == null)
         {
            return null;
         }
         var typeObjectData:TypeObjectData = this.getTypeObject(pType);
         if(typeObjectData == null)
         {
            return null;
         }
         for each(god in typeObjectData.objects)
         {
            if(god.GIDObject == pGID)
            {
               return god;
            }
         }
         return null;
      }
      
      private function getGIDObjectIndex(pType:uint, pGID:uint) : int
      {
         var god:GIDObjectData = null;
         if(this._bidHouseObjects == null)
         {
            return -1;
         }
         var typeObjectData:TypeObjectData = this.getTypeObject(pType);
         if(typeObjectData == null)
         {
            return -1;
         }
         var index:int = 0;
         for each(god in typeObjectData.objects)
         {
            if(god.GIDObject == pGID)
            {
               return index;
            }
            index++;
         }
         return -1;
      }
      
      private function initSearchMode(types:Vector.<uint>) : void
      {
         var nTypes:int = 0;
         var reset:Boolean = false;
         var i:int = 0;
         if(this._itemsTypesAllowed)
         {
            nTypes = types.length;
            if(nTypes == this._itemsTypesAllowed.length)
            {
               reset = false;
               for(i = 0; i < nTypes; i++)
               {
                  if(types[i] != this._itemsTypesAllowed[i])
                  {
                     reset = true;
                     break;
                  }
               }
               if(reset)
               {
                  this._listItemsSearchMode = null;
               }
            }
            else
            {
               this._listItemsSearchMode = null;
            }
         }
         else
         {
            this._listItemsSearchMode = null;
         }
         this._itemsTypesAllowed = types;
      }
   }
}

import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;

class ItemSellByPlayer
{
    
   
   public var itemWrapper:ItemWrapper;
   
   public var price:Number = 0;
   
   public var unsoldDelay:uint;
   
   function ItemSellByPlayer(pItemWrapper:ItemWrapper, pPrice:Number, pUnsoldDelay:uint)
   {
      super();
      this.itemWrapper = pItemWrapper;
      this.price = pPrice;
      this.unsoldDelay = pUnsoldDelay;
   }
}

import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;

class ItemSellByBid
{
    
   
   public var itemWrapper:ItemWrapper;
   
   public var prices:Vector.<Number>;
   
   function ItemSellByBid(pItemWrapper:ItemWrapper, pPrices:Vector.<Number>)
   {
      super();
      this.itemWrapper = pItemWrapper;
      this.prices = pPrices;
   }
}

class TypeObjectData
{
    
   
   public var objects:Array;
   
   public var typeObject:uint;
   
   function TypeObjectData(pTypeObject:uint, pObjects:Array)
   {
      super();
      this.objects = pObjects;
      this.typeObject = pTypeObject;
   }
}

class GIDObjectData
{
    
   
   public var objects:Array;
   
   public var GIDObject:uint;
   
   function GIDObjectData(pGIDObject:uint, pObjects:Array)
   {
      super();
      this.objects = pObjects;
      this.GIDObject = pGIDObject;
   }
}
