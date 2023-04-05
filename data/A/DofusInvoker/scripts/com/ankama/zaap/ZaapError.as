package com.ankama.zaap
{
   import flash.utils.Dictionary;
   import org.apache.thrift.TBase;
   import org.apache.thrift.TFieldRequirementType;
   import org.apache.thrift.meta_data.FieldMetaData;
   import org.apache.thrift.meta_data.FieldValueMetaData;
   import org.apache.thrift.protocol.TField;
   import org.apache.thrift.protocol.TProtocol;
   import org.apache.thrift.protocol.TProtocolError;
   import org.apache.thrift.protocol.TProtocolUtil;
   import org.apache.thrift.protocol.TStruct;
   import org.apache.thrift.protocol.TType;
   
   public class ZaapError extends Error implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("ZaapError");
      
      private static const CODE_FIELD_DESC:TField = new TField("code",TType.I32,1);
      
      private static const DETAILS_FIELD_DESC:TField = new TField("details",TType.STRING,2);
      
      public static const CODE:int = 1;
      
      public static const DETAILS:int = 2;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      {
         metaDataMap[CODE] = new FieldMetaData("code",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.I32));
         metaDataMap[DETAILS] = new FieldMetaData("details",TFieldRequirementType.OPTIONAL,new FieldValueMetaData(TType.STRING));
         FieldMetaData.addStructMetaDataMap(ZaapError,metaDataMap);
      }
      
      private var _code:int;
      
      private var _details:String;
      
      private var __isset_code:Boolean = false;
      
      public function ZaapError()
      {
         super();
      }
      
      public function get code() : int
      {
         return this._code;
      }
      
      public function set code(param1:int) : void
      {
         this._code = param1;
         this.__isset_code = true;
      }
      
      public function unsetCode() : void
      {
         this.__isset_code = false;
      }
      
      public function isSetCode() : Boolean
      {
         return this.__isset_code;
      }
      
      public function get details() : String
      {
         return this._details;
      }
      
      public function set details(param1:String) : void
      {
         this._details = param1;
      }
      
      public function unsetDetails() : void
      {
         this.details = null;
      }
      
      public function isSetDetails() : Boolean
      {
         return this.details != null;
      }
      
      public function setFieldValue(param1:int, param2:*) : void
      {
         switch(param1)
         {
            case CODE:
               if(param2 == null)
               {
                  this.unsetCode();
               }
               else
               {
                  this.code = param2;
               }
               break;
            case DETAILS:
               if(param2 == null)
               {
                  this.unsetDetails();
               }
               else
               {
                  this.details = param2;
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
            case CODE:
               return this.code;
            case DETAILS:
               return this.details;
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function isSet(param1:int) : Boolean
      {
         switch(param1)
         {
            case CODE:
               return this.isSetCode();
            case DETAILS:
               return this.isSetDetails();
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
               case CODE:
                  if(_loc2_.type == TType.I32)
                  {
                     this.code = param1.readI32();
                     this.__isset_code = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case DETAILS:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.details = param1.readString();
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
         if(!this.__isset_code)
         {
            throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'code\' was not found in serialized data! Struct: " + this.toString());
         }
         this.validate();
      }
      
      public function write(param1:TProtocol) : void
      {
         this.validate();
         param1.writeStructBegin(STRUCT_DESC);
         param1.writeFieldBegin(CODE_FIELD_DESC);
         param1.writeI32(this.code);
         param1.writeFieldEnd();
         if(this.isSetDetails())
         {
            if(this.details != null)
            {
               param1.writeFieldBegin(DETAILS_FIELD_DESC);
               param1.writeString(this.details);
               param1.writeFieldEnd();
            }
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:* = new String("ZaapError(");
         var _loc2_:Boolean = true;
         _loc1_ += "code:";
         var _loc3_:String = ErrorCode.VALUES_TO_NAMES[this.code];
         if(_loc3_ != null)
         {
            _loc1_ += _loc3_;
            _loc1_ += " (";
         }
         _loc1_ += this.code;
         if(_loc3_ != null)
         {
            _loc1_ += ")";
         }
         _loc2_ = false;
         if(this.isSetDetails())
         {
            if(!_loc2_)
            {
               _loc1_ += ", ";
            }
            _loc1_ += "details:";
            if(this.details == null)
            {
               _loc1_ += "null";
            }
            else
            {
               _loc1_ += this.details;
            }
            _loc2_ = false;
         }
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
         if(this.isSetCode() && !ErrorCode.VALID_VALUES.contains(this.code))
         {
            throw new TProtocolError(TProtocolError.UNKNOWN,"The field \'code\' has been assigned the invalid value " + this.code);
         }
      }
   }
}
