package Ankama_Grimoire.ui.optionalFeatures
{
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.PresetDeleteRequestAction;
   import com.ankamagames.dofus.uiApi.ChatApi;
   
   public class ForgettableModsterSetsUi extends ForgettableSpellSetsUi
   {
       
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      private var _currentDeletedSpellSet:Object = null;
      
      public function ForgettableModsterSetsUi()
      {
         super();
      }
      
      override public function main(paramsObject:Object = null) : void
      {
         super.main(paramsObject);
      }
      
      override public function onRollOver(target:GraphicContainer) : void
      {
         uiApi.hideTooltip(TOOLTIP_UI_NAME);
         uiApi.hideTooltip(STANDARD_TOOLTIP_UI_NAME);
         if(target.name.indexOf("btn_deleteSet") != -1)
         {
            uiApi.showTooltip(uiApi.textTooltipInfo(uiApi.getText("ui.temporis.modsters.team.delete")),target,false,TOOLTIP_UI_NAME,LocationEnum.POINT_TOP,LocationEnum.POINT_BOTTOM,0,null,null,null,"TextInfo");
         }
         else
         {
            super.onRollOver(target);
         }
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         if(target.name.indexOf("btn_deleteSet") != -1)
         {
            this.deleteModsterSet(_componentsDictionary[target.name]);
         }
         else
         {
            super.onRelease(target);
         }
      }
      
      override protected function additionnalComponents(spellSetDescr:Object, components:*) : void
      {
         _componentsDictionary[components.btn_deleteSet.name] = spellSetDescr;
      }
      
      override protected function get editSetOverText() : String
      {
         return uiApi.getText("ui.temporis.modsters.team.edit");
      }
      
      private function deleteModsterSet(spellSetDescr:Object, isForce:Boolean = false) : void
      {
         var onValidModsterSetDelete:Function = null;
         var onCancel:Function = null;
         if(!isForce)
         {
            onValidModsterSetDelete = function():void
            {
               deleteModsterSet(spellSetDescr,true);
            };
            onCancel = function():void
            {
            };
            ankamaCommon.openTextButtonPopup(uiApi.getText("ui.common.confirm"),uiApi.getText("ui.temporis.modsters.team.deleteConfirmation"),[uiApi.getText("ui.popup.delete"),uiApi.getText("ui.common.cancel")],[onValidModsterSetDelete,onCancel],onValidModsterSetDelete,onCancel);
         }
         else
         {
            this._currentDeletedSpellSet = spellSetDescr;
            systemApi.sendAction(new PresetDeleteRequestAction([spellSetDescr.spellSetId]));
         }
      }
      
      override public function onPresetsUpdate(buildId:int = -1) : void
      {
         if(this._currentDeletedSpellSet)
         {
            this.chatApi.sendInfoOnChat(uiApi.getText("ui.temporis.spellSetDeleted",this._currentDeletedSpellSet.spellSetName));
            this._currentDeletedSpellSet = null;
         }
         super.onPresetsUpdate(buildId);
      }
   }
}
