package Ankama_Mount.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.mount.MountData;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   
   public class MountAncestors
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _mount:MountData;
      
      private var _names:Array;
      
      public var btn_help:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var lbl_title:Label;
      
      public var lbl_name:Label;
      
      public var d0:EntityDisplayer;
      
      public var d1:EntityDisplayer;
      
      public var d2:EntityDisplayer;
      
      public var d3:EntityDisplayer;
      
      public var d4:EntityDisplayer;
      
      public var d5:EntityDisplayer;
      
      public var d6:EntityDisplayer;
      
      public var d7:EntityDisplayer;
      
      public var d8:EntityDisplayer;
      
      public var d9:EntityDisplayer;
      
      public var d10:EntityDisplayer;
      
      public var d11:EntityDisplayer;
      
      public var d12:EntityDisplayer;
      
      public var d13:EntityDisplayer;
      
      public var d14:EntityDisplayer;
      
      public function MountAncestors()
      {
         super();
      }
      
      public function main(param:Object) : void
      {
         this._names = [];
         for(var i:int = 0; i < 15; i++)
         {
            this.uiApi.addComponentHook(this["d" + i],"onRollOver");
            this.uiApi.addComponentHook(this["d" + i],"onRollOut");
         }
         this.uiApi.addComponentHook(this.btn_help,ComponentHookList.ON_RELEASE);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortCut);
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         this._mount = param.mount;
         this.lbl_title.text = this.uiApi.getText("ui.mount.ancestors",this._mount.name);
         this.lbl_name.text = this._mount.name;
         this.d0.look = this._mount.ancestor.entityLook;
         this.displayMount(this._mount.ancestor,this.d1,this.d2);
         this._names[this.d0.name] = this._mount.description;
         if(this._mount.ancestor.father)
         {
            this.displayMount(this._mount.ancestor.father,this.d3,this.d4);
            this.displayMount(this._mount.ancestor.mother,this.d5,this.d6);
            if(this._mount.ancestor.father.father)
            {
               this.displayMount(this._mount.ancestor.father.father,this.d7,this.d8);
               this.displayMount(this._mount.ancestor.father.mother,this.d9,this.d10);
            }
            if(this._mount.ancestor.mother.father)
            {
               this.displayMount(this._mount.ancestor.mother.father,this.d11,this.d12);
               this.displayMount(this._mount.ancestor.mother.mother,this.d13,this.d14);
            }
         }
         this.uiApi.addComponentHook(this.btn_close,"onRelease");
      }
      
      public function unload() : void
      {
         this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
         this._mount = null;
         this._names = null;
      }
      
      private function displayMount(mountInfo:Object, ed1:Object, ed2:Object) : void
      {
         if(mountInfo.father)
         {
            ed1.look = mountInfo.father.entityLook;
            this._names[ed1.name] = mountInfo.father.mount.name;
         }
         if(mountInfo.mother)
         {
            ed2.look = mountInfo.mother.entityLook;
            this._names[ed2.name] = mountInfo.mother.mount.name;
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var textTooltip:TextTooltipInfo = this.uiApi.textTooltipInfo(this._names[target.name]);
         if(textTooltip)
         {
            this.uiApi.showTooltip(textTooltip,target,false,"standard",1,7,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_help:
               this.hintsApi.showSubHints();
               break;
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
         }
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
