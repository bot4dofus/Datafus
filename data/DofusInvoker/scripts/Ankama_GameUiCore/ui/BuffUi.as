package Ankama_GameUiCore.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class BuffUi
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      private var _buffs:Object;
      
      private var _slots:Array;
      
      private var _hidden:Boolean = false;
      
      private var _backgroundWidthModifier:int;
      
      private var _backgroundOffset:int;
      
      private var _backgroundPreviousWidth:int;
      
      private var _foldStatus:Boolean;
      
      public var buffCtr:GraphicContainer;
      
      public var btn_minimArrow:ButtonContainer;
      
      public var tx_background:TextureBitmap;
      
      public var buffFrames:GraphicContainer;
      
      public var buff_slot_1:Texture;
      
      public var buff_slot_2:Texture;
      
      public var buff_slot_3:Texture;
      
      public var buff_slot_4:Texture;
      
      public var buff_slot_5:Texture;
      
      public var buff_slot_6:Texture;
      
      public var buff_slot_7:Texture;
      
      public var buff_slot_8:Texture;
      
      public function BuffUi()
      {
         super();
      }
      
      public function main(param:Object) : void
      {
         var slot:Texture = null;
         this._buffs = [];
         this._slots = [this.buff_slot_1,this.buff_slot_2,this.buff_slot_3,this.buff_slot_4,this.buff_slot_5,this.buff_slot_6,this.buff_slot_7,this.buff_slot_8];
         for each(slot in this._slots)
         {
            this.uiApi.addComponentHook(slot,"onRollOver");
            this.uiApi.addComponentHook(slot,"onRollOut");
            this.uiApi.addComponentHook(slot,"onRelease");
         }
         this.buffFrames.visible = false;
         this.tx_background.height = this.uiApi.me().getConstant("backgroundHeight");
         this._backgroundWidthModifier = this.uiApi.me().getConstant("backgroundWidthModifier");
         this._backgroundOffset = this.uiApi.me().getConstant("backgroundOffset");
         this.sysApi.addHook(InventoryHookList.RoleplayBuffViewContent,this.onInventoryUpdate);
         this.sysApi.addHook(CustomUiHookList.FoldAll,this.onFoldAll);
         this.update(param.buffs);
      }
      
      private function onInventoryUpdate(buffs:Object) : void
      {
         this.update(buffs);
         this._hidden = false;
         this.fold();
      }
      
      public function onRelease(target:Object) : void
      {
         var buff:Object = null;
         switch(target)
         {
            case this.btn_minimArrow:
               this._hidden = !this._hidden;
               this.fold();
               break;
            default:
               if(target.name.indexOf("slot") != -1)
               {
                  if(!this.sysApi.getOption("displayTooltips","dofus"))
                  {
                     buff = this._buffs[this._slots.indexOf(target)];
                     this.sysApi.dispatchHook(ChatHookList.ShowObjectLinked,buff);
                  }
               }
         }
      }
      
      private function fold() : void
      {
         this.buffFrames.visible = !this._hidden;
         this.btn_minimArrow.selected = this._hidden;
         if(this._hidden)
         {
            this.tx_background.width = this.uiApi.me().getConstant("widthBackgroundHidden");
         }
         else
         {
            this.tx_background.width = this._backgroundPreviousWidth;
         }
         this.uiApi.me().render();
      }
      
      private function onFoldAll(mustFold:Boolean) : void
      {
         this._hidden = mustFold;
         this.fold();
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         this.sysApi.log(2,"target : " + target.name);
         var buff:Object = this._buffs[this._slots.indexOf(target)];
         if(buff)
         {
            this.uiApi.showTooltip(buff,target,false,"standard",0,2,3,"itemName",null,{
               "showEffects":true,
               "header":true,
               "averagePrice":false,
               "noFooter":true,
               "noTheoreticalEffects":true
            },"ItemInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function update(buffs:Object) : void
      {
         var slot:Object = null;
         var i:int = 0;
         this._buffs = buffs;
         if(buffs.length == 0)
         {
            this.uiApi.me().visible = false;
         }
         else
         {
            this.uiApi.me().visible = true;
            for(i = 0; i < this._slots.length; i++)
            {
               slot = this._slots[i];
               if(i >= buffs.length)
               {
                  slot.visible = false;
               }
               else
               {
                  slot.visible = true;
                  slot.uri = buffs[i].iconUri;
               }
            }
            this.tx_background.width = (this._slots[0].width + 6) * buffs.length + this._backgroundWidthModifier;
            this._backgroundPreviousWidth = this.tx_background.width;
            this.uiApi.me().render();
         }
      }
   }
}
