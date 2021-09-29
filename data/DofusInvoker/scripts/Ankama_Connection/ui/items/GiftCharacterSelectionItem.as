package Ankama_Connection.ui.items
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.MountApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.types.Uri;
   
   public class GiftCharacterSelectionItem
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="MountApi")]
      public var mountApi:MountApi;
      
      private var _data;
      
      private var _selected:Boolean;
      
      private var _bgLevelUri:Uri;
      
      private var _bgPrestigeUri:Uri;
      
      public var btn_character:ButtonContainer;
      
      public var lbl_name:Label;
      
      public var lbl_level:Label;
      
      public var tx_level:Texture;
      
      public var ed_avatar:EntityDisplayer;
      
      public function GiftCharacterSelectionItem()
      {
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         this._data = oParam.data;
         this._selected = false;
         this._bgLevelUri = this.uiApi.createUri(this.uiApi.me().getConstant("bgLevel_uri"));
         this._bgPrestigeUri = this.uiApi.createUri(this.uiApi.me().getConstant("bgPrestige_uri"));
         if(this.data)
         {
            this.uiApi.addComponentHook(this.btn_character,"onRollOver");
            this.uiApi.addComponentHook(this.btn_character,"onRelease");
            this.uiApi.addComponentHook(this.btn_character,"onRollOut");
         }
         else
         {
            this.uiApi.me().visible = false;
         }
         this.ed_avatar.setAnimationAndDirection("AnimArtwork",1);
         this.ed_avatar.view = "timeline";
         this.update(this._data,this._selected);
      }
      
      public function unload() : void
      {
      }
      
      public function get data() : *
      {
         return this._data;
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function update(data:*, selected:Boolean) : void
      {
         if(!data)
         {
            return;
         }
         this._selected = selected;
         this.btn_character.selected = selected;
         this.ed_avatar.width = 49;
         this.ed_avatar.height = 71;
         this.lbl_name.text = data.name;
         if(data.level > ProtocolConstantsEnum.MAX_LEVEL)
         {
            this.lbl_level.cssClass = "darkboldcenter";
            this.lbl_level.text = "" + (data.level - ProtocolConstantsEnum.MAX_LEVEL);
            this.tx_level.uri = this._bgPrestigeUri;
            this.uiApi.addComponentHook(this.tx_level,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_level,ComponentHookList.ON_ROLL_OUT);
         }
         else
         {
            this.lbl_level.cssClass = "boldcenter";
            this.lbl_level.text = data.level;
            this.tx_level.uri = this._bgLevelUri;
            this.uiApi.removeComponentHook(this.tx_level,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(this.tx_level,ComponentHookList.ON_ROLL_OUT);
         }
         this.ed_avatar.look = this.mountApi.getRiderEntityLook(data.entityLook);
         this._data = data;
      }
      
      public function select(b:Boolean) : void
      {
         this.btn_character.selected = b;
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_character:
               this.btn_character.bgAlpha = 0.2;
               break;
            case this.tx_level:
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.tooltip.OmegaLevel")),target,false,"standard",0,8,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_character:
               this.btn_character.bgAlpha = 0.2;
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_character:
               if(this._selected)
               {
                  this.btn_character.bgAlpha = 0.2;
               }
               else
               {
                  this.btn_character.bgAlpha = 0;
               }
         }
      }
   }
}
