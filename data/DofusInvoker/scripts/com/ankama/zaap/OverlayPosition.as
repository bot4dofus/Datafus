package com.ankama.zaap
{
   import flash.utils.Dictionary;
   import org.apache.thrift.TBase;
   import org.apache.thrift.TFieldRequirementType;
   import org.apache.thrift.meta_data.FieldMetaData;
   import org.apache.thrift.meta_data.FieldValueMetaData;
   import org.apache.thrift.protocol.TField;
   import org.apache.thrift.protocol.TProtocol;
   import org.apache.thrift.protocol.TProtocolUtil;
   import org.apache.thrift.protocol.TStruct;
   import org.apache.thrift.protocol.TType;
   
   public class OverlayPosition implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("OverlayPosition");
      
      private static const POS_X_FIELD_DESC:TField = new TField("posX",TType.I32,1);
      
      private static const POS_Y_FIELD_DESC:TField = new TField("posY",TType.I32,2);
      
      private static const WIDTH_FIELD_DESC:TField = new TField("width",TType.I32,3);
      
      private static const HEIGHT_FIELD_DESC:TField = new TField("height",TType.I32,4);
      
      public static const POSX:int = 1;
      
      public static const POSY:int = 2;
      
      public static const WIDTH:int = 3;
      
      public static const HEIGHT:int = 4;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      {
         metaDataMap[POSX] = new FieldMetaData("posX",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
         metaDataMap[POSY] = new FieldMetaData("posY",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
         metaDataMap[WIDTH] = new FieldMetaData("width",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
         metaDataMap[HEIGHT] = new FieldMetaData("height",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
         FieldMetaData.addStructMetaDataMap(OverlayPosition,metaDataMap);
      }
      
      private var _posX:int;
      
      private var _posY:int;
      
      private var _width:int;
      
      private var _height:int;
      
      private var __isset_posX:Boolean = false;
      
      private var __isset_posY:Boolean = false;
      
      private var __isset_width:Boolean = false;
      
      private var __isset_height:Boolean = false;
      
      public function OverlayPosition()
      {
         super();
         this._posX = 25;
         this._posY = 25;
         this._width = 50;
         this._height = 50;
      }
      
      public function get posX() : int
      {
         return this._posX;
      }
      
      public function set posX(param1:int) : void
      {
         this._posX = param1;
         this.__isset_posX = true;
      }
      
      public function unsetPosX() : void
      {
         this.__isset_posX = false;
      }
      
      public function isSetPosX() : Boolean
      {
         return this.__isset_posX;
      }
      
      public function get posY() : int
      {
         return this._posY;
      }
      
      public function set posY(param1:int) : void
      {
         this._posY = param1;
         this.__isset_posY = true;
      }
      
      public function unsetPosY() : void
      {
         this.__isset_posY = false;
      }
      
      public function isSetPosY() : Boolean
      {
         return this.__isset_posY;
      }
      
      public function get width() : int
      {
         return this._width;
      }
      
      public function set width(param1:int) : void
      {
         this._width = param1;
         this.__isset_width = true;
      }
      
      public function unsetWidth() : void
      {
         this.__isset_width = false;
      }
      
      public function isSetWidth() : Boolean
      {
         return this.__isset_width;
      }
      
      public function get height() : int
      {
         return this._height;
      }
      
      public function set height(param1:int) : void
      {
         this._height = param1;
         this.__isset_height = true;
      }
      
      public function unsetHeight() : void
      {
         this.__isset_height = false;
      }
      
      public function isSetHeight() : Boolean
      {
         return this.__isset_height;
      }
      
      public function setFieldValue(param1:int, param2:*) : void
      {
         switch(param1)
         {
            case POSX:
               if(param2 == null)
               {
                  this.unsetPosX();
               }
               else
               {
                  this.posX = param2;
               }
               break;
            case POSY:
               if(param2 == null)
               {
                  this.unsetPosY();
               }
               else
               {
                  this.posY = param2;
               }
               break;
            case WIDTH:
               if(param2 == null)
               {
                  this.unsetWidth();
               }
               else
               {
                  this.width = param2;
               }
               break;
            case HEIGHT:
               if(param2 == null)
               {
                  this.unsetHeight();
               }
               else
               {
                  this.height = param2;
               }
               break;
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function getFieldValue(param1:int) : *
      {
         switch(param1)
         {
            case POSX:
               return this.posX;
            case POSY:
               return this.posY;
            case WIDTH:
               return this.width;
            case HEIGHT:
               return this.height;
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function isSet(param1:int) : Boolean
      {
         switch(param1)
         {
            case POSX:
               return this.isSetPosX();
            case POSY:
               return this.isSetPosY();
            case WIDTH:
               return this.isSetWidth();
            case HEIGHT:
               return this.isSetHeight();
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function read(param1:TProtocol) : void
      {
         var _loc2_:TField = null;
         param1.readStructBegin();
         while(true)
         {
            _loc2_ = param1.readFieldBegin();
            if(_loc2_.type == TType.STOP)
            {
               break;
            }
            switch(_loc2_.id)
            {
               case POSX:
                  if(_loc2_.type == TType.I32)
                  {
                     this.posX = param1.readI32();
                     this.__isset_posX = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case POSY:
                  if(_loc2_.type == TType.I32)
                  {
                     this.posY = param1.readI32();
                     this.__isset_posY = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case WIDTH:
                  if(_loc2_.type == TType.I32)
                  {
                     this.width = param1.readI32();
                     this.__isset_width = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case HEIGHT:
                  if(_loc2_.type == TType.I32)
                  {
                     this.height = param1.readI32();
                     this.__isset_height = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               default:
                  TProtocolUtil.skip(param1,_loc2_.type);
                  break;
            }
            param1.readFieldEnd();
         }
         param1.readStructEnd();
         this.validate();
      }
      
      public function write(param1:TProtocol) : void
      {
         this.validate();
         param1.writeStructBegin(STRUCT_DESC);
         param1.writeFieldBegin(POS_X_FIELD_DESC);
         param1.writeI32(this.posX);
         param1.writeFieldEnd();
         param1.writeFieldBegin(POS_Y_FIELD_DESC);
         param1.writeI32(this.posY);
         param1.writeFieldEnd();
         param1.writeFieldBegin(WIDTH_FIELD_DESC);
         param1.writeI32(this.width);
         param1.writeFieldEnd();
         param1.writeFieldBegin(HEIGHT_FIELD_DESC);
         param1.writeI32(this.height);
         param1.writeFieldEnd();
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:* = new String("OverlayPosition(");
         var _loc2_:Boolean = true;
         _loc1_ += "posX:";
         _loc1_ += this.posX;
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "posY:";
         _loc1_ += this.posY;
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "width:";
         _loc1_ += this.width;
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "height:";
         _loc1_ += this.height;
         _loc2_ = false;
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
      }
   }
}
