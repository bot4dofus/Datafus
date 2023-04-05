package com.ankamagames.jerakine.network.utils
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class FuncTree
   {
       
      
      private var _func:Function;
      
      private var _parent:FuncTree;
      
      private var _children:Vector.<FuncTree>;
      
      private var _input:ICustomDataInput;
      
      private var _current:FuncTree;
      
      private var _index:uint = 0;
      
      public function FuncTree(parent:FuncTree = null, func:Function = null)
      {
         super();
         this._parent = parent;
         this._func = func;
      }
      
      public function get children() : Vector.<FuncTree>
      {
         return this._children;
      }
      
      public function setRoot(input:ICustomDataInput) : void
      {
         this._input = input;
         this._current = this;
      }
      
      public function addChild(func:Function) : FuncTree
      {
         var child:FuncTree = new FuncTree(this,func);
         if(this._children == null)
         {
            this._children = new Vector.<FuncTree>();
         }
         this._children.push(child);
         return child;
      }
      
      public function next() : Boolean
      {
         this._current._func(this._input);
         if(this.goDown())
         {
            return true;
         }
         return this.goUp();
      }
      
      private function goUp() : Boolean
      {
         while(true)
         {
            this._current = this._current._parent;
            if(this._current._index != this._current._children.length)
            {
               break;
            }
            if(this._current._parent == null)
            {
               return false;
            }
         }
         this._current = this._current._children[this._current._index++];
         return true;
      }
      
      public function goDown() : Boolean
      {
         if(this._current._children == null)
         {
            return false;
         }
         if(this._current._index == this._current._children.length)
         {
            return false;
         }
         this._current = this._current._children[this._current._index++];
         return true;
      }
   }
}
