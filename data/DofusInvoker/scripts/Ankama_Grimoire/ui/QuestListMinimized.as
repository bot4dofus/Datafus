package Ankama_Grimoire.ui
{
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   
   public class QuestListMinimized extends AbstractQuestList
   {
       
      
      private var _lastX:Number;
      
      private var _lastY:Number;
      
      public var mainCtr:GraphicContainer;
      
      public var btn_questList:ButtonContainer;
      
      public function QuestListMinimized()
      {
         super();
      }
      
      override protected function setVisible(value:Boolean) : void
      {
         if(sysApi.getData("questListMinimized",DataStoreEnum.BIND_ACCOUNT))
         {
            super.setVisible(value && !playerApi.isInTutorialArea());
         }
      }
      
      override public function main(params:Object) : void
      {
         super.main(params);
      }
      
      public function onMouseUp(target:GraphicContainer) : void
      {
         var questListUi:* = undefined;
         var wasDragging:Boolean = Math.round(this.mainCtr.x) != this._lastX || Math.round(this.mainCtr.y) != this._lastY;
         if(!wasDragging && target == this.btn_questList)
         {
            questListUi = uiApi.getUi(UIEnum.QUEST_LIST);
            if(questListUi && questListUi.uiClass)
            {
               this.setVisible(false);
               questListUi.uiClass.maximize();
            }
         }
      }
      
      public function onPress(target:GraphicContainer) : void
      {
         this._lastX = Math.round(this.mainCtr.x);
         this._lastY = Math.round(this.mainCtr.y);
      }
   }
}
