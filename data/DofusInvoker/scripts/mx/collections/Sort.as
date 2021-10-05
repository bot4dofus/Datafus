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
   
   public class Sort extends EventDispatcher implements ISort
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      public static const ANY_INDEX_MODE:String = "any";
      
      public static const FIRST_INDEX_MODE:String = "first";
      
      public static const LAST_INDEX_MODE:String = "last";
       
      
      private var resourceManager:IResourceManager;
      
      mx_internal var useSortOn:Boolean = true;
      
      private var _compareFunction:Function;
      
      private var usingCustomCompareFunction:Boolean;
      
      private var _fields:Array;
      
      private var _unique:Boolean;
      
      private var defaultEmptyField:ISortField;
      
      private var noFieldsDescending:Boolean = false;
      
      public function Sort(fields:Array = null, customCompareFunction:Function = null, unique:Boolean = false)
      {
         this.resourceManager = ResourceManager.getInstance();
         super();
         this.fields = fields;
         this.compareFunction = customCompareFunction;
         this.unique = unique;
      }
      
      [Inspectable(category="General")]
      public function get compareFunction() : Function
      {
         return !!this.usingCustomCompareFunction ? this._compareFunction : this.internalCompare;
      }
      
      public function set compareFunction(value:Function) : void
      {
         this._compareFunction = value;
         this.usingCustomCompareFunction = this._compareFunction != null;
      }
      
      [Bindable("fieldsChanged")]
      [Inspectable(arrayType="mx.collections.ISortField",category="General")]
      public function get fields() : Array
      {
         return this._fields;
      }
      
      public function set fields(value:Array) : void
      {
         this._fields = value;
         dispatchEvent(new Event("fieldsChanged"));
      }
      
      [Inspectable(category="General")]
      public function get unique() : Boolean
      {
         return this._unique;
      }
      
      public function set unique(value:Boolean) : void
      {
         this._unique = value;
      }
      
      override public function toString() : String
      {
         return ObjectUtil.toString(this);
      }
      
      public function findItem(items:Array, values:Object, mode:String, returnInsertionIndex:Boolean = false, compareFunction:Function = null) : int
      {
         var compareForFind:Function = null;
         var fieldsForCompare:Array = null;
         var message:String = null;
         var index:int = 0;
         var field:ISortField = null;
         var hadPreviousFieldName:Boolean = false;
         var i:int = 0;
         var objIndex:int = 0;
         var match:* = false;
         var prevCompare:int = 0;
         var nextCompare:int = 0;
         if(!items)
         {
            message = this.resourceManager.getString("collections","noItems");
            throw new SortError(message);
         }
         if(items.length == 0)
         {
            return !!returnInsertionIndex ? 1 : -1;
         }
         if(compareFunction == null)
         {
            compareForFind = this.compareFunction;
            if(values && this.fields && this.fields.length > 0)
            {
               fieldsForCompare = [];
               hadPreviousFieldName = true;
               for(i = 0; i < this.fields.length; i++)
               {
                  field = this.fields[i] as ISortField;
                  if(field.name)
                  {
                     if(field.objectHasSortField(values))
                     {
                        if(!hadPreviousFieldName)
                        {
                           message = this.resourceManager.getString("collections","findCondition",[field.name]);
                           throw new SortError(message);
                        }
                        fieldsForCompare.push(field.name);
                     }
                     else
                     {
                        hadPreviousFieldName = false;
                     }
                  }
                  else
                  {
                     fieldsForCompare.push(null);
                  }
               }
               if(fieldsForCompare.length == 0)
               {
                  message = this.resourceManager.getString("collections","findRestriction");
                  throw new SortError(message);
               }
               try
               {
                  this.initSortFields(items[0]);
               }
               catch(initSortError:SortError)
               {
               }
            }
         }
         else
         {
            compareForFind = compareFunction;
         }
         var found:* = false;
         var objFound:Boolean = false;
         index = 0;
         var lowerBound:int = 0;
         var upperBound:int = items.length - 1;
         var obj:Object = null;
         var direction:int = 1;
         while(true)
         {
            if(!(!objFound && lowerBound <= upperBound))
            {
               if(!found && !returnInsertionIndex)
               {
                  return -1;
               }
               return direction > 0 ? int(index + 1) : int(index);
            }
            index = Math.round((lowerBound + upperBound) / 2);
            obj = items[index];
            direction = !!fieldsForCompare ? int(compareForFind(values,obj,fieldsForCompare)) : int(compareForFind(values,obj));
            switch(direction)
            {
               case -1:
                  upperBound = index - 1;
                  break;
               case 0:
                  objFound = true;
                  switch(mode)
                  {
                     case ANY_INDEX_MODE:
                        found = true;
                        break;
                     case FIRST_INDEX_MODE:
                        found = index == lowerBound;
                        objIndex = index - 1;
                        match = true;
                        while(match && !found && objIndex >= lowerBound)
                        {
                           obj = items[objIndex];
                           prevCompare = !!fieldsForCompare ? int(compareForFind(values,obj,fieldsForCompare)) : int(compareForFind(values,obj));
                           match = prevCompare == 0;
                           if(!match || match && objIndex == lowerBound)
                           {
                              found = true;
                              index = objIndex + (!!match ? 0 : 1);
                           }
                           objIndex--;
                        }
                        break;
                     case LAST_INDEX_MODE:
                        found = index == upperBound;
                        objIndex = index + 1;
                        match = true;
                        while(match && !found && objIndex <= upperBound)
                        {
                           obj = items[objIndex];
                           nextCompare = !!fieldsForCompare ? int(compareForFind(values,obj,fieldsForCompare)) : int(compareForFind(values,obj));
                           match = nextCompare == 0;
                           if(!match || match && objIndex == upperBound)
                           {
                              found = true;
                              index = objIndex - (!!match ? 0 : 1);
                           }
                           objIndex++;
                        }
                  }
                  break;
               case 1:
                  lowerBound = index + 1;
                  break;
            }
         }
         message = this.resourceManager.getString("collections","unknownMode");
         throw new SortError(message);
      }
      
      public function propertyAffectsSort(property:String) : Boolean
      {
         var field:ISortField = null;
         if(this.usingCustomCompareFunction || !this.fields)
         {
            return true;
         }
         for(var i:int = 0; i < this.fields.length; i++)
         {
            field = this.fields[i];
            if(field.name == property || field.usingCustomCompareFunction)
            {
               return true;
            }
         }
         return false;
      }
      
      public function reverse() : void
      {
         var i:int = 0;
         if(this.fields)
         {
            for(i = 0; i < this.fields.length; i++)
            {
               ISortField(this.fields[i]).reverse();
            }
         }
         this.noFieldsDescending = !this.noFieldsDescending;
      }
      
      public function sort(items:Array) : void
      {
         var fixedCompareFunction:Function = null;
         var message:String = null;
         var uniqueRet1:Object = null;
         var sortArgs:Object = null;
         var uniqueRet2:Object = null;
         if(!items || items.length <= 1)
         {
            return;
         }
         if(this.usingCustomCompareFunction)
         {
            fixedCompareFunction = function(a:Object, b:Object):int
            {
               return compareFunction(a,b,_fields);
            };
            if(this.unique)
            {
               uniqueRet1 = items.sort(fixedCompareFunction,Array.UNIQUESORT);
               if(uniqueRet1 == 0)
               {
                  message = this.resourceManager.getString("collections","nonUnique");
                  throw new SortError(message);
               }
            }
            else
            {
               items.sort(fixedCompareFunction);
            }
         }
         else if(this.fields && this.fields.length > 0)
         {
            sortArgs = this.initSortFields(items[0],true);
            if(this.unique)
            {
               if(this.useSortOn && sortArgs && this.fields.length == 1)
               {
                  uniqueRet2 = items.sortOn(sortArgs.fields[0],sortArgs.options[0] | Array.UNIQUESORT);
               }
               else
               {
                  uniqueRet2 = items.sort(this.internalCompare,Array.UNIQUESORT);
               }
               if(uniqueRet2 == 0)
               {
                  message = this.resourceManager.getString("collections","nonUnique");
                  throw new SortError(message);
               }
            }
            else if(this.useSortOn && sortArgs)
            {
               items.sortOn(sortArgs.fields,sortArgs.options);
            }
            else
            {
               items.sort(this.internalCompare);
            }
         }
         else
         {
            items.sort(this.internalCompare);
         }
      }
      
      private function initSortFields(item:Object, buildArraySortArgs:Boolean = false) : Object
      {
         var i:int = 0;
         var field:ISortField = null;
         var options:int = 0;
         var arraySortArgs:Object = null;
         for(i = 0; i < this.fields.length; i++)
         {
            ISortField(this.fields[i]).initializeDefaultCompareFunction(item);
         }
         if(buildArraySortArgs)
         {
            arraySortArgs = {
               "fields":[],
               "options":[]
            };
            for(i = 0; i < this.fields.length; i++)
            {
               field = this.fields[i];
               options = field.arraySortOnOptions;
               if(options == -1)
               {
                  return null;
               }
               arraySortArgs.fields.push(field.name);
               arraySortArgs.options.push(options);
            }
         }
         return arraySortArgs;
      }
      
      private function internalCompare(a:Object, b:Object, fields:Array = null) : int
      {
         var i:int = 0;
         var len:int = 0;
         var sf:ISortField = null;
         var result:int = 0;
         if(!this._fields)
         {
            result = this.noFieldsCompare(a,b);
         }
         else
         {
            i = 0;
            len = !!fields ? int(fields.length) : int(this._fields.length);
            while(result == 0 && i < len)
            {
               sf = ISortField(this._fields[i]);
               result = sf.compareFunction(a,b);
               if(sf.descending)
               {
                  result *= -1;
               }
               i++;
            }
         }
         return result;
      }
      
      private function noFieldsCompare(a:Object, b:Object, fields:Array = null) : int
      {
         var message:String = null;
         if(!this.defaultEmptyField)
         {
            this.defaultEmptyField = this.createEmptySortField();
            try
            {
               this.defaultEmptyField.initializeDefaultCompareFunction(a);
            }
            catch(e:SortError)
            {
               message = resourceManager.getString("collections","noComparator",[a]);
               throw new SortError(message);
            }
         }
         var result:int = this.defaultEmptyField.compareFunction(a,b);
         if(this.noFieldsDescending)
         {
            result *= -1;
         }
         return result;
      }
      
      protected function createEmptySortField() : ISortField
      {
         return new SortField();
      }
   }
}
