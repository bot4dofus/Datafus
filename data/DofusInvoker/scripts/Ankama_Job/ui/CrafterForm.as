package Ankama_Job.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterContactLookRequestAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.JobsApi;
   import com.ankamagames.dofus.uiApi.MountApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class CrafterForm
   {
       
      
      public var output:Object;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="JobsApi")]
      public var jobsApi:JobsApi;
      
      [Api(name="MountApi")]
      public var mountApi:MountApi;
      
      private var _data:Object;
      
      public var crafterFormCtr:GraphicContainer;
      
      public var entdis_character:EntityDisplayer;
      
      public var tx_bgDeco:Texture;
      
      public var btn_free:ButtonContainer;
      
      public var btn_mp:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var lbl_nameContent:Label;
      
      public var lbl_jobContent:Label;
      
      public var lbl_levelContent:Label;
      
      public var lbl_subareaContent:Label;
      
      public var lbl_craftingContent:Label;
      
      public var lbl_coordContent:Label;
      
      public var lbl_minLevelContent:Label;
      
      public function CrafterForm()
      {
         super();
      }
      
      public function main(... args) : void
      {
         this.sysApi.addHook(CraftHookList.JobCrafterContactLook,this.onJobCrafterContactLook);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this._data = args[0];
         this.updateInformations();
         this.entdis_character.direction = 2;
         this.sysApi.sendAction(new JobCrafterContactLookRequestAction([this._data.playerId]));
         this.btn_free.disabled = true;
      }
      
      public function unload() : void
      {
      }
      
      private function updateInformations() : void
      {
         var sa:SubArea = null;
         if(this._data.alignmentSide >= 0)
         {
            this.tx_bgDeco.uri = this.uiApi.createUri(this.uiApi.me().getConstant("alignment_uri") + this._data.alignmentSide);
         }
         else
         {
            this.tx_bgDeco.uri = this.uiApi.createUri(this.uiApi.me().getConstant("alignment_uri") + "0");
         }
         this.lbl_nameContent.text = "{player," + this._data.playerName + "," + this._data.playerId + "::" + this._data.playerName + "}";
         this.lbl_jobContent.text = this.jobsApi.getJobName(this._data.jobId);
         this.lbl_levelContent.text = this._data.jobLevel;
         if(!this._data.isInWorkshop)
         {
            this.lbl_craftingContent.text = this.uiApi.getText("ui.common.no");
            this.lbl_coordContent.text = "-";
            this.lbl_subareaContent.text = "";
         }
         else
         {
            this.lbl_craftingContent.text = this.uiApi.getText("ui.common.yes");
            this.lbl_coordContent.text = this._data.worldPos;
            sa = this.dataApi.getSubArea(this._data.subAreaId);
            this.lbl_subareaContent.text = this.dataApi.getArea(sa.areaId).name + " ( " + sa.name + " )";
         }
         this.btn_free.selected = this._data.freeCraft;
         this.lbl_minLevelContent.text = this.uiApi.getText("ui.craft.minLevel") + this.uiApi.getText("ui.common.colon") + this._data.minLevelCraft;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_mp:
               this.sysApi.dispatchHook(ChatHookList.ChatFocus,this._data.playerName);
         }
      }
      
      public function onJobCrafterContactLook(crafterId:Number, crafterName:String, crafterLook:*) : void
      {
         if(this.lbl_nameContent.text == crafterName)
         {
            this.entdis_character.look = this.mountApi.getRiderEntityLook(crafterLook);
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
   }
}
