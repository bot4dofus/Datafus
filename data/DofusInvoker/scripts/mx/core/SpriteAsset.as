package mx.core
{
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   
   use namespace mx_internal;
   
   public class SpriteAsset extends FlexSprite implements IFlexAsset, IFlexDisplayObject, IBorder, ILayoutDirectionElement
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      private static var FlexVersionClass:Class;
      
      private static var MatrixUtilClass:Class;
       
      
      private var layoutFeaturesClass:Class;
      
      private var layoutFeatures:IAssetLayoutFeatures;
      
      private var _height:Number;
      
      private var _layoutDirection:String = "ltr";
      
      private var _measuredHeight:Number;
      
      private var _measuredWidth:Number;
      
      public function SpriteAsset()
      {
         var appDomain:ApplicationDomain = null;
         super();
         this._measuredWidth = this.width;
         this._measuredHeight = this.height;
         if(FlexVersionClass == null)
         {
            appDomain = ApplicationDomain.currentDomain;
            if(appDomain.hasDefinition("mx.core::FlexVersion"))
            {
               FlexVersionClass = Class(appDomain.getDefinition("mx.core::FlexVersion"));
            }
         }
         if(FlexVersionClass && FlexVersionClass["compatibilityVersion"] >= FlexVersionClass["VERSION_4_0"])
         {
            this.addEventListener(Event.ADDED,this.addedHandler);
         }
      }
      
      override public function get x() : Number
      {
         return this.layoutFeatures == null ? Number(super.x) : Number(this.layoutFeatures.layoutX);
      }
      
      override public function set x(value:Number) : void
      {
         if(this.x == value)
         {
            return;
         }
         if(this.layoutFeatures == null)
         {
            super.x = value;
         }
         else
         {
            this.layoutFeatures.layoutX = value;
            this.validateTransformMatrix();
         }
      }
      
      override public function get y() : Number
      {
         return this.layoutFeatures == null ? Number(super.y) : Number(this.layoutFeatures.layoutY);
      }
      
      override public function set y(value:Number) : void
      {
         if(this.y == value)
         {
            return;
         }
         if(this.layoutFeatures == null)
         {
            super.y = value;
         }
         else
         {
            this.layoutFeatures.layoutY = value;
            this.validateTransformMatrix();
         }
      }
      
      override public function get z() : Number
      {
         return this.layoutFeatures == null ? Number(super.z) : Number(this.layoutFeatures.layoutZ);
      }
      
      override public function set z(value:Number) : void
      {
         if(this.z == value)
         {
            return;
         }
         if(this.layoutFeatures == null)
         {
            super.z = value;
         }
         else
         {
            this.layoutFeatures.layoutZ = value;
            this.validateTransformMatrix();
         }
      }
      
      override public function get width() : Number
      {
         var p:Point = null;
         if(this.layoutFeatures == null)
         {
            return super.width;
         }
         if(MatrixUtilClass != null)
         {
            p = MatrixUtilClass["transformSize"](this.layoutFeatures.layoutWidth,this._height,transform.matrix);
         }
         return !!p ? Number(p.x) : Number(super.width);
      }
      
      override public function set width(value:Number) : void
      {
         if(this.width == value)
         {
            return;
         }
         if(this.layoutFeatures == null)
         {
            super.width = value;
         }
         else
         {
            this.layoutFeatures.layoutWidth = value;
            this.layoutFeatures.layoutScaleX = this.measuredWidth != 0 ? Number(value / this.measuredWidth) : Number(0);
            this.validateTransformMatrix();
         }
      }
      
      override public function get height() : Number
      {
         var p:Point = null;
         if(this.layoutFeatures == null)
         {
            return super.height;
         }
         if(MatrixUtilClass != null)
         {
            p = MatrixUtilClass["transformSize"](this.layoutFeatures.layoutWidth,this._height,transform.matrix);
         }
         return !!p ? Number(p.y) : Number(super.height);
      }
      
      override public function set height(value:Number) : void
      {
         if(this.height == value)
         {
            return;
         }
         if(this.layoutFeatures == null)
         {
            super.height = value;
         }
         else
         {
            this._height = value;
            this.layoutFeatures.layoutScaleY = this.measuredHeight != 0 ? Number(value / this.measuredHeight) : Number(0);
            this.validateTransformMatrix();
         }
      }
      
      override public function get rotationX() : Number
      {
         return this.layoutFeatures == null ? Number(super.rotationX) : Number(this.layoutFeatures.layoutRotationX);
      }
      
      override public function set rotationX(value:Number) : void
      {
         if(this.rotationX == value)
         {
            return;
         }
         if(this.layoutFeatures == null)
         {
            super.rotationX = value;
         }
         else
         {
            this.layoutFeatures.layoutRotationX = value;
            this.validateTransformMatrix();
         }
      }
      
      override public function get rotationY() : Number
      {
         return this.layoutFeatures == null ? Number(super.rotationY) : Number(this.layoutFeatures.layoutRotationY);
      }
      
      override public function set rotationY(value:Number) : void
      {
         if(this.rotationY == value)
         {
            return;
         }
         if(this.layoutFeatures == null)
         {
            super.rotationY = value;
         }
         else
         {
            this.layoutFeatures.layoutRotationY = value;
            this.validateTransformMatrix();
         }
      }
      
      override public function get rotationZ() : Number
      {
         return this.layoutFeatures == null ? Number(super.rotationZ) : Number(this.layoutFeatures.layoutRotationZ);
      }
      
      override public function set rotationZ(value:Number) : void
      {
         if(this.rotationZ == value)
         {
            return;
         }
         if(this.layoutFeatures == null)
         {
            super.rotationZ = value;
         }
         else
         {
            this.layoutFeatures.layoutRotationZ = value;
            this.validateTransformMatrix();
         }
      }
      
      override public function get rotation() : Number
      {
         return this.layoutFeatures == null ? Number(super.rotation) : Number(this.layoutFeatures.layoutRotationZ);
      }
      
      override public function set rotation(value:Number) : void
      {
         if(this.rotation == value)
         {
            return;
         }
         if(this.layoutFeatures == null)
         {
            super.rotation = value;
         }
         else
         {
            this.layoutFeatures.layoutRotationZ = value;
            this.validateTransformMatrix();
         }
      }
      
      override public function get scaleX() : Number
      {
         return this.layoutFeatures == null ? Number(super.scaleX) : Number(this.layoutFeatures.layoutScaleX);
      }
      
      override public function set scaleX(value:Number) : void
      {
         if(this.scaleX == value)
         {
            return;
         }
         if(this.layoutFeatures == null)
         {
            super.scaleX = value;
         }
         else
         {
            this.layoutFeatures.layoutScaleX = value;
            this.layoutFeatures.layoutWidth = Math.abs(value) * this.measuredWidth;
            this.validateTransformMatrix();
         }
      }
      
      override public function get scaleY() : Number
      {
         return this.layoutFeatures == null ? Number(super.scaleY) : Number(this.layoutFeatures.layoutScaleY);
      }
      
      override public function set scaleY(value:Number) : void
      {
         if(this.scaleY == value)
         {
            return;
         }
         if(this.layoutFeatures == null)
         {
            super.scaleY = value;
         }
         else
         {
            this.layoutFeatures.layoutScaleY = value;
            this._height = Math.abs(value) * this.measuredHeight;
            this.validateTransformMatrix();
         }
      }
      
      override public function get scaleZ() : Number
      {
         return this.layoutFeatures == null ? Number(super.scaleZ) : Number(this.layoutFeatures.layoutScaleZ);
      }
      
      override public function set scaleZ(value:Number) : void
      {
         if(this.scaleZ == value)
         {
            return;
         }
         if(this.layoutFeatures == null)
         {
            super.scaleZ = value;
         }
         else
         {
            this.layoutFeatures.layoutScaleZ = value;
            this.validateTransformMatrix();
         }
      }
      
      [Inspectable(category="General",enumeration="ltr,rtl")]
      public function get layoutDirection() : String
      {
         return this._layoutDirection;
      }
      
      public function set layoutDirection(value:String) : void
      {
         if(value == this._layoutDirection)
         {
            return;
         }
         this._layoutDirection = value;
         this.invalidateLayoutDirection();
      }
      
      public function get measuredHeight() : Number
      {
         return this._measuredHeight;
      }
      
      public function get measuredWidth() : Number
      {
         return this._measuredWidth;
      }
      
      public function get borderMetrics() : EdgeMetrics
      {
         if(scale9Grid == null)
         {
            return EdgeMetrics.EMPTY;
         }
         return new EdgeMetrics(scale9Grid.left,scale9Grid.top,Math.ceil(this.measuredWidth - scale9Grid.right),Math.ceil(this.measuredHeight - scale9Grid.bottom));
      }
      
      public function invalidateLayoutDirection() : void
      {
         var mirror:Boolean = false;
         var p:DisplayObjectContainer = parent;
         while(p)
         {
            if(p is ILayoutDirectionElement)
            {
               mirror = this._layoutDirection != null && ILayoutDirectionElement(p).layoutDirection != null && this._layoutDirection != ILayoutDirectionElement(p).layoutDirection;
               if(mirror && this.layoutFeatures == null)
               {
                  this.initAdvancedLayoutFeatures();
                  if(this.layoutFeatures != null)
                  {
                     this.layoutFeatures.mirror = mirror;
                     this.validateTransformMatrix();
                  }
               }
               else if(!mirror && this.layoutFeatures)
               {
                  this.layoutFeatures.mirror = mirror;
                  this.validateTransformMatrix();
                  this.layoutFeatures = null;
               }
               break;
            }
            p = p.parent;
         }
      }
      
      public function move(x:Number, y:Number) : void
      {
         this.x = x;
         this.y = y;
      }
      
      public function setActualSize(newWidth:Number, newHeight:Number) : void
      {
         this.width = newWidth;
         this.height = newHeight;
      }
      
      private function addedHandler(event:Event) : void
      {
         this.invalidateLayoutDirection();
      }
      
      private function initAdvancedLayoutFeatures() : void
      {
         var appDomain:ApplicationDomain = null;
         var features:IAssetLayoutFeatures = null;
         if(this.layoutFeaturesClass == null)
         {
            appDomain = ApplicationDomain.currentDomain;
            if(appDomain.hasDefinition("mx.core::AdvancedLayoutFeatures"))
            {
               this.layoutFeaturesClass = Class(appDomain.getDefinition("mx.core::AdvancedLayoutFeatures"));
            }
            if(MatrixUtilClass == null)
            {
               if(appDomain.hasDefinition("mx.utils::MatrixUtil"))
               {
                  MatrixUtilClass = Class(appDomain.getDefinition("mx.utils::MatrixUtil"));
               }
            }
         }
         if(this.layoutFeaturesClass != null)
         {
            features = new this.layoutFeaturesClass();
            features.layoutScaleX = this.scaleX;
            features.layoutScaleY = this.scaleY;
            features.layoutScaleZ = this.scaleZ;
            features.layoutRotationX = this.rotationX;
            features.layoutRotationY = this.rotationY;
            features.layoutRotationZ = this.rotation;
            features.layoutX = this.x;
            features.layoutY = this.y;
            features.layoutZ = this.z;
            features.layoutWidth = this.width;
            this._height = this.height;
            this.layoutFeatures = features;
         }
      }
      
      private function validateTransformMatrix() : void
      {
         if(this.layoutFeatures != null)
         {
            if(this.layoutFeatures.is3D)
            {
               super.transform.matrix3D = this.layoutFeatures.computedMatrix3D;
            }
            else
            {
               super.transform.matrix = this.layoutFeatures.computedMatrix;
            }
         }
      }
   }
}
