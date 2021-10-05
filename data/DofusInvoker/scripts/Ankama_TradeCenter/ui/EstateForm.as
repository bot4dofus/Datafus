package Ankama_TradeCenter.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.datacenter.houses.House;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.MapApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.display.Shape;
   
   public class EstateForm
   {
       
      
      public var output:Object;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="MapApi")]
      public var mapApi:MapApi;
      
      private var _data:Object;
      
      private var _estateType:uint;
      
      private var _skillsList:Array;
      
      public var btn_mp:ButtonContainer;
      
      public var btn_loc:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var tx_illusBg:Texture;
      
      public var tx_houseIcon:Texture;
      
      public var tx_kamas:Texture;
      
      public var lbl_name:Label;
      
      public var lbl_price:Label;
      
      public var lbl_priceContent:Label;
      
      public var lbl_nbRoomMount:Label;
      
      public var lbl_nbChestMachine:Label;
      
      public var lbl_skill:Label;
      
      public var lbl_locArea:Label;
      
      public var lbl_ownerContent:Label;
      
      public function EstateForm()
      {
         super();
      }
      
      public function main(args:Array) : void
      {
         this._estateType = args[0];
         this._data = args[1];
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortCut);
         this.uiApi.addComponentHook(this.tx_houseIcon,"onTextureReady");
         this.tx_houseIcon.dispatchMessages = true;
         this.updateInformations();
      }
      
      public function unload() : void
      {
      }
      
      private function updateInformations() : void
      {
         var house:House = null;
         var skill:uint = 0;
         this.lbl_price.text = this.uiApi.getText("ui.common.price") + this.uiApi.getText("ui.common.colon");
         this.lbl_price.fullWidthAndHeight();
         if(this._estateType == 0)
         {
            house = this.dataApi.getHouse(this._data.modelId);
            this.lbl_nbRoomMount.text = this.uiApi.getText("ui.estate.nbRoom") + " " + this._data.nbRoom;
            this.lbl_nbChestMachine.text = this.uiApi.getText("ui.estate.nbChest") + " " + this._data.nbChest;
            this.tx_houseIcon.visible = false;
            this.tx_houseIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("houses") + house.gfxId + ".png");
            this.lbl_name.text = house.name;
            this.lbl_priceContent.text = this.utilApi.kamasToString(this._data.price,"");
            this._skillsList = [];
            for each(skill in this._data.skillListIds)
            {
               if(skill != DataEnum.SKILL_POINT_OUT_EXIT)
               {
                  this._skillsList.push(this.dataApi.getSkill(skill).name);
               }
            }
            if(this._skillsList.length)
            {
               this.lbl_skill.text = this.uiApi.processText(this.uiApi.getText("ui.estate.houseSkills",this._skillsList.length),"m",this._skillsList.length == 1,this._skillsList.length == 0);
               this.uiApi.addComponentHook(this.lbl_skill,"onRollOver");
               this.uiApi.addComponentHook(this.lbl_skill,"onRollOut");
            }
            else
            {
               this.lbl_skill.text = this.uiApi.getText("ui.estate.noSkill");
            }
            this.lbl_locArea.text = this.dataApi.getArea(this.dataApi.getSubArea(this._data.subAreaId).areaId).name + " (" + this.dataApi.getSubArea(this._data.subAreaId).name + "), " + this._data.worldX + "," + this._data.worldY;
            if(!this._data.hasOwner)
            {
               this.lbl_ownerContent.text = this.uiApi.getText("ui.common.none");
               this.btn_mp.disabled = true;
            }
            else if(this._data.ownerTag.nickname === PlayerManager.getInstance().nickname && this._data.ownerTag.tagNumber === PlayerManager.getInstance().tag)
            {
               this.lbl_ownerContent.text = this.uiApi.getText("ui.common.myHouse");
               this.btn_mp.disabled = true;
            }
            else
            {
               this.lbl_ownerContent.setStyleSheet(UiApi.styleForTagName);
               this.lbl_ownerContent.htmlText = PlayerManager.getInstance().formatTagName(this._data.ownerTag.nickname,!!this._data.hasOwnProperty("ownerTag") ? this._data.ownerTag.tagNumber : "");
               this.btn_mp.disabled = false;
               this.lbl_ownerContent.htmlText += " (" + (!this._data.hasOwnProperty("ownerCharacterName") || !this._data.ownerCharacterName ? this.uiApi.getText("ui.server.state.offline") : this._data.ownerCharacterName) + ")";
               this.lbl_ownerContent.finalize();
            }
         }
         else
         {
            this.lbl_skill.visible = false;
            this.btn_mp.visible = false;
            this.lbl_ownerContent.width += 30;
            this.lbl_nbRoomMount.text = this.uiApi.getText("ui.estate.nbMount") + " " + this._data.nbMount;
            this.lbl_nbChestMachine.text = this.uiApi.getText("ui.estate.nbMachine") + " " + this._data.nbObject;
            this.tx_houseIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus") + "enclos_tx_illuEnclos.png");
            this.lbl_name.text = this.uiApi.getText("ui.common.mountPark");
            this.lbl_priceContent.text = this.utilApi.kamasToString(this._data.price,"");
            this.lbl_locArea.text = this.dataApi.getArea(this.dataApi.getSubArea(this._data.subAreaId).areaId).name + " ( " + this.dataApi.getSubArea(this._data.subAreaId).name + "), " + this._data.worldX + "," + this._data.worldY;
            this.sysApi.log(2," proprio : " + this._data.guildOwner);
            if(!this._data.guildOwner || this._data.guildOwner == "")
            {
               this.lbl_ownerContent.text = this.uiApi.getText("ui.common.none");
            }
            else
            {
               this.lbl_ownerContent.text = this._data.guildOwner;
            }
         }
         this.lbl_priceContent.x = this.lbl_price.x + this.lbl_price.width;
         this.tx_kamas.x = this.lbl_priceContent.x + this.lbl_priceContent.textWidth + 10;
      }
      
      public function onTextureReady(texture:Texture) : void
      {
         var maskCtr:Shape = null;
         if(texture == this.tx_houseIcon)
         {
            maskCtr = new Shape();
            maskCtr.graphics.beginFill(16711680);
            maskCtr.graphics.drawRect(1,-2,this.tx_illusBg.width - 6,this.tx_illusBg.height - 7);
            maskCtr.y = 95;
            this.tx_houseIcon.addChild(maskCtr);
            this.tx_houseIcon.mask = maskCtr;
            this.tx_houseIcon.visible = true;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_loc:
               this.sysApi.dispatchHook(HookList.AddMapFlag,"flag_teleportPoint",this.lbl_name.text + " (" + this._data.worldX + "," + this._data.worldY + ")",this.mapApi.getCurrentWorldMap().id,this._data.worldX,this._data.worldY,15636787,true);
               break;
            case this.btn_mp:
               if(this._data.hasOwner)
               {
                  this.sysApi.dispatchHook(ChatHookList.ChatFocus,this._data.ownerCharacterName);
               }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var skill:* = undefined;
         if(target == this.lbl_skill)
         {
            tooltipText = "";
            for each(skill in this._skillsList)
            {
               tooltipText += skill + " \n";
            }
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      private function onShortCut(s:String) : Boolean
      {
         if(s == "closeUi")
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return true;
         }
         return false;
      }
   }
}
