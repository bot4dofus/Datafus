package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.berilia.components.gridRenderer.TreeGridRenderer;
   import com.ankamagames.berilia.types.data.TreeData;
   import flash.errors.IllegalOperationError;
   import flash.utils.getQualifiedClassName;
   
   public class Tree extends Grid implements UIComponent
   {
       
      
      protected var _realDataProvider;
      
      protected var _treeDataProvider:Vector.<TreeData>;
      
      public function Tree()
      {
         super();
         _sRendererName = getQualifiedClassName(TreeGridRenderer);
      }
      
      override public function set rendererName(value:String) : void
      {
         throw new IllegalOperationError("rendererName cannot be set");
      }
      
      override public function set dataProvider(data:*) : void
      {
         this._realDataProvider = data;
         this._treeDataProvider = TreeData.fromArray(data);
         super.dataProvider = this.makeDataProvider(this._treeDataProvider);
      }
      
      override public function get dataProvider() : *
      {
         return this._realDataProvider;
      }
      
      public function get treeRoot() : TreeData
      {
         var treeRoot:TreeData = null;
         if(_dataProvider.length > 0)
         {
            treeRoot = _dataProvider[0].parent;
         }
         return treeRoot;
      }
      
      public function rerender() : void
      {
         super.dataProvider = this.makeDataProvider(this._treeDataProvider);
      }
      
      public function expandItems(pItems:Array) : void
      {
         var item:Object = null;
         var treeData:TreeData = null;
         if(!pItems)
         {
            return;
         }
         for each(item in pItems)
         {
            treeData = item as TreeData;
            if(treeData.children.length > 0)
            {
               treeData.expend = true;
            }
         }
         this.rerender();
      }
      
      private function makeDataProvider(v:Vector.<TreeData>, result:Vector.<TreeData> = null) : Vector.<TreeData>
      {
         var node:TreeData = null;
         if(!result)
         {
            result = new Vector.<TreeData>();
         }
         for each(node in v)
         {
            result.push(node);
            if(node.expend)
            {
               this.makeDataProvider(node.children,result);
            }
         }
         return result;
      }
   }
}
