package by.blooddy.crypto.serialization
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import flash.errors.StackOverflowError;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Endian;
   import flash.xml.XMLDocument;
   
   public class JSON
   {
       
      
      public function JSON()
      {
      }
      
      public static function encode(param1:*) : String
      {
         var _loc2_:Object = XML.settings();
         XML.setSettings({
            "ignoreComments":true,
            "ignoreProcessingInstructions":false,
            "ignoreWhitespace":true,
            "prettyIndent":false,
            "prettyPrinting":false
         });
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUTFBytes("0123456789abcdef");
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.endian = Endian.LITTLE_ENDIAN;
         var cvint:Class = (new Vector.<int>() as Object).constructor;
         var cvuint:Class = (new Vector.<uint>() as Object).constructor;
         var cvdouble:Class = (new Vector.<Number>() as Object).constructor;
         var cvobject:Class = (new Vector.<Object>() as Object).constructor;
         var writeValue:Function = null;
         writeValue = function(param1:Dictionary, param2:ByteArray, param3:ByteArray, param4:*):*
         {
            var _loc7_:int = 0;
            var _loc8_:int = 0;
            var _loc9_:Number = NaN;
            var _loc10_:* = null as String;
            var _loc11_:Boolean = false;
            var _loc12_:* = null as Array;
            var _loc13_:* = null;
            var _loc14_:* = null as Array;
            var _loc15_:int = 0;
            var _loc16_:* = null;
            var _loc17_:Boolean = false;
            var _loc18_:uint = 0;
            var _loc19_:uint = 0;
            var _loc20_:uint = 0;
            var _loc21_:uint = 0;
            var _loc22_:uint = 0;
            var _loc6_:String = typeof param4;
            if(_loc6_ == "number")
            {
               if(isFinite(param4))
               {
                  if(param4 >= 0 && (param4 <= 9 && param4 % 1 == 0))
                  {
                     param2.writeByte(int(uint(48) + param4));
                  }
                  else
                  {
                     param2.writeUTFBytes(param4.toString());
                  }
               }
               else
               {
                  param2.writeInt(1819047278);
               }
            }
            else if(_loc6_ == "boolean")
            {
               if(param4)
               {
                  param2.writeInt(1702195828);
               }
               else
               {
                  param2.writeInt(1936482662);
                  param2.writeByte(101);
               }
            }
            else
            {
               if(_loc6_ == "xml")
               {
                  param4 = param4.toXMLString();
                  _loc6_ = "string";
               }
               else if(!!param4 && _loc6_ == "object")
               {
                  if(param4 is XMLDocument)
                  {
                     if(param4.childNodes.length > 0)
                     {
                        param4 = new XML(param4).toXMLString();
                        _loc6_ = "string";
                     }
                     else
                     {
                        param2.writeShort(8738);
                     }
                  }
                  else
                  {
                     if(param4 in param1)
                     {
                        Error.throwError(StackOverflowError,2024);
                     }
                     param1[param4] = true;
                     _loc7_ = 0;
                     if(param4 is Array || param4 is cvobject)
                     {
                        param2.writeByte(uint(91));
                        _loc8_ = param4.length - 1;
                        while(_loc8_ >= 0 && param4[_loc8_] == null)
                        {
                           _loc8_--;
                        }
                        _loc8_++;
                        if(_loc8_ > 0)
                        {
                           writeValue(param1,param2,param3,param4[0]);
                           while(true)
                           {
                              _loc7_++;
                              if(_loc7_ >= _loc8_)
                              {
                                 break;
                              }
                              param2.writeByte(uint(44));
                              writeValue(param1,param2,param3,param4[_loc7_]);
                           }
                        }
                        param2.writeByte(uint(93));
                     }
                     else if(param4 is cvint || param4 is cvuint)
                     {
                        param2.writeByte(uint(91));
                        _loc8_ = param4.length;
                        if(_loc8_ > 0)
                        {
                           _loc9_ = Number(param4[0]);
                           if(_loc9_ >= 0 && (_loc9_ <= 9 && _loc9_ % 1 == 0))
                           {
                              param2.writeByte(uint(48) + _loc9_);
                           }
                           else
                           {
                              param2.writeUTFBytes(_loc9_.toString());
                           }
                           while(true)
                           {
                              _loc7_++;
                              if(_loc7_ >= _loc8_)
                              {
                                 break;
                              }
                              param2.writeByte(uint(44));
                              _loc9_ = Number(param4[_loc7_]);
                              if(_loc9_ >= 0 && (_loc9_ <= 9 && _loc9_ % 1 == 0))
                              {
                                 param2.writeByte(uint(48) + _loc9_);
                              }
                              else
                              {
                                 param2.writeUTFBytes(_loc9_.toString());
                              }
                           }
                        }
                        param2.writeByte(uint(93));
                     }
                     else if(param4 is cvdouble)
                     {
                        param2.writeByte(uint(91));
                        _loc8_ = param4.length - 1;
                        while(_loc8_ >= 0 && !isFinite(param4[_loc8_]))
                        {
                           _loc8_--;
                        }
                        _loc8_++;
                        if(_loc8_ > 0)
                        {
                           _loc9_ = Number(param4[0]);
                           if(isFinite(_loc9_))
                           {
                              if(_loc9_ >= 0 && (_loc9_ <= 9 && _loc9_ % 1 == 0))
                              {
                                 param2.writeByte(int(uint(48) + _loc9_));
                              }
                              else
                              {
                                 param2.writeUTFBytes(_loc9_.toString());
                              }
                           }
                           else
                           {
                              param2.writeInt(1819047278);
                           }
                           while(true)
                           {
                              _loc7_++;
                              if(_loc7_ >= _loc8_)
                              {
                                 break;
                              }
                              param2.writeByte(uint(44));
                              _loc9_ = Number(param4[_loc7_]);
                              if(isFinite(_loc9_))
                              {
                                 if(_loc9_ >= 0 && (_loc9_ <= 9 && _loc9_ % 1 == 0))
                                 {
                                    param2.writeByte(int(uint(48) + _loc9_));
                                 }
                                 else
                                 {
                                    param2.writeUTFBytes(_loc9_.toString());
                                 }
                              }
                              else
                              {
                                 param2.writeInt(1819047278);
                              }
                           }
                        }
                        param2.writeByte(uint(93));
                     }
                     else
                     {
                        param2.writeByte(uint(123));
                        _loc11_ = false;
                        _loc13_ = null;
                        if(param4.constructor != Object)
                        {
                           if(param4 is Dictionary)
                           {
                              _loc15_ = 0;
                              _loc14_ = [];
                              _loc16_ = param4;
                              while(§§hasnext(_loc16_,_loc15_))
                              {
                                 _loc14_.push(§§nextname(_loc15_,_loc16_));
                              }
                              _loc12_ = _loc14_;
                              _loc8_ = _loc12_.length;
                              _loc7_ = 0;
                              while(_loc7_ < _loc8_)
                              {
                                 _loc13_ = typeof _loc12_[_loc7_];
                                 if(_loc13_ != "string" && _loc13_ != "number")
                                 {
                                    Error.throwError(TypeError,0);
                                 }
                                 _loc7_++;
                              }
                           }
                           _loc12_ = SerializationHelper.getPropertyNames(param4);
                           _loc8_ = _loc12_.length;
                           _loc7_ = 0;
                           while(_loc7_ < _loc8_)
                           {
                              _loc10_ = _loc12_[_loc7_];
                              try
                              {
                                 _loc13_ = param4[_loc10_];
                                 _loc17_ = true;
                              }
                              catch(_loc_e_:*)
                              {
                              }
                              if(_loc17_)
                              {
                                 if(_loc11_)
                                 {
                                    param2.writeByte(uint(44));
                                 }
                                 else
                                 {
                                    _loc11_ = true;
                                 }
                                 if(_loc10_.length <= 0)
                                 {
                                    param2.writeShort(8738);
                                 }
                                 else
                                 {
                                    param2.writeByte(uint(34));
                                    param3.position = 16;
                                    param3.writeUTFBytes(_loc10_);
                                    _loc18_ = param3.position;
                                    _loc19_ = 16;
                                    _loc20_ = _loc19_;
                                    do
                                    {
                                       _loc22_ = int(param3[_loc19_]);
                                       if(_loc22_ < uint(32) || (_loc22_ == uint(34) || (_loc22_ == uint(47) || _loc22_ == uint(92))))
                                       {
                                          _loc21_ = _loc19_ - _loc20_;
                                          if(_loc21_ > 0)
                                          {
                                             param2.writeBytes(param3,_loc20_,_loc21_);
                                          }
                                          _loc20_ = _loc19_ + 1;
                                          if(_loc22_ == uint(10))
                                          {
                                             param2.writeShort(28252);
                                          }
                                          else if(_loc22_ == uint(13))
                                          {
                                             param2.writeShort(29276);
                                          }
                                          else if(_loc22_ == uint(9))
                                          {
                                             param2.writeShort(29788);
                                          }
                                          else if(_loc22_ == uint(34))
                                          {
                                             param2.writeShort(8796);
                                          }
                                          else if(_loc22_ == uint(47))
                                          {
                                             param2.writeShort(12124);
                                          }
                                          else if(_loc22_ == uint(92))
                                          {
                                             param2.writeShort(23644);
                                          }
                                          else if(_loc22_ == uint(11))
                                          {
                                             param2.writeShort(30300);
                                          }
                                          else if(_loc22_ == uint(8))
                                          {
                                             param2.writeShort(25180);
                                          }
                                          else if(_loc22_ == uint(12))
                                          {
                                             param2.writeShort(26204);
                                          }
                                          else
                                          {
                                             param2.writeInt(808482140);
                                             param2.writeByte(int(param3[_loc22_ >>> 4]));
                                             param2.writeByte(int(param3[_loc22_ & 15]));
                                          }
                                       }
                                    }
                                    while(++_loc19_ < _loc18_);
                                    
                                    _loc21_ = _loc19_ - _loc20_;
                                    if(_loc21_ > 0)
                                    {
                                       param2.writeBytes(param3,_loc20_,_loc21_);
                                    }
                                    param2.writeByte(uint(34));
                                 }
                                 param2.writeByte(uint(58));
                                 writeValue(param1,param2,param3,_loc13_);
                              }
                              _loc7_++;
                           }
                        }
                        _loc15_ = 0;
                        _loc14_ = [];
                        _loc16_ = param4;
                        while(§§hasnext(_loc16_,_loc15_))
                        {
                           _loc14_.push(§§nextname(_loc15_,_loc16_));
                        }
                        _loc12_ = _loc14_;
                        _loc8_ = _loc12_.length;
                        _loc7_ = 0;
                        while(_loc7_ < _loc8_)
                        {
                           _loc10_ = _loc12_[_loc7_];
                           _loc13_ = param4[_loc10_];
                           if(!(_loc13_ is Function))
                           {
                              if(_loc11_)
                              {
                                 param2.writeByte(uint(44));
                              }
                              else
                              {
                                 _loc11_ = true;
                              }
                              if(_loc10_.length <= 0)
                              {
                                 param2.writeShort(8738);
                              }
                              else
                              {
                                 param2.writeByte(uint(34));
                                 param3.position = 16;
                                 param3.writeUTFBytes(_loc10_);
                                 _loc18_ = param3.position;
                                 _loc19_ = 16;
                                 _loc20_ = _loc19_;
                                 do
                                 {
                                    _loc22_ = int(param3[_loc19_]);
                                    if(_loc22_ < uint(32) || (_loc22_ == uint(34) || (_loc22_ == uint(47) || _loc22_ == uint(92))))
                                    {
                                       _loc21_ = _loc19_ - _loc20_;
                                       if(_loc21_ > 0)
                                       {
                                          param2.writeBytes(param3,_loc20_,_loc21_);
                                       }
                                       _loc20_ = _loc19_ + 1;
                                       if(_loc22_ == uint(10))
                                       {
                                          param2.writeShort(28252);
                                       }
                                       else if(_loc22_ == uint(13))
                                       {
                                          param2.writeShort(29276);
                                       }
                                       else if(_loc22_ == uint(9))
                                       {
                                          param2.writeShort(29788);
                                       }
                                       else if(_loc22_ == uint(34))
                                       {
                                          param2.writeShort(8796);
                                       }
                                       else if(_loc22_ == uint(47))
                                       {
                                          param2.writeShort(12124);
                                       }
                                       else if(_loc22_ == uint(92))
                                       {
                                          param2.writeShort(23644);
                                       }
                                       else if(_loc22_ == uint(11))
                                       {
                                          param2.writeShort(30300);
                                       }
                                       else if(_loc22_ == uint(8))
                                       {
                                          param2.writeShort(25180);
                                       }
                                       else if(_loc22_ == uint(12))
                                       {
                                          param2.writeShort(26204);
                                       }
                                       else
                                       {
                                          param2.writeInt(808482140);
                                          param2.writeByte(int(param3[_loc22_ >>> 4]));
                                          param2.writeByte(int(param3[_loc22_ & 15]));
                                       }
                                    }
                                 }
                                 while(++_loc19_ < _loc18_);
                                 
                                 _loc21_ = _loc19_ - _loc20_;
                                 if(_loc21_ > 0)
                                 {
                                    param2.writeBytes(param3,_loc20_,_loc21_);
                                 }
                                 param2.writeByte(uint(34));
                              }
                              param2.writeByte(uint(58));
                              writeValue(param1,param2,param3,_loc13_);
                           }
                           _loc7_++;
                        }
                        param2.writeByte(uint(125));
                     }
                     delete param1[param4];
                  }
               }
               if(_loc6_ == "string")
               {
                  if(int(param4.length) <= 0)
                  {
                     param2.writeShort(8738);
                  }
                  else
                  {
                     param2.writeByte(uint(34));
                     param3.position = 16;
                     param3.writeUTFBytes(param4);
                     _loc18_ = param3.position;
                     _loc19_ = 16;
                     _loc20_ = _loc19_;
                     do
                     {
                        _loc22_ = int(param3[_loc19_]);
                        if(_loc22_ < uint(32) || (_loc22_ == uint(34) || (_loc22_ == uint(47) || _loc22_ == uint(92))))
                        {
                           _loc21_ = _loc19_ - _loc20_;
                           if(_loc21_ > 0)
                           {
                              param2.writeBytes(param3,_loc20_,_loc21_);
                           }
                           _loc20_ = _loc19_ + 1;
                           if(_loc22_ == uint(10))
                           {
                              param2.writeShort(28252);
                           }
                           else if(_loc22_ == uint(13))
                           {
                              param2.writeShort(29276);
                           }
                           else if(_loc22_ == uint(9))
                           {
                              param2.writeShort(29788);
                           }
                           else if(_loc22_ == uint(34))
                           {
                              param2.writeShort(8796);
                           }
                           else if(_loc22_ == uint(47))
                           {
                              param2.writeShort(12124);
                           }
                           else if(_loc22_ == uint(92))
                           {
                              param2.writeShort(23644);
                           }
                           else if(_loc22_ == uint(11))
                           {
                              param2.writeShort(30300);
                           }
                           else if(_loc22_ == uint(8))
                           {
                              param2.writeShort(25180);
                           }
                           else if(_loc22_ == uint(12))
                           {
                              param2.writeShort(26204);
                           }
                           else
                           {
                              param2.writeInt(808482140);
                              param2.writeByte(int(param3[_loc22_ >>> 4]));
                              param2.writeByte(int(param3[_loc22_ & 15]));
                           }
                        }
                     }
                     while(++_loc19_ < _loc18_);
                     
                     _loc21_ = _loc19_ - _loc20_;
                     if(_loc21_ > 0)
                     {
                        param2.writeBytes(param3,_loc20_,_loc21_);
                     }
                     param2.writeByte(uint(34));
                  }
               }
               else if(!param4)
               {
                  param2.writeInt(1819047278);
               }
            }
         };
         writeValue(new Dictionary(),_loc4_,_loc3_,param1);
         XML.setSettings(_loc2_);
         var _loc5_:uint = _loc4_.position;
         _loc4_.position = 0;
         return _loc4_.readUTFBytes(_loc5_);
      }
      
      public static function decode(param1:String) : *
      {
         var _loc4_:* = null as ByteArray;
         var _loc5_:* = null as ByteArray;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:Boolean = false;
         var _loc13_:* = null;
         if(param1 == null)
         {
            Error.throwError(TypeError,2007,"value");
         }
         var _loc3_:* = undefined;
         if(param1.length > 0)
         {
            _loc4_ = ApplicationDomain.currentDomain.domainMemory;
            _loc5_ = new ByteArray();
            _loc5_.writeUTFBytes(param1);
            _loc5_.writeByte(0);
            if(_loc5_.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
            {
               _loc5_.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            }
            ApplicationDomain.currentDomain.domainMemory = _loc5_;
            _loc6_ = 0;
            while(true)
            {
               _loc6_ = (_loc9_ = _loc6_) + 1;
               _loc8_ = li8(_loc9_);
               if(_loc8_ != uint(13) && (_loc8_ != uint(10) && (_loc8_ != uint(32) && (_loc8_ != uint(9) && (_loc8_ != uint(11) && (_loc8_ != uint(8) && _loc8_ != uint(12)))))))
               {
                  if(_loc8_ == uint(47))
                  {
                     _loc6_ = (_loc9_ = _loc6_) + 1;
                     _loc8_ = li8(_loc9_);
                     if(_loc8_ != uint(47))
                     {
                        if(_loc8_ == uint(42))
                        {
                           _loc6_ -= 2;
                           _loc8_ = _loc6_;
                           _loc9_ = _loc6_;
                           _loc6_ = (_loc10_ = _loc6_) + 1;
                           if(li8(_loc10_) != uint(47) || li8(_loc10_) != uint(42))
                           {
                              _loc6_ = _loc9_;
                           }
                           else
                           {
                              while(true)
                              {
                                 _loc6_ = (_loc11_ = _loc6_) + 1;
                                 _loc10_ = li8(_loc11_);
                                 if(_loc10_ != uint(42))
                                 {
                                    if(_loc10_ == uint(0))
                                    {
                                       break;
                                    }
                                    continue;
                                 }
                                 _loc6_ = (_loc11_ = _loc6_) + 1;
                                 if(li8(_loc11_) != uint(47))
                                 {
                                    _loc6_--;
                                    continue;
                                 }
                              }
                              _loc6_ = _loc9_;
                           }
                           if(_loc8_ != _loc6_)
                           {
                              continue;
                           }
                        }
                        _loc6_--;
                     }
                     do
                     {
                        _loc6_ = (_loc10_ = _loc6_) + 1;
                        _loc9_ = li8(_loc10_);
                     }
                     while(_loc9_ != uint(10) && (_loc9_ != uint(13) && _loc9_ != uint(0)));
                     
                     _loc6_--;
                     continue;
                     _loc8_ = uint(47);
                     break;
                  }
                  break;
               }
            }
            _loc7_ = _loc8_;
            if(_loc7_ != uint(0))
            {
               var position:uint = _loc6_ - 1;
               var readValue:Function = null;
               readValue = function(param1:ByteArray, param2:uint):*
               {
                  var _loc3_:* = null as String;
                  var _loc7_:uint = 0;
                  var _loc8_:uint = 0;
                  var _loc9_:uint = 0;
                  var _loc10_:uint = 0;
                  var _loc11_:* = null as String;
                  var _loc12_:* = null as String;
                  var _loc13_:uint = 0;
                  var _loc14_:uint = 0;
                  var _loc15_:uint = 0;
                  var _loc16_:* = null as Object;
                  var _loc17_:* = null as String;
                  var _loc18_:* = null as Array;
                  var _loc6_:* = undefined;
                  while(true)
                  {
                     param2 = (_loc8_ = param2) + 1;
                     _loc7_ = li8(_loc8_);
                     if(_loc7_ != uint(13) && (_loc7_ != uint(10) && (_loc7_ != uint(32) && (_loc7_ != uint(9) && (_loc7_ != uint(11) && (_loc7_ != uint(8) && _loc7_ != uint(12)))))))
                     {
                        if(_loc7_ == uint(47))
                        {
                           param2 = (_loc8_ = param2) + 1;
                           _loc7_ = li8(_loc8_);
                           if(_loc7_ != uint(47))
                           {
                              if(_loc7_ == uint(42))
                              {
                                 param2 -= 2;
                                 _loc7_ = param2;
                                 _loc8_ = param2;
                                 param2 = (_loc9_ = param2) + 1;
                                 if(li8(_loc9_) != uint(47) || li8(_loc9_) != uint(42))
                                 {
                                    param2 = _loc8_;
                                 }
                                 else
                                 {
                                    while(true)
                                    {
                                       param2 = (_loc10_ = param2) + 1;
                                       _loc9_ = li8(_loc10_);
                                       if(_loc9_ != uint(42))
                                       {
                                          if(_loc9_ == uint(0))
                                          {
                                             break;
                                          }
                                          continue;
                                       }
                                       param2 = (_loc10_ = param2) + 1;
                                       if(li8(_loc10_) != uint(47))
                                       {
                                          param2--;
                                          continue;
                                       }
                                    }
                                    param2 = _loc8_;
                                 }
                                 if(_loc7_ != param2)
                                 {
                                    continue;
                                 }
                              }
                              param2--;
                           }
                           do
                           {
                              param2 = (_loc9_ = param2) + 1;
                              _loc8_ = li8(_loc9_);
                           }
                           while(_loc8_ != uint(10) && (_loc8_ != uint(13) && _loc8_ != uint(0)));
                           
                           param2--;
                           continue;
                           _loc7_ = uint(47);
                           break;
                        }
                        break;
                     }
                  }
                  var _loc5_:uint = _loc7_;
                  if(_loc5_ == uint(39) || _loc5_ == uint(34))
                  {
                     param2--;
                     _loc7_ = param2;
                     param2 = (_loc9_ = param2) + 1;
                     _loc8_ = li8(_loc9_);
                     if(_loc8_ != uint(39) && _loc8_ != uint(34))
                     {
                        param2--;
                        §§push(null);
                     }
                     else
                     {
                        _loc9_ = _loc7_ + 1;
                        _loc11_ = "";
                        while(true)
                        {
                           _loc13_ = li8(param2);
                           if(_loc13_ >= 128)
                           {
                              if((_loc13_ & 248) == 240)
                              {
                                 _loc13_ = (_loc13_ & 7) << 18 | (li8(++param2) & 63) << 12 | (li8(++param2) & 63) << 6 | li8(++param2) & 63;
                              }
                              else if((_loc13_ & 240) == 224)
                              {
                                 _loc13_ = (_loc13_ & 15) << 12 | (li8(++param2) & 63) << 6 | li8(++param2) & 63;
                              }
                              else if((_loc13_ & 224) == 192)
                              {
                                 _loc13_ = (_loc13_ & 31) << 6 | li8(++param2) & 63;
                              }
                           }
                           param2++;
                           if((_loc10_ = _loc13_) == _loc8_)
                           {
                              break;
                           }
                           if(_loc10_ == uint(92))
                           {
                              param1.position = _loc9_;
                              _loc11_ += param1.readUTFBytes(param2 - 1 - _loc9_);
                              param2 = (_loc13_ = param2) + 1;
                              _loc10_ = li8(_loc13_);
                              if(_loc10_ == uint(110))
                              {
                                 _loc11_ += "\n";
                              }
                              else if(_loc10_ == uint(114))
                              {
                                 _loc11_ += "\r";
                              }
                              else if(_loc10_ == uint(116))
                              {
                                 _loc11_ += "\t";
                              }
                              else if(_loc10_ == uint(118))
                              {
                                 _loc11_ += "\x0b";
                              }
                              else if(_loc10_ == uint(102))
                              {
                                 _loc11_ += "\f";
                              }
                              else if(_loc10_ == uint(98))
                              {
                                 _loc11_ += "\b";
                              }
                              else if(_loc10_ == uint(120))
                              {
                                 _loc14_ = 0;
                                 do
                                 {
                                    param2 = (_loc15_ = param2) + 1;
                                    _loc13_ = li8(_loc15_);
                                    if((_loc13_ < uint(48) || _loc13_ > uint(57)) && ((_loc13_ < uint(97) || _loc13_ > uint(102)) && (_loc13_ < uint(65) || _loc13_ > uint(70))))
                                    {
                                       break;
                                    }
                                 }
                                 while(++_loc14_ < 2);
                                 
                                 _loc12_ = _loc14_ != 2 ? (param2 -= _loc14_ + 1, null) : (param1.position = param2 - 2, param1.readUTFBytes(2));
                                 if(_loc12_ != null)
                                 {
                                    _loc11_ += String.fromCharCode(parseInt(_loc12_,16));
                                 }
                                 else
                                 {
                                    _loc11_ += "x";
                                 }
                              }
                              else if(_loc10_ == uint(117))
                              {
                                 _loc14_ = 0;
                                 do
                                 {
                                    param2 = (_loc15_ = param2) + 1;
                                    _loc13_ = li8(_loc15_);
                                    if((_loc13_ < uint(48) || _loc13_ > uint(57)) && ((_loc13_ < uint(97) || _loc13_ > uint(102)) && (_loc13_ < uint(65) || _loc13_ > uint(70))))
                                    {
                                       break;
                                    }
                                 }
                                 while(++_loc14_ < 4);
                                 
                                 _loc12_ = _loc14_ != 4 ? (param2 -= _loc14_ + 1, null) : (param1.position = param2 - 4, param1.readUTFBytes(4));
                                 if(_loc12_ != null)
                                 {
                                    _loc11_ += String.fromCharCode(parseInt(_loc12_,16));
                                 }
                                 else
                                 {
                                    _loc11_ += "u";
                                 }
                              }
                              else
                              {
                                 if(_loc10_ >= 128)
                                 {
                                    param2--;
                                    _loc13_ = li8(param2);
                                    if(_loc13_ >= 128)
                                    {
                                       if((_loc13_ & 248) == 240)
                                       {
                                          _loc13_ = (_loc13_ & 7) << 18 | (li8(++param2) & 63) << 12 | (li8(++param2) & 63) << 6 | li8(++param2) & 63;
                                       }
                                       else if((_loc13_ & 240) == 224)
                                       {
                                          _loc13_ = (_loc13_ & 15) << 12 | (li8(++param2) & 63) << 6 | li8(++param2) & 63;
                                       }
                                       else if((_loc13_ & 224) == 192)
                                       {
                                          _loc13_ = (_loc13_ & 31) << 6 | li8(++param2) & 63;
                                       }
                                    }
                                    param2++;
                                    _loc10_ = _loc13_;
                                 }
                                 _loc11_ += String.fromCharCode(_loc10_);
                              }
                              _loc9_ = param2;
                           }
                           else if(_loc10_ == uint(0) || (_loc10_ == uint(13) || _loc10_ == uint(10)))
                           {
                              param2 = _loc7_;
                              break;
                           }
                        }
                        if(param2 == _loc7_)
                        {
                           §§push(null);
                        }
                        else
                        {
                           if(_loc9_ != param2 - 1)
                           {
                              param1.position = _loc9_;
                              _loc11_ += param1.readUTFBytes(param2 - 1 - _loc9_);
                           }
                           §§push(_loc11_);
                        }
                     }
                     _loc3_ = §§pop();
                     if(_loc3_ != null)
                     {
                        _loc6_ = _loc3_;
                     }
                     else
                     {
                        Error.throwError(Error,0);
                     }
                  }
                  else if(_loc5_ >= uint(48) && _loc5_ <= uint(57) || _loc5_ == uint(46))
                  {
                     param2--;
                     _loc11_ = null;
                     _loc7_ = param2;
                     param2 = (_loc9_ = param2) + 1;
                     _loc8_ = li8(_loc9_);
                     if(_loc8_ == uint(48))
                     {
                        param2 = (_loc10_ = param2) + 1;
                        _loc8_ = li8(_loc10_);
                        if(_loc8_ == uint(120) || _loc8_ == uint(88))
                        {
                           _loc9_ = param2;
                           do
                           {
                              param2 = (_loc10_ = param2) + 1;
                              _loc8_ = li8(_loc10_);
                           }
                           while(_loc8_ >= uint(48) && _loc8_ <= uint(57) || (_loc8_ >= uint(97) && _loc8_ <= uint(102) || _loc8_ >= uint(65) && _loc8_ <= uint(70)));
                           
                           if(param2 == _loc9_ + 1)
                           {
                              param2 = _loc7_ + 1;
                              _loc8_ = uint(48);
                           }
                           else
                           {
                              param2--;
                              param1.position = _loc9_;
                              _loc11_ = parseInt(param1.readUTFBytes(param2 - _loc9_),16);
                           }
                        }
                        else
                        {
                           param2--;
                           _loc8_ = uint(48);
                        }
                     }
                     if(_loc11_ == null)
                     {
                        while(_loc8_ >= uint(48) && _loc8_ <= uint(57))
                        {
                           param2 = (_loc10_ = param2) + 1;
                           _loc8_ = li8(_loc10_);
                        }
                        if(_loc8_ == uint(46))
                        {
                           _loc9_ = param2;
                           do
                           {
                              param2 = (_loc10_ = param2) + 1;
                              _loc8_ = li8(_loc10_);
                           }
                           while(_loc8_ >= uint(48) && _loc8_ <= uint(57));
                           
                           if(param2 == _loc9_ + 1)
                           {
                              param2--;
                              _loc8_ = uint(46);
                           }
                        }
                        if(_loc8_ == uint(101) || _loc8_ == uint(69))
                        {
                           _loc10_ = param2;
                           param2 = (_loc13_ = param2) + 1;
                           _loc8_ = li8(_loc13_);
                           if(_loc8_ == uint(45) || _loc8_ == uint(43))
                           {
                              param2 = (_loc13_ = param2) + 1;
                              _loc8_ = li8(_loc13_);
                           }
                           _loc9_ = param2;
                           while(_loc8_ >= uint(48) && _loc8_ <= uint(57))
                           {
                              param2 = (_loc13_ = param2) + 1;
                              _loc8_ = li8(_loc13_);
                           }
                           if(param2 == _loc9_)
                           {
                              param2 = _loc10_;
                           }
                        }
                        param2--;
                        if(param2 != _loc7_)
                        {
                           param1.position = _loc7_;
                           _loc11_ = param1.readUTFBytes(param2 - _loc7_);
                        }
                     }
                     _loc3_ = _loc11_;
                     if(_loc3_ != null)
                     {
                        _loc6_ = parseFloat(_loc3_);
                     }
                     else
                     {
                        Error.throwError(Error,0);
                     }
                  }
                  else if(_loc5_ == uint(45))
                  {
                     while(true)
                     {
                        param2 = (_loc8_ = param2) + 1;
                        _loc7_ = li8(_loc8_);
                        if(_loc7_ != uint(13) && (_loc7_ != uint(10) && (_loc7_ != uint(32) && (_loc7_ != uint(9) && (_loc7_ != uint(11) && (_loc7_ != uint(8) && _loc7_ != uint(12)))))))
                        {
                           if(_loc7_ == uint(47))
                           {
                              param2 = (_loc8_ = param2) + 1;
                              _loc7_ = li8(_loc8_);
                              if(_loc7_ != uint(47))
                              {
                                 if(_loc7_ == uint(42))
                                 {
                                    param2 -= 2;
                                    _loc7_ = param2;
                                    _loc8_ = param2;
                                    param2 = (_loc9_ = param2) + 1;
                                    if(li8(_loc9_) != uint(47) || li8(_loc9_) != uint(42))
                                    {
                                       param2 = _loc8_;
                                    }
                                    else
                                    {
                                       while(true)
                                       {
                                          param2 = (_loc10_ = param2) + 1;
                                          _loc9_ = li8(_loc10_);
                                          if(_loc9_ != uint(42))
                                          {
                                             if(_loc9_ == uint(0))
                                             {
                                                break;
                                             }
                                             continue;
                                          }
                                          param2 = (_loc10_ = param2) + 1;
                                          if(li8(_loc10_) != uint(47))
                                          {
                                             param2--;
                                             continue;
                                          }
                                       }
                                       param2 = _loc8_;
                                    }
                                    if(_loc7_ != param2)
                                    {
                                       continue;
                                    }
                                 }
                                 param2--;
                              }
                              do
                              {
                                 param2 = (_loc9_ = param2) + 1;
                                 _loc8_ = li8(_loc9_);
                              }
                              while(_loc8_ != uint(10) && (_loc8_ != uint(13) && _loc8_ != uint(0)));
                              
                              param2--;
                              continue;
                              _loc7_ = uint(47);
                              break;
                           }
                           break;
                        }
                     }
                     _loc5_ = _loc7_;
                     if(_loc5_ >= uint(48) && _loc5_ <= uint(57) || _loc5_ == uint(46))
                     {
                        param2--;
                        _loc11_ = null;
                        _loc7_ = param2;
                        param2 = (_loc9_ = param2) + 1;
                        _loc8_ = li8(_loc9_);
                        if(_loc8_ == uint(48))
                        {
                           param2 = (_loc10_ = param2) + 1;
                           _loc8_ = li8(_loc10_);
                           if(_loc8_ == uint(120) || _loc8_ == uint(88))
                           {
                              _loc9_ = param2;
                              do
                              {
                                 param2 = (_loc10_ = param2) + 1;
                                 _loc8_ = li8(_loc10_);
                              }
                              while(_loc8_ >= uint(48) && _loc8_ <= uint(57) || (_loc8_ >= uint(97) && _loc8_ <= uint(102) || _loc8_ >= uint(65) && _loc8_ <= uint(70)));
                              
                              if(param2 == _loc9_ + 1)
                              {
                                 param2 = _loc7_ + 1;
                                 _loc8_ = uint(48);
                              }
                              else
                              {
                                 param2--;
                                 param1.position = _loc9_;
                                 _loc11_ = parseInt(param1.readUTFBytes(param2 - _loc9_),16);
                              }
                           }
                           else
                           {
                              param2--;
                              _loc8_ = uint(48);
                           }
                        }
                        if(_loc11_ == null)
                        {
                           while(_loc8_ >= uint(48) && _loc8_ <= uint(57))
                           {
                              param2 = (_loc10_ = param2) + 1;
                              _loc8_ = li8(_loc10_);
                           }
                           if(_loc8_ == uint(46))
                           {
                              _loc9_ = param2;
                              do
                              {
                                 param2 = (_loc10_ = param2) + 1;
                                 _loc8_ = li8(_loc10_);
                              }
                              while(_loc8_ >= uint(48) && _loc8_ <= uint(57));
                              
                              if(param2 == _loc9_ + 1)
                              {
                                 param2--;
                                 _loc8_ = uint(46);
                              }
                           }
                           if(_loc8_ == uint(101) || _loc8_ == uint(69))
                           {
                              _loc10_ = param2;
                              param2 = (_loc13_ = param2) + 1;
                              _loc8_ = li8(_loc13_);
                              if(_loc8_ == uint(45) || _loc8_ == uint(43))
                              {
                                 param2 = (_loc13_ = param2) + 1;
                                 _loc8_ = li8(_loc13_);
                              }
                              _loc9_ = param2;
                              while(_loc8_ >= uint(48) && _loc8_ <= uint(57))
                              {
                                 param2 = (_loc13_ = param2) + 1;
                                 _loc8_ = li8(_loc13_);
                              }
                              if(param2 == _loc9_)
                              {
                                 param2 = _loc10_;
                              }
                           }
                           param2--;
                           if(param2 != _loc7_)
                           {
                              param1.position = _loc7_;
                              _loc11_ = param1.readUTFBytes(param2 - _loc7_);
                           }
                        }
                        _loc3_ = _loc11_;
                        if(_loc3_ != null)
                        {
                           _loc6_ = -parseFloat(_loc3_);
                        }
                        else
                        {
                           Error.throwError(Error,0);
                        }
                     }
                     else if(_loc5_ == uint(110))
                     {
                        if(li8(param2) == 117 && li16(param2 + 1) == 27756)
                        {
                           param2 += 3;
                           _loc6_ = 0;
                        }
                        else
                        {
                           Error.throwError(Error,0);
                        }
                     }
                     else if(_loc5_ == uint(117))
                     {
                        if(li32(param2) == 1717920878 && li32(param2 + 4) == 1684369001)
                        {
                           param2 += 8;
                           _loc6_ = Number.NaN;
                        }
                        else
                        {
                           Error.throwError(Error,0);
                        }
                     }
                     else if(_loc5_ == uint(78))
                     {
                        if(li16(param2) == 20065)
                        {
                           param2 += 2;
                           _loc6_ = Number.NaN;
                        }
                        else
                        {
                           Error.throwError(Error,0);
                        }
                     }
                     else
                     {
                        Error.throwError(Error,0);
                     }
                  }
                  else if(_loc5_ == uint(110))
                  {
                     if(li8(param2) == 117 && li16(param2 + 1) == 27756)
                     {
                        param2 += 3;
                        _loc6_ = null;
                     }
                     else
                     {
                        Error.throwError(Error,0);
                     }
                  }
                  else if(_loc5_ == uint(116))
                  {
                     if(li8(param2) == 114 && li16(param2 + 1) == 25973)
                     {
                        param2 += 3;
                        _loc6_ = true;
                     }
                     else
                     {
                        Error.throwError(Error,0);
                     }
                  }
                  else if(_loc5_ == uint(102))
                  {
                     if(li32(param2) == 1702063201)
                     {
                        param2 += 4;
                        _loc6_ = false;
                     }
                     else
                     {
                        Error.throwError(Error,0);
                     }
                  }
                  else if(_loc5_ == uint(117))
                  {
                     if(li32(param2) == 1717920878 && li32(param2 + 4) == 1684369001)
                     {
                        param2 += 8;
                     }
                     else
                     {
                        Error.throwError(Error,0);
                     }
                  }
                  else if(_loc5_ == uint(78))
                  {
                     if(li16(param2) == 20065)
                     {
                        param2 += 2;
                        _loc6_ = Number.NaN;
                     }
                     else
                     {
                        Error.throwError(Error,0);
                     }
                  }
                  else if(_loc5_ == uint(123))
                  {
                     _loc16_ = new Object();
                     _loc11_ = null;
                     while(true)
                     {
                        param2 = (_loc8_ = param2) + 1;
                        _loc7_ = li8(_loc8_);
                        if(_loc7_ != uint(13) && (_loc7_ != uint(10) && (_loc7_ != uint(32) && (_loc7_ != uint(9) && (_loc7_ != uint(11) && (_loc7_ != uint(8) && _loc7_ != uint(12)))))))
                        {
                           if(_loc7_ == uint(47))
                           {
                              param2 = (_loc8_ = param2) + 1;
                              _loc7_ = li8(_loc8_);
                              if(_loc7_ != uint(47))
                              {
                                 if(_loc7_ == uint(42))
                                 {
                                    param2 -= 2;
                                    _loc7_ = param2;
                                    _loc8_ = param2;
                                    param2 = (_loc9_ = param2) + 1;
                                    if(li8(_loc9_) != uint(47) || li8(_loc9_) != uint(42))
                                    {
                                       param2 = _loc8_;
                                    }
                                    else
                                    {
                                       while(true)
                                       {
                                          param2 = (_loc10_ = param2) + 1;
                                          _loc9_ = li8(_loc10_);
                                          if(_loc9_ != uint(42))
                                          {
                                             if(_loc9_ == uint(0))
                                             {
                                                break;
                                             }
                                             continue;
                                          }
                                          param2 = (_loc10_ = param2) + 1;
                                          if(li8(_loc10_) != uint(47))
                                          {
                                             param2--;
                                             continue;
                                          }
                                       }
                                       param2 = _loc8_;
                                    }
                                    if(_loc7_ != param2)
                                    {
                                       continue;
                                    }
                                 }
                                 param2--;
                              }
                              do
                              {
                                 param2 = (_loc9_ = param2) + 1;
                                 _loc8_ = li8(_loc9_);
                              }
                              while(_loc8_ != uint(10) && (_loc8_ != uint(13) && _loc8_ != uint(0)));
                              
                              param2--;
                              continue;
                              _loc7_ = uint(47);
                              break;
                           }
                           break;
                        }
                     }
                     _loc5_ = _loc7_;
                     if(_loc5_ != uint(125))
                     {
                        param2--;
                        while(true)
                        {
                           while(true)
                           {
                              param2 = (_loc8_ = param2) + 1;
                              _loc7_ = li8(_loc8_);
                              if(_loc7_ != uint(13) && (_loc7_ != uint(10) && (_loc7_ != uint(32) && (_loc7_ != uint(9) && (_loc7_ != uint(11) && (_loc7_ != uint(8) && _loc7_ != uint(12)))))))
                              {
                                 if(_loc7_ == uint(47))
                                 {
                                    param2 = (_loc8_ = param2) + 1;
                                    _loc7_ = li8(_loc8_);
                                    if(_loc7_ != uint(47))
                                    {
                                       if(_loc7_ == uint(42))
                                       {
                                          param2 -= 2;
                                          _loc7_ = param2;
                                          _loc8_ = param2;
                                          param2 = (_loc9_ = param2) + 1;
                                          if(li8(_loc9_) != uint(47) || li8(_loc9_) != uint(42))
                                          {
                                             param2 = _loc8_;
                                          }
                                          else
                                          {
                                             while(true)
                                             {
                                                param2 = (_loc10_ = param2) + 1;
                                                _loc9_ = li8(_loc10_);
                                                if(_loc9_ != uint(42))
                                                {
                                                   if(_loc9_ == uint(0))
                                                   {
                                                      break;
                                                   }
                                                   continue;
                                                }
                                                param2 = (_loc10_ = param2) + 1;
                                                if(li8(_loc10_) != uint(47))
                                                {
                                                   param2--;
                                                   continue;
                                                }
                                             }
                                             param2 = _loc8_;
                                          }
                                          if(_loc7_ != param2)
                                          {
                                             §§goto(addr2576);
                                          }
                                       }
                                       param2--;
                                       _loc7_ = uint(47);
                                       break;
                                    }
                                    do
                                    {
                                       param2 = (_loc9_ = param2) + 1;
                                       _loc8_ = li8(_loc9_);
                                    }
                                    while(_loc8_ != uint(10) && (_loc8_ != uint(13) && _loc8_ != uint(0)));
                                    
                                    param2--;
                                    addr2576:
                                    continue;
                                    addr2576:
                                    §§goto(addr2576);
                                 }
                                 break;
                              }
                              §§goto(addr2576);
                           }
                           _loc5_ = _loc7_;
                           if(_loc5_ == uint(39) || _loc5_ == uint(34))
                           {
                              param2--;
                              _loc7_ = param2;
                              param2 = (_loc9_ = param2) + 1;
                              _loc8_ = li8(_loc9_);
                              if(_loc8_ != uint(39) && _loc8_ != uint(34))
                              {
                                 param2--;
                                 §§push(null);
                              }
                              else
                              {
                                 _loc9_ = _loc7_ + 1;
                                 _loc12_ = "";
                                 while(true)
                                 {
                                    _loc13_ = li8(param2);
                                    if(_loc13_ >= 128)
                                    {
                                       if((_loc13_ & 248) == 240)
                                       {
                                          _loc13_ = (_loc13_ & 7) << 18 | (li8(++param2) & 63) << 12 | (li8(++param2) & 63) << 6 | li8(++param2) & 63;
                                       }
                                       else if((_loc13_ & 240) == 224)
                                       {
                                          _loc13_ = (_loc13_ & 15) << 12 | (li8(++param2) & 63) << 6 | li8(++param2) & 63;
                                       }
                                       else if((_loc13_ & 224) == 192)
                                       {
                                          _loc13_ = (_loc13_ & 31) << 6 | li8(++param2) & 63;
                                       }
                                    }
                                    param2++;
                                    if((_loc10_ = _loc13_) == _loc8_)
                                    {
                                       break;
                                    }
                                    if(_loc10_ == uint(92))
                                    {
                                       param1.position = _loc9_;
                                       _loc12_ += param1.readUTFBytes(param2 - 1 - _loc9_);
                                       param2 = (_loc13_ = param2) + 1;
                                       _loc10_ = li8(_loc13_);
                                       if(_loc10_ == uint(110))
                                       {
                                          _loc12_ += "\n";
                                       }
                                       else if(_loc10_ == uint(114))
                                       {
                                          _loc12_ += "\r";
                                       }
                                       else if(_loc10_ == uint(116))
                                       {
                                          _loc12_ += "\t";
                                       }
                                       else if(_loc10_ == uint(118))
                                       {
                                          _loc12_ += "\x0b";
                                       }
                                       else if(_loc10_ == uint(102))
                                       {
                                          _loc12_ += "\f";
                                       }
                                       else if(_loc10_ == uint(98))
                                       {
                                          _loc12_ += "\b";
                                       }
                                       else if(_loc10_ == uint(120))
                                       {
                                          _loc14_ = 0;
                                          do
                                          {
                                             param2 = (_loc15_ = param2) + 1;
                                             _loc13_ = li8(_loc15_);
                                             if((_loc13_ < uint(48) || _loc13_ > uint(57)) && ((_loc13_ < uint(97) || _loc13_ > uint(102)) && (_loc13_ < uint(65) || _loc13_ > uint(70))))
                                             {
                                                break;
                                             }
                                          }
                                          while(++_loc14_ < 2);
                                          
                                          _loc17_ = _loc14_ != 2 ? (param2 -= _loc14_ + 1, null) : (param1.position = param2 - 2, param1.readUTFBytes(2));
                                          if(_loc17_ != null)
                                          {
                                             _loc12_ += String.fromCharCode(parseInt(_loc17_,16));
                                          }
                                          else
                                          {
                                             _loc12_ += "x";
                                          }
                                       }
                                       else if(_loc10_ == uint(117))
                                       {
                                          _loc14_ = 0;
                                          do
                                          {
                                             param2 = (_loc15_ = param2) + 1;
                                             _loc13_ = li8(_loc15_);
                                             if((_loc13_ < uint(48) || _loc13_ > uint(57)) && ((_loc13_ < uint(97) || _loc13_ > uint(102)) && (_loc13_ < uint(65) || _loc13_ > uint(70))))
                                             {
                                                break;
                                             }
                                          }
                                          while(++_loc14_ < 4);
                                          
                                          _loc17_ = _loc14_ != 4 ? (param2 -= _loc14_ + 1, null) : (param1.position = param2 - 4, param1.readUTFBytes(4));
                                          if(_loc17_ != null)
                                          {
                                             _loc12_ += String.fromCharCode(parseInt(_loc17_,16));
                                          }
                                          else
                                          {
                                             _loc12_ += "u";
                                          }
                                       }
                                       else
                                       {
                                          if(_loc10_ >= 128)
                                          {
                                             param2--;
                                             _loc13_ = li8(param2);
                                             if(_loc13_ >= 128)
                                             {
                                                if((_loc13_ & 248) == 240)
                                                {
                                                   _loc13_ = (_loc13_ & 7) << 18 | (li8(++param2) & 63) << 12 | (li8(++param2) & 63) << 6 | li8(++param2) & 63;
                                                }
                                                else if((_loc13_ & 240) == 224)
                                                {
                                                   _loc13_ = (_loc13_ & 15) << 12 | (li8(++param2) & 63) << 6 | li8(++param2) & 63;
                                                }
                                                else if((_loc13_ & 224) == 192)
                                                {
                                                   _loc13_ = (_loc13_ & 31) << 6 | li8(++param2) & 63;
                                                }
                                             }
                                             param2++;
                                             _loc10_ = _loc13_;
                                          }
                                          _loc12_ += String.fromCharCode(_loc10_);
                                       }
                                       _loc9_ = param2;
                                    }
                                    else if(_loc10_ == uint(0) || (_loc10_ == uint(13) || _loc10_ == uint(10)))
                                    {
                                       param2 = _loc7_;
                                       break;
                                    }
                                 }
                                 if(param2 == _loc7_)
                                 {
                                    §§push(null);
                                 }
                                 else
                                 {
                                    if(_loc9_ != param2 - 1)
                                    {
                                       param1.position = _loc9_;
                                       _loc12_ += param1.readUTFBytes(param2 - 1 - _loc9_);
                                    }
                                    §§push(_loc12_);
                                 }
                              }
                              _loc3_ = §§pop();
                              if(_loc3_ != null)
                              {
                                 _loc11_ = _loc3_;
                              }
                              else
                              {
                                 Error.throwError(Error,0);
                              }
                           }
                           else if(_loc5_ >= uint(48) && _loc5_ <= uint(57) || _loc5_ == uint(46))
                           {
                              param2--;
                              _loc12_ = null;
                              _loc7_ = param2;
                              param2 = (_loc9_ = param2) + 1;
                              _loc8_ = li8(_loc9_);
                              if(_loc8_ == uint(48))
                              {
                                 param2 = (_loc10_ = param2) + 1;
                                 _loc8_ = li8(_loc10_);
                                 if(_loc8_ == uint(120) || _loc8_ == uint(88))
                                 {
                                    _loc9_ = param2;
                                    do
                                    {
                                       param2 = (_loc10_ = param2) + 1;
                                       _loc8_ = li8(_loc10_);
                                    }
                                    while(_loc8_ >= uint(48) && _loc8_ <= uint(57) || (_loc8_ >= uint(97) && _loc8_ <= uint(102) || _loc8_ >= uint(65) && _loc8_ <= uint(70)));
                                    
                                    if(param2 == _loc9_ + 1)
                                    {
                                       param2 = _loc7_ + 1;
                                       _loc8_ = uint(48);
                                    }
                                    else
                                    {
                                       param2--;
                                       param1.position = _loc9_;
                                       _loc12_ = parseInt(param1.readUTFBytes(param2 - _loc9_),16);
                                    }
                                 }
                                 else
                                 {
                                    param2--;
                                    _loc8_ = uint(48);
                                 }
                              }
                              if(_loc12_ == null)
                              {
                                 while(_loc8_ >= uint(48) && _loc8_ <= uint(57))
                                 {
                                    param2 = (_loc10_ = param2) + 1;
                                    _loc8_ = li8(_loc10_);
                                 }
                                 if(_loc8_ == uint(46))
                                 {
                                    _loc9_ = param2;
                                    do
                                    {
                                       param2 = (_loc10_ = param2) + 1;
                                       _loc8_ = li8(_loc10_);
                                    }
                                    while(_loc8_ >= uint(48) && _loc8_ <= uint(57));
                                    
                                    if(param2 == _loc9_ + 1)
                                    {
                                       param2--;
                                       _loc8_ = uint(46);
                                    }
                                 }
                                 if(_loc8_ == uint(101) || _loc8_ == uint(69))
                                 {
                                    _loc10_ = param2;
                                    param2 = (_loc13_ = param2) + 1;
                                    _loc8_ = li8(_loc13_);
                                    if(_loc8_ == uint(45) || _loc8_ == uint(43))
                                    {
                                       param2 = (_loc13_ = param2) + 1;
                                       _loc8_ = li8(_loc13_);
                                    }
                                    _loc9_ = param2;
                                    while(_loc8_ >= uint(48) && _loc8_ <= uint(57))
                                    {
                                       param2 = (_loc13_ = param2) + 1;
                                       _loc8_ = li8(_loc13_);
                                    }
                                    if(param2 == _loc9_)
                                    {
                                       param2 = _loc10_;
                                    }
                                 }
                                 param2--;
                                 if(param2 != _loc7_)
                                 {
                                    param1.position = _loc7_;
                                    _loc12_ = param1.readUTFBytes(param2 - _loc7_);
                                 }
                              }
                              _loc3_ = _loc12_;
                              if(_loc3_ != null)
                              {
                                 _loc11_ = parseFloat(_loc3_).toString();
                              }
                              else
                              {
                                 Error.throwError(Error,0);
                              }
                           }
                           else if(_loc5_ == uint(110) && (li8(param2) == 117 && li16(param2 + 1) == 27756) || (_loc5_ == uint(116) && (li8(param2) == 114 && li16(param2 + 1) == 25973) || _loc5_ == uint(102) && li32(param2) == 1702063201))
                           {
                              Error.throwError(Error,0);
                           }
                           else
                           {
                              param2--;
                              _loc7_ = param2;
                              _loc9_ = li8(param2);
                              if(_loc9_ >= 128)
                              {
                                 if((_loc9_ & 248) == 240)
                                 {
                                    _loc9_ = (_loc9_ & 7) << 18 | (li8(++param2) & 63) << 12 | (li8(++param2) & 63) << 6 | li8(++param2) & 63;
                                 }
                                 else if((_loc9_ & 240) == 224)
                                 {
                                    _loc9_ = (_loc9_ & 15) << 12 | (li8(++param2) & 63) << 6 | li8(++param2) & 63;
                                 }
                                 else if((_loc9_ & 224) == 192)
                                 {
                                    _loc9_ = (_loc9_ & 31) << 6 | li8(++param2) & 63;
                                 }
                              }
                              param2++;
                              _loc8_ = _loc9_;
                              if((_loc8_ < uint(97) || _loc8_ > uint(122)) && ((_loc8_ < uint(65) || _loc8_ > uint(90)) && (_loc8_ != uint(36) && (_loc8_ != uint(95) && _loc8_ <= 127))))
                              {
                                 param2 = _loc7_;
                                 §§push(null);
                              }
                              else
                              {
                                 do
                                 {
                                    _loc9_ = param2;
                                    _loc10_ = li8(param2);
                                    if(_loc10_ >= 128)
                                    {
                                       if((_loc10_ & 248) == 240)
                                       {
                                          _loc10_ = (_loc10_ & 7) << 18 | (li8(++param2) & 63) << 12 | (li8(++param2) & 63) << 6 | li8(++param2) & 63;
                                       }
                                       else if((_loc10_ & 240) == 224)
                                       {
                                          _loc10_ = (_loc10_ & 15) << 12 | (li8(++param2) & 63) << 6 | li8(++param2) & 63;
                                       }
                                       else if((_loc10_ & 224) == 192)
                                       {
                                          _loc10_ = (_loc10_ & 31) << 6 | li8(++param2) & 63;
                                       }
                                    }
                                    param2++;
                                    _loc8_ = _loc10_;
                                 }
                                 while(_loc8_ >= uint(97) && _loc8_ <= uint(122) || (_loc8_ >= uint(65) && _loc8_ <= uint(90) || (_loc8_ >= uint(48) && _loc8_ <= uint(57) || (_loc8_ == uint(36) || (_loc8_ == uint(95) || _loc8_ > 127)))));
                                 
                                 param2 = _loc9_;
                                 param1.position = _loc7_;
                                 §§push(param1.readUTFBytes(param2 - _loc7_));
                              }
                              _loc3_ = §§pop();
                              if(_loc3_ != null)
                              {
                                 _loc11_ = _loc3_;
                              }
                              else
                              {
                                 Error.throwError(Error,0);
                              }
                           }
                           while(true)
                           {
                              param2 = (_loc8_ = param2) + 1;
                              _loc7_ = li8(_loc8_);
                              if(_loc7_ != uint(13) && (_loc7_ != uint(10) && (_loc7_ != uint(32) && (_loc7_ != uint(9) && (_loc7_ != uint(11) && (_loc7_ != uint(8) && _loc7_ != uint(12)))))))
                              {
                                 if(_loc7_ == uint(47))
                                 {
                                    param2 = (_loc8_ = param2) + 1;
                                    _loc7_ = li8(_loc8_);
                                    if(_loc7_ != uint(47))
                                    {
                                       if(_loc7_ == uint(42))
                                       {
                                          param2 -= 2;
                                          _loc7_ = param2;
                                          _loc8_ = param2;
                                          param2 = (_loc9_ = param2) + 1;
                                          if(li8(_loc9_) != uint(47) || li8(_loc9_) != uint(42))
                                          {
                                             param2 = _loc8_;
                                          }
                                          else
                                          {
                                             while(true)
                                             {
                                                param2 = (_loc10_ = param2) + 1;
                                                _loc9_ = li8(_loc10_);
                                                if(_loc9_ != uint(42))
                                                {
                                                   if(_loc9_ == uint(0))
                                                   {
                                                      break;
                                                   }
                                                   continue;
                                                }
                                                param2 = (_loc10_ = param2) + 1;
                                                if(li8(_loc10_) != uint(47))
                                                {
                                                   param2--;
                                                   continue;
                                                }
                                             }
                                             param2 = _loc8_;
                                          }
                                          if(_loc7_ != param2)
                                          {
                                             continue;
                                          }
                                       }
                                       param2--;
                                    }
                                    do
                                    {
                                       param2 = (_loc9_ = param2) + 1;
                                       _loc8_ = li8(_loc9_);
                                    }
                                    while(_loc8_ != uint(10) && (_loc8_ != uint(13) && _loc8_ != uint(0)));
                                    
                                    param2--;
                                    continue;
                                    _loc7_ = uint(47);
                                    break;
                                 }
                                 break;
                              }
                           }
                           if(_loc7_ != uint(58))
                           {
                              Error.throwError(Error,0);
                           }
                           _loc16_[_loc11_] = readValue(param1,param2);
                           param2 = position;
                           while(true)
                           {
                              param2 = (_loc8_ = param2) + 1;
                              _loc7_ = li8(_loc8_);
                              if(_loc7_ != uint(13) && (_loc7_ != uint(10) && (_loc7_ != uint(32) && (_loc7_ != uint(9) && (_loc7_ != uint(11) && (_loc7_ != uint(8) && _loc7_ != uint(12)))))))
                              {
                                 if(_loc7_ == uint(47))
                                 {
                                    param2 = (_loc8_ = param2) + 1;
                                    _loc7_ = li8(_loc8_);
                                    if(_loc7_ != uint(47))
                                    {
                                       if(_loc7_ == uint(42))
                                       {
                                          param2 -= 2;
                                          _loc7_ = param2;
                                          _loc8_ = param2;
                                          param2 = (_loc9_ = param2) + 1;
                                          if(li8(_loc9_) != uint(47) || li8(_loc9_) != uint(42))
                                          {
                                             param2 = _loc8_;
                                          }
                                          else
                                          {
                                             while(true)
                                             {
                                                param2 = (_loc10_ = param2) + 1;
                                                _loc9_ = li8(_loc10_);
                                                if(_loc9_ != uint(42))
                                                {
                                                   if(_loc9_ == uint(0))
                                                   {
                                                      break;
                                                   }
                                                   continue;
                                                }
                                                param2 = (_loc10_ = param2) + 1;
                                                if(li8(_loc10_) != uint(47))
                                                {
                                                   param2--;
                                                   continue;
                                                }
                                             }
                                             param2 = _loc8_;
                                          }
                                          if(_loc7_ != param2)
                                          {
                                             continue;
                                          }
                                       }
                                       param2--;
                                    }
                                    do
                                    {
                                       param2 = (_loc9_ = param2) + 1;
                                       _loc8_ = li8(_loc9_);
                                    }
                                    while(_loc8_ != uint(10) && (_loc8_ != uint(13) && _loc8_ != uint(0)));
                                    
                                    param2--;
                                    continue;
                                    _loc7_ = uint(47);
                                    break;
                                 }
                                 break;
                              }
                           }
                           _loc5_ = _loc7_;
                           if(_loc5_ == uint(125))
                           {
                              break;
                           }
                           if(_loc5_ != uint(44))
                           {
                              Error.throwError(Error,0);
                           }
                        }
                     }
                     _loc6_ = _loc16_;
                  }
                  else if(_loc5_ == uint(91))
                  {
                     _loc18_ = [];
                     while(true)
                     {
                        while(true)
                        {
                           param2 = (_loc8_ = param2) + 1;
                           _loc7_ = li8(_loc8_);
                           if(_loc7_ != uint(13) && (_loc7_ != uint(10) && (_loc7_ != uint(32) && (_loc7_ != uint(9) && (_loc7_ != uint(11) && (_loc7_ != uint(8) && _loc7_ != uint(12)))))))
                           {
                              if(_loc7_ == uint(47))
                              {
                                 param2 = (_loc8_ = param2) + 1;
                                 _loc7_ = li8(_loc8_);
                                 if(_loc7_ != uint(47))
                                 {
                                    if(_loc7_ == uint(42))
                                    {
                                       param2 -= 2;
                                       _loc7_ = param2;
                                       _loc8_ = param2;
                                       param2 = (_loc9_ = param2) + 1;
                                       if(li8(_loc9_) != uint(47) || li8(_loc9_) != uint(42))
                                       {
                                          param2 = _loc8_;
                                       }
                                       else
                                       {
                                          while(true)
                                          {
                                             param2 = (_loc10_ = param2) + 1;
                                             _loc9_ = li8(_loc10_);
                                             if(_loc9_ != uint(42))
                                             {
                                                if(_loc9_ == uint(0))
                                                {
                                                   break;
                                                }
                                                continue;
                                             }
                                             param2 = (_loc10_ = param2) + 1;
                                             if(li8(_loc10_) != uint(47))
                                             {
                                                param2--;
                                                continue;
                                             }
                                          }
                                          param2 = _loc8_;
                                       }
                                       if(_loc7_ != param2)
                                       {
                                          §§goto(addr4763);
                                       }
                                    }
                                    param2--;
                                    _loc7_ = uint(47);
                                    break;
                                 }
                                 do
                                 {
                                    param2 = (_loc9_ = param2) + 1;
                                    _loc8_ = li8(_loc9_);
                                 }
                                 while(_loc8_ != uint(10) && (_loc8_ != uint(13) && _loc8_ != uint(0)));
                                 
                                 param2--;
                                 addr4763:
                                 continue;
                                 addr4763:
                                 §§goto(addr4763);
                              }
                              break;
                           }
                           §§goto(addr4763);
                        }
                        _loc5_ = _loc7_;
                        if(_loc5_ == uint(93))
                        {
                           break;
                        }
                        if(_loc5_ == uint(44))
                        {
                           _loc18_.push(undefined);
                        }
                        else
                        {
                           param2--;
                           _loc18_.push(readValue(param1,param2));
                           param2 = position;
                           while(true)
                           {
                              param2 = (_loc8_ = param2) + 1;
                              _loc7_ = li8(_loc8_);
                              if(_loc7_ != uint(13) && (_loc7_ != uint(10) && (_loc7_ != uint(32) && (_loc7_ != uint(9) && (_loc7_ != uint(11) && (_loc7_ != uint(8) && _loc7_ != uint(12)))))))
                              {
                                 if(_loc7_ == uint(47))
                                 {
                                    param2 = (_loc8_ = param2) + 1;
                                    _loc7_ = li8(_loc8_);
                                    if(_loc7_ != uint(47))
                                    {
                                       if(_loc7_ == uint(42))
                                       {
                                          param2 -= 2;
                                          _loc7_ = param2;
                                          _loc8_ = param2;
                                          param2 = (_loc9_ = param2) + 1;
                                          if(li8(_loc9_) != uint(47) || li8(_loc9_) != uint(42))
                                          {
                                             param2 = _loc8_;
                                          }
                                          else
                                          {
                                             while(true)
                                             {
                                                param2 = (_loc10_ = param2) + 1;
                                                _loc9_ = li8(_loc10_);
                                                if(_loc9_ != uint(42))
                                                {
                                                   if(_loc9_ == uint(0))
                                                   {
                                                      break;
                                                   }
                                                   continue;
                                                }
                                                param2 = (_loc10_ = param2) + 1;
                                                if(li8(_loc10_) != uint(47))
                                                {
                                                   param2--;
                                                   continue;
                                                }
                                             }
                                             param2 = _loc8_;
                                          }
                                          if(_loc7_ != param2)
                                          {
                                             continue;
                                          }
                                       }
                                       param2--;
                                    }
                                    do
                                    {
                                       param2 = (_loc9_ = param2) + 1;
                                       _loc8_ = li8(_loc9_);
                                    }
                                    while(_loc8_ != uint(10) && (_loc8_ != uint(13) && _loc8_ != uint(0)));
                                    
                                    param2--;
                                    continue;
                                    _loc7_ = uint(47);
                                    break;
                                 }
                                 break;
                              }
                           }
                           _loc5_ = _loc7_;
                           if(_loc5_ == uint(93))
                           {
                              break;
                           }
                           if(_loc5_ != uint(44))
                           {
                              Error.throwError(Error,0);
                           }
                        }
                     }
                     _loc6_ = _loc18_;
                  }
                  else
                  {
                     Error.throwError(Error,0);
                  }
                  position = param2;
                  return _loc6_;
               };
               _loc12_ = false;
               try
               {
                  _loc3_ = readValue(_loc5_,position);
                  _loc6_ = position;
                  while(true)
                  {
                     _loc6_ = (_loc9_ = _loc6_) + 1;
                     _loc8_ = li8(_loc9_);
                     if(_loc8_ != uint(13) && (_loc8_ != uint(10) && (_loc8_ != uint(32) && (_loc8_ != uint(9) && (_loc8_ != uint(11) && (_loc8_ != uint(8) && _loc8_ != uint(12)))))))
                     {
                        if(_loc8_ == uint(47))
                        {
                           _loc6_ = (_loc9_ = _loc6_) + 1;
                           _loc8_ = li8(_loc9_);
                           if(_loc8_ != uint(47))
                           {
                              if(_loc8_ == uint(42))
                              {
                                 _loc6_ -= 2;
                                 _loc8_ = _loc6_;
                                 _loc9_ = _loc6_;
                                 _loc6_ = (_loc10_ = _loc6_) + 1;
                                 if(li8(_loc10_) != uint(47) || li8(_loc10_) != uint(42))
                                 {
                                    _loc6_ = _loc9_;
                                 }
                                 else
                                 {
                                    while(true)
                                    {
                                       _loc6_ = (_loc11_ = _loc6_) + 1;
                                       _loc10_ = li8(_loc11_);
                                       if(_loc10_ != uint(42))
                                       {
                                          if(_loc10_ == uint(0))
                                          {
                                             break;
                                          }
                                          continue;
                                       }
                                       _loc6_ = (_loc11_ = _loc6_) + 1;
                                       if(li8(_loc11_) != uint(47))
                                       {
                                          _loc6_--;
                                          continue;
                                       }
                                    }
                                    _loc6_ = _loc9_;
                                 }
                                 if(_loc8_ != _loc6_)
                                 {
                                    continue;
                                 }
                              }
                              _loc6_--;
                           }
                           do
                           {
                              _loc6_ = (_loc10_ = _loc6_) + 1;
                              _loc9_ = li8(_loc10_);
                           }
                           while(_loc9_ != uint(10) && (_loc9_ != uint(13) && _loc9_ != uint(0)));
                           
                           _loc6_--;
                           continue;
                           _loc8_ = uint(47);
                           break;
                        }
                        break;
                     }
                  }
                  _loc7_ = _loc8_;
                  if(_loc7_ == uint(0))
                  {
                     _loc12_ = true;
                  }
               }
               catch(_loc_e_:*)
               {
                  if(!_loc12_)
                  {
                     ApplicationDomain.currentDomain.domainMemory = _loc4_;
                     Error.throwError(SyntaxError,1509);
                  }
               }
            }
            ApplicationDomain.currentDomain.domainMemory = _loc4_;
         }
         return _loc3_;
      }
   }
}
