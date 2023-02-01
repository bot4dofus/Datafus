package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.components.gridRenderer.MultipleComboBoxRenderer;
   import com.ankamagames.berilia.components.messages.SelectItemMessage;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.jerakine.messages.Message;
   
   public class MultipleComboBox extends ComboBox
   {
       
      
      public var placeholder:String = null;
      
      public function MultipleComboBox()
      {
         super();
      }
      
      override public function get value() : *
      {
         return (_list as MultipleComboBoxGrid).selectedValues;
      }
      
      override public function set value(values:*) : void
      {
         (_list as MultipleComboBoxGrid).selectedValues = values;
      }
      
      override public function renderModificator(childs:Array, accessKey:Object) : Array
      {
         var renderer:MultipleComboBoxRenderer = null;
         _mainContainer = new GraphicContainer();
         _list.rendererName = !!_list.rendererName ? _list.rendererName : "MultipleComboBoxRenderer";
         var toReturn:Array = super.renderModificator(childs,accessKey);
         if(_list.renderer is MultipleComboBoxRenderer)
         {
            renderer = _list.renderer as MultipleComboBoxRenderer;
            renderer.multiGrid = _list as MultipleComboBoxGrid;
            renderer.mainContainer = _mainContainer as GraphicContainer;
            renderer.placeholder = this.placeholder;
            renderer.initialize();
         }
         return toReturn;
      }
      
      override protected function setUpMainContainer() : void
      {
         _button.addChild(_mainContainer);
      }
      
      override protected function setGrid() : void
      {
         _list = new MultipleComboBoxGrid();
      }
      
      override public function process(msg:Message) : Boolean
      {
         switch(true)
         {
            case msg is SelectItemMessage:
               _list.renderer.update(_list.selectedItem,0,_mainContainer,true);
               return false;
            default:
               return super.process(msg);
         }
      }
   }
}
