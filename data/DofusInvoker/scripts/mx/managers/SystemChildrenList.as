package mx.managers
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import mx.core.IChildList;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   [ExcludeClass]
   public class SystemChildrenList implements IChildList
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
       
      
      private var owner:SystemManager;
      
      private var lowerBoundReference:QName;
      
      private var upperBoundReference:QName;
      
      public function SystemChildrenList(owner:SystemManager, lowerBoundReference:QName, upperBoundReference:QName)
      {
         super();
         this.owner = owner;
         this.lowerBoundReference = lowerBoundReference;
         this.upperBoundReference = upperBoundReference;
      }
      
      public function get numChildren() : int
      {
         return this.owner[this.upperBoundReference] - this.owner[this.lowerBoundReference];
      }
      
      public function addChild(child:DisplayObject) : DisplayObject
      {
         this.owner.rawChildren_addChildAt(child,this.owner[this.upperBoundReference]);
         ++this.owner[this.upperBoundReference];
         return child;
      }
      
      public function addChildAt(child:DisplayObject, index:int) : DisplayObject
      {
         this.owner.rawChildren_addChildAt(child,this.owner[this.lowerBoundReference] + index);
         ++this.owner[this.upperBoundReference];
         return child;
      }
      
      public function removeChild(child:DisplayObject) : DisplayObject
      {
         var index:int = this.owner.rawChildren_getChildIndex(child);
         if(this.owner[this.lowerBoundReference] <= index && index < this.owner[this.upperBoundReference])
         {
            this.owner.rawChildren_removeChild(child);
            --this.owner[this.upperBoundReference];
         }
         return child;
      }
      
      public function removeChildAt(index:int) : DisplayObject
      {
         var child:DisplayObject = this.owner.rawChildren_removeChildAt(index + this.owner[this.lowerBoundReference]);
         --this.owner[this.upperBoundReference];
         return child;
      }
      
      public function getChildAt(index:int) : DisplayObject
      {
         return this.owner.rawChildren_getChildAt(this.owner[this.lowerBoundReference] + index);
      }
      
      public function getChildByName(name:String) : DisplayObject
      {
         return this.owner.rawChildren_getChildByName(name);
      }
      
      public function getChildIndex(child:DisplayObject) : int
      {
         var retval:int = this.owner.rawChildren_getChildIndex(child);
         return int(retval - this.owner[this.lowerBoundReference]);
      }
      
      public function setChildIndex(child:DisplayObject, newIndex:int) : void
      {
         this.owner.rawChildren_setChildIndex(child,this.owner[this.lowerBoundReference] + newIndex);
      }
      
      public function getObjectsUnderPoint(point:Point) : Array
      {
         return this.owner.rawChildren_getObjectsUnderPoint(point);
      }
      
      public function contains(child:DisplayObject) : Boolean
      {
         var childIndex:int = 0;
         if(child != this.owner && this.owner.rawChildren_contains(child))
         {
            while(child.parent != this.owner)
            {
               child = child.parent;
            }
            childIndex = this.owner.rawChildren_getChildIndex(child);
            if(childIndex >= this.owner[this.lowerBoundReference] && childIndex < this.owner[this.upperBoundReference])
            {
               return true;
            }
         }
         return false;
      }
   }
}
