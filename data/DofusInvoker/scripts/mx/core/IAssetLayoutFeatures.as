package mx.core
{
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   
   public interface IAssetLayoutFeatures
   {
       
      
      function set layoutX(param1:Number) : void;
      
      function get layoutX() : Number;
      
      function set layoutY(param1:Number) : void;
      
      function get layoutY() : Number;
      
      function set layoutZ(param1:Number) : void;
      
      function get layoutZ() : Number;
      
      function get layoutWidth() : Number;
      
      function set layoutWidth(param1:Number) : void;
      
      function set transformX(param1:Number) : void;
      
      function get transformX() : Number;
      
      function set transformY(param1:Number) : void;
      
      function get transformY() : Number;
      
      function set transformZ(param1:Number) : void;
      
      function get transformZ() : Number;
      
      function set layoutRotationX(param1:Number) : void;
      
      function get layoutRotationX() : Number;
      
      function set layoutRotationY(param1:Number) : void;
      
      function get layoutRotationY() : Number;
      
      function set layoutRotationZ(param1:Number) : void;
      
      function get layoutRotationZ() : Number;
      
      function set layoutScaleX(param1:Number) : void;
      
      function get layoutScaleX() : Number;
      
      function set layoutScaleY(param1:Number) : void;
      
      function get layoutScaleY() : Number;
      
      function set layoutScaleZ(param1:Number) : void;
      
      function get layoutScaleZ() : Number;
      
      function set layoutMatrix(param1:Matrix) : void;
      
      function get layoutMatrix() : Matrix;
      
      function set layoutMatrix3D(param1:Matrix3D) : void;
      
      function get layoutMatrix3D() : Matrix3D;
      
      function get is3D() : Boolean;
      
      function get layoutIs3D() : Boolean;
      
      function get mirror() : Boolean;
      
      function set mirror(param1:Boolean) : void;
      
      function get stretchX() : Number;
      
      function set stretchX(param1:Number) : void;
      
      function get stretchY() : Number;
      
      function set stretchY(param1:Number) : void;
      
      function get computedMatrix() : Matrix;
      
      function get computedMatrix3D() : Matrix3D;
   }
}
