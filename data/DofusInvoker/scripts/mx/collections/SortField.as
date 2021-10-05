package mx.collections
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import mx.collections.errors.SortError;
   import mx.core.mx_internal;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   import mx.utils.ObjectUtil;
   
   use namespace mx_internal;
   
   public class SortField extends EventDispatcher implements ISortField
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
       
      
      private var resourceManager:IResourceManager;
      
      private var _caseInsensitive:Boolean;
      
      private var _compareFunction:Function;
      
      private var _descending:Boolean;
      
      private var _name:String;
      
      private var _numeric:Object;
      
      private var _sortCompareType:String = null;
      
      private var _usingCustomCompareFunction:Boolean;
      
      public function SortField(name:String = null, caseInsensitive:Boolean = false, descending:Boolean = false, numeric:Object = null, sortCompareType:String = null, customCompareFunction:Function = null)
      {
         this.resourceManager = ResourceManager.getInstance();
         super();
         this._name = name;
         this._caseInsensitive = caseInsensitive;
         this._descending = descending;
         this._numeric = numeric;
         this._sortCompareType = sortCompareType;
         if(customCompareFunction != null)
         {
            this.compareFunction = customCompareFunction;
         }
         else if(this.updateSortCompareType() == false)
         {
            this._compareFunction = this.stringCompare;
         }
      }
      
      public function get arraySortOnOptions() : int
      {
         if(this.usingCustomCompareFunction || this.name == null || this._compareFunction == this.xmlCompare || this._compareFunction == this.dateCompare)
         {
            return -1;
         }
         var options:* = 0;
         if(this.caseInsensitive)
         {
            options |= Array.CASEINSENSITIVE;
         }
         if(this.descending)
         {
            options |= Array.DESCENDING;
         }
         if(this.numeric == true || this._compareFunction == this.numericCompare)
         {
            options |= Array.NUMERIC;
         }
         return options;
      }
      
      [Bindable("caseInsensitiveChanged")]
      [Inspectable(category="General")]
      public function get caseInsensitive() : Boolean
      {
         return this._caseInsensitive;
      }
      
      mx_internal function setCaseInsensitive(value:Boolean) : void
      {
         if(value != this._caseInsensitive)
         {
            this._caseInsensitive = value;
            dispatchEvent(new Event("caseInsensitiveChanged"));
         }
      }
      
      [Inspectable(category="General")]
      public function get compareFunction() : Function
      {
         return this._compareFunction;
      }
      
      public function set compareFunction(c:Function) : void
      {
         this._compareFunction = c;
         this._usingCustomCompareFunction = c != null;
      }
      
      [Bindable("descendingChanged")]
      [Inspectable(category="General")]
      public function get descending() : Boolean
      {
         return this._descending;
      }
      
      public function set descending(value:Boolean) : void
      {
         if(this._descending != value)
         {
            this._descending = value;
            dispatchEvent(new Event("descendingChanged"));
         }
      }
      
      [Bindable("nameChanged")]
      [Inspectable(category="General")]
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(n:String) : void
      {
         this._name = n;
         dispatchEvent(new Event("nameChanged"));
      }
      
      [Bindable("numericChanged")]
      [Inspectable(category="General")]
      public function get numeric() : Object
      {
         return this._numeric;
      }
      
      public function set numeric(value:Object) : void
      {
         if(this._numeric != value)
         {
            this._numeric = value;
            dispatchEvent(new Event("numericChanged"));
         }
      }
      
      [Bindable("sortCompareTypeChanged")]
      public function get sortCompareType() : String
      {
         return this._sortCompareType;
      }
      
      public function set sortCompareType(value:String) : void
      {
         if(this._sortCompareType != value)
         {
            this._sortCompareType = value;
            dispatchEvent(new Event("sortCompareTypeChanged"));
         }
         this.updateSortCompareType();
      }
      
      public function get usingCustomCompareFunction() : Boolean
      {
         return this._usingCustomCompareFunction;
      }
      
      override public function toString() : String
      {
         return ObjectUtil.toString(this);
      }
      
      public function initializeDefaultCompareFunction(obj:Object) : void
      {
         var value:Object = null;
         var typ:* = null;
         var test:String = null;
         if(!this.usingCustomCompareFunction)
         {
            if(this._sortCompareType)
            {
               if(this.updateSortCompareType() == true)
               {
                  return;
               }
            }
            if(this.numeric == true)
            {
               this._compareFunction = this.numericCompare;
            }
            else if(this.caseInsensitive || this.numeric == false)
            {
               this._compareFunction = this.stringCompare;
            }
            else
            {
               if(this._name)
               {
                  value = this.getSortFieldValue(obj);
               }
               if(value == null)
               {
                  value = obj;
               }
               typ = typeof value;
               switch(typ)
               {
                  case "string":
                     this._compareFunction = this.stringCompare;
                     break;
                  case "object":
                     if(value is Date)
                     {
                        this._compareFunction = this.dateCompare;
                     }
                     else
                     {
                        this._compareFunction = this.stringCompare;
                        try
                        {
                           test = value.toString();
                        }
                        catch(error2:Error)
                        {
                        }
                        if(!test || test == "[object Object]")
                        {
                           this._compareFunction = this.nullCompare;
                        }
                     }
                     break;
                  case "xml":
                     this._compareFunction = this.xmlCompare;
                     break;
                  case "boolean":
                  case "number":
                     this._compareFunction = this.numericCompare;
               }
            }
         }
      }
      
      public function reverse() : void
      {
         this.descending = !this.descending;
      }
      
      public function updateSortCompareType() : Boolean
      {
         if(!this._sortCompareType)
         {
            return false;
         }
         switch(this._sortCompareType)
         {
            case SortFieldCompareTypes.DATE:
               this._compareFunction = this.dateCompare;
               return true;
            case SortFieldCompareTypes.NULL:
               this._compareFunction = this.nullCompare;
               return true;
            case SortFieldCompareTypes.NUMERIC:
               this._compareFunction = this.numericCompare;
               return true;
            case SortFieldCompareTypes.STRING:
               this._compareFunction = this.stringCompare;
               return true;
            case SortFieldCompareTypes.XML:
               this._compareFunction = this.xmlCompare;
               return true;
            default:
               return false;
         }
      }
      
      public function objectHasSortField(object:Object) : Boolean
      {
         return this.getSortFieldValue(object) !== undefined;
      }
      
      protected function getSortFieldValue(obj:Object) : *
      {
         var result:* = undefined;
         try
         {
            result = obj[this._name];
         }
         catch(error:Error)
         {
         }
         return result;
      }
      
      private function nullCompare(a:Object, b:Object) : int
      {
         var left:Object = null;
         var right:Object = null;
         var message:String = null;
         var found:Boolean = false;
         if(a == null && b == null)
         {
            return 0;
         }
         if(this._name)
         {
            left = this.getSortFieldValue(a);
            right = this.getSortFieldValue(b);
         }
         if(left == null && right == null)
         {
            return 0;
         }
         if(left == null && !this._name)
         {
            left = a;
         }
         if(right == null && !this._name)
         {
            right = b;
         }
         var typeLeft:* = typeof left;
         var typeRight:* = typeof right;
         if(typeLeft == "string" || typeRight == "string")
         {
            found = true;
            this._compareFunction = this.stringCompare;
         }
         else if(typeLeft == "object" || typeRight == "object")
         {
            if(left is Date || right is Date)
            {
               found = true;
               this._compareFunction = this.dateCompare;
            }
         }
         else if(typeLeft == "xml" || typeRight == "xml")
         {
            found = true;
            this._compareFunction = this.xmlCompare;
         }
         else if(typeLeft == "number" || typeRight == "number" || typeLeft == "boolean" || typeRight == "boolean")
         {
            found = true;
            this._compareFunction = this.numericCompare;
         }
         if(found)
         {
            return this._compareFunction(left,right);
         }
         message = this.resourceManager.getString("collections","noComparatorSortField",[this.name]);
         throw new SortError(message);
      }
      
      private function numericCompare(a:Object, b:Object) : int
      {
         var fa:Number = this._name == null ? Number(Number(a)) : Number(Number(this.getSortFieldValue(a)));
         var fb:Number = this._name == null ? Number(Number(b)) : Number(Number(this.getSortFieldValue(b)));
         return ObjectUtil.numericCompare(fa,fb);
      }
      
      private function dateCompare(a:Object, b:Object) : int
      {
         var fa:Date = this._name == null ? a as Date : this.getSortFieldValue(a) as Date;
         var fb:Date = this._name == null ? b as Date : this.getSortFieldValue(b) as Date;
         return ObjectUtil.dateCompare(fa,fb);
      }
      
      protected function stringCompare(a:Object, b:Object) : int
      {
         var fa:String = this._name == null ? String(a) : String(this.getSortFieldValue(a));
         var fb:String = this._name == null ? String(b) : String(this.getSortFieldValue(b));
         return ObjectUtil.stringCompare(fa,fb,this._caseInsensitive);
      }
      
      protected function xmlCompare(a:Object, b:Object) : int
      {
         var sa:String = this._name == null ? a.toString() : this.getSortFieldValue(a).toString();
         var sb:String = this._name == null ? b.toString() : this.getSortFieldValue(b).toString();
         if(this.numeric == true)
         {
            return ObjectUtil.numericCompare(parseFloat(sa),parseFloat(sb));
         }
         return ObjectUtil.stringCompare(sa,sb,this._caseInsensitive);
      }
   }
}
