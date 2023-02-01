package com.ankamagames.berilia.types.data
{
   public class TreeData
   {
       
      
      public var value;
      
      public var label:String;
      
      public var expend:Boolean;
      
      public var children:Vector.<TreeData>;
      
      public var parent:TreeData;
      
      public function TreeData(value:*, label:String, expend:Boolean = false, childs:Vector.<TreeData> = null, parent:TreeData = null)
      {
         super();
         this.value = value;
         this.label = label;
         this.expend = expend;
         this.children = childs;
         this.parent = parent;
      }
      
      public static function fromArray(a:Object) : Vector.<TreeData>
      {
         var root:TreeData = new TreeData(null,null,true);
         root.children = _fromArray(a,root);
         return root.children;
      }
      
      private static function _fromArray(a:Object, parent:TreeData) : Vector.<TreeData>
      {
         var td:TreeData = null;
         var children:* = undefined;
         var data:* = undefined;
         var res:Vector.<TreeData> = new Vector.<TreeData>();
         for each(data in a)
         {
            if(Object(data).hasOwnProperty("children"))
            {
               children = data.children;
            }
            else
            {
               children = null;
            }
            td = new TreeData(data,data.label,!!Object(data).hasOwnProperty("expend") ? Boolean(Object(data).expend) : false);
            td.parent = parent;
            td.children = _fromArray(children,td);
            res.push(td);
         }
         return res;
      }
      
      public function get depth() : uint
      {
         if(this.parent)
         {
            return this.parent.depth + 1;
         }
         return 0;
      }
   }
}
