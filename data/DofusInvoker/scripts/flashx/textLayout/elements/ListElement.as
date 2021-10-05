package flashx.textLayout.elements
{
   import flashx.textLayout.events.ModelChange;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.formats.Direction;
   import flashx.textLayout.formats.FormatValue;
   import flashx.textLayout.formats.IListMarkerFormat;
   import flashx.textLayout.formats.ListStyleType;
   import flashx.textLayout.formats.Suffix;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class ListElement extends ContainerFormattedElement
   {
      
      tlf_internal static const LIST_MARKER_FORMAT_NAME:String = "listMarkerFormat";
      
      tlf_internal static const constantListStyles:Object = {
         "none":"",
         "disc":"•",
         "circle":"◦",
         "square":"■",
         "box":"□",
         "check":"✓",
         "diamond":"◆",
         "hyphen":"⁃"
      };
      
      private static const romanDigitFunction:Vector.<Function> = Vector.<Function>([function(o:String, f:String, t:String):String
      {
         return "";
      },function(o:String, f:String, t:String):String
      {
         return o;
      },function(o:String, f:String, t:String):String
      {
         return o + o;
      },function(o:String, f:String, t:String):String
      {
         return o + o + o;
      },function(o:String, f:String, t:String):String
      {
         return o + f;
      },function(o:String, f:String, t:String):String
      {
         return f;
      },function(o:String, f:String, t:String):String
      {
         return f + o;
      },function(o:String, f:String, t:String):String
      {
         return f + o + o;
      },function(o:String, f:String, t:String):String
      {
         return f + o + o + o;
      },function(o:String, f:String, t:String):String
      {
         return o + t;
      }]);
      
      private static const upperRomanData:Vector.<String> = Vector.<String>(["I","V","X","L","C","D","M"]);
      
      private static const lowerRomanData:Vector.<String> = Vector.<String>(["i","v","x","l","c","d","m"]);
      
      tlf_internal static const cjkEarthlyBranchData:Vector.<int> = Vector.<int>([23376,19985,23493,21359,36784,24051,21320,26410,30003,37193,25100,20133]);
      
      tlf_internal static const cjkHeavenlyStemData:Vector.<int> = Vector.<int>([30002,20057,19993,19969,25098,24049,24218,36763,22764,30328]);
      
      tlf_internal static const hangulData:Vector.<int> = Vector.<int>([44032,45208,45796,46972,47560,48148,49324,50500,51088,52264,52852,53440,54028,54616]);
      
      tlf_internal static const hangulConstantData:Vector.<int> = Vector.<int>([12593,12596,12599,12601,12609,12610,12613,12615,12616,12618,12619,12620,12621,12622]);
      
      tlf_internal static const hiraganaData:Vector.<int> = Vector.<int>([12354,12356,12358,12360,12362,12363,12365,12367,12369,12371,12373,12375,12377,12379,12381,12383,12385,12388,12390,12392,12394,12395,12396,12397,12398,12399,12402,12405,12408,12411,12414,12415,12416,12417,12418,12420,12422,12424,12425,12426,12427,12428,12429,12431,12432,12433,12434,12435]);
      
      tlf_internal static const hiraganaIrohaData:Vector.<int> = Vector.<int>([12356,12429,12399,12395,12411,12408,12392,12385,12426,12396,12427,12434,12431,12363,12424,12383,12428,12381,12388,12397,12394,12425,12416,12358,12432,12398,12362,12367,12420,12414,12369,12405,12371,12360,12390,12354,12373,12365,12422,12417,12415,12375,12433,12402,12418,12379,12377]);
      
      tlf_internal static const katakanaData:Vector.<int> = Vector.<int>([12450,12452,12454,12456,12458,12459,12461,12463,12465,12467,12469,12471,12473,12475,12477,12479,12481,12484,12486,12488,12490,12491,12492,12493,12494,12495,12498,12501,12504,12507,12510,12511,12512,12513,12514,12516,12518,12520,12521,12522,12523,12524,12525,12527,12528,12529,12530,12531]);
      
      tlf_internal static const katakanaIrohaData:Vector.<int> = Vector.<int>([12452,12525,12495,12491,12507,12504,12488,12481,12522,12492,12523,12530,12527,12459,12520,12479,12524,12477,12484,12493,12490,12521,12512,12454,12528,12494,12458,12463,12516,12510,12465,12501,12467,12456,12486,12450,12469,12461,12518,12513,12511,12471,12529,12498,12514,12475,12473]);
      
      tlf_internal static const lowerGreekData:Vector.<int> = Vector.<int>([945,946,947,948,949,950,951,952,953,954,955,956,957,958,959,960,961,963,964,965,966,967,968,969]);
      
      tlf_internal static const upperGreekData:Vector.<int> = Vector.<int>([913,914,915,916,917,918,919,920,921,922,923,924,925,926,927,928,929,931,932,933,934,935,936,937]);
      
      tlf_internal static const algorithmicListStyles:Object = {
         "upperRoman":tlf_internal::upperRomanString,
         "lowerRoman":tlf_internal::lowerRomanString
      };
      
      tlf_internal static const numericListStyles:Object = {
         "arabicIndic":tlf_internal::arabicIndicString,
         "bengali":tlf_internal::bengaliString,
         "decimal":tlf_internal::decimalString,
         "decimalLeadingZero":tlf_internal::decimalLeadingZeroString,
         "devanagari":tlf_internal::devanagariString,
         "gujarati":tlf_internal::gujaratiString,
         "gurmukhi":tlf_internal::gurmukhiString,
         "kannada":tlf_internal::kannadaString,
         "persian":tlf_internal::persianString,
         "thai":tlf_internal::thaiString,
         "urdu":tlf_internal::urduString
      };
      
      tlf_internal static const alphabeticListStyles:Object = {
         "upperAlpha":tlf_internal::upperAlphaString,
         "lowerAlpha":tlf_internal::lowerAlphaString,
         "cjkEarthlyBranch":tlf_internal::cjkEarthlyBranchString,
         "cjkHeavenlyStem":tlf_internal::cjkHeavenlyStemString,
         "hangul":tlf_internal::hangulString,
         "hangulConstant":tlf_internal::hangulConstantString,
         "hiragana":tlf_internal::hiraganaString,
         "hiraganaIroha":tlf_internal::hiraganaIrohaString,
         "katakana":tlf_internal::katakanaString,
         "katakanaIroha":tlf_internal::katakanaIrohaString,
         "lowerGreek":tlf_internal::lowerGreekString,
         "lowerLatin":tlf_internal::lowerLatinString,
         "upperGreek":tlf_internal::upperGreekString,
         "upperLatin":tlf_internal::upperLatinString
      };
      
      tlf_internal static const listSuffixes:Object = {
         "upperAlpha":".",
         "lowerAlpha":".",
         "upperRoman":".",
         "lowerRoman":".",
         "arabicIndic":".",
         "bengali":".",
         "decimal":".",
         "decimalLeadingZero":".",
         "devanagari":".",
         "gujarati":".",
         "gurmukhi":".",
         "kannada":".",
         "persian":".",
         "thai":".",
         "urdu":".",
         "cjkEarthlyBranch":".",
         "cjkHeavenlyStem":".",
         "hangul":".",
         "hangulConstant":".",
         "hiragana":".",
         "hiraganaIroha":".",
         "katakana":".",
         "katakanaIroha":".",
         "lowerGreek":".",
         "lowerLatin":".",
         "upperGreek":".",
         "upperLatin":"."
      };
       
      
      public function ListElement()
      {
         super();
      }
      
      tlf_internal static function createRomanString(n:int, data:Vector.<String>) : String
      {
         var leading:String = "";
         while(n >= 1000)
         {
            leading += data[6];
            n -= 1000;
         }
         return leading + romanDigitFunction[int(n / 100)](data[4],data[5],data[6]) + romanDigitFunction[int(n / 10 % 10)](data[2],data[3],data[4]) + romanDigitFunction[int(n % 10)](data[0],data[1],data[2]);
      }
      
      tlf_internal static function upperRomanString(n:int) : String
      {
         if(n <= 0)
         {
            return decimalString(n);
         }
         if(n <= 1000)
         {
            return createRomanString(n,upperRomanData);
         }
         if(n >= 40000)
         {
            return decimalString(n);
         }
         var lowerString:String = createRomanString(n % 1000,upperRomanData);
         var highString:* = "";
         n -= n % 1000;
         while(n >= 10000)
         {
            highString += String.fromCharCode(8578);
            n -= 10000;
         }
         if(n == 9000)
         {
            highString += "M" + String.fromCharCode(8578);
         }
         else if(n == 4000)
         {
            highString += "M" + String.fromCharCode(8577);
         }
         else
         {
            if(n >= 5000)
            {
               highString += String.fromCharCode(8577);
               n -= 5000;
            }
            while(n > 0)
            {
               highString += "M";
               n -= 1000;
            }
         }
         return highString + lowerString;
      }
      
      tlf_internal static function lowerRomanString(n:int) : String
      {
         return n > 0 && n < 4000 ? createRomanString(n,lowerRomanData) : decimalString(n);
      }
      
      tlf_internal static function decimalString(n:int) : String
      {
         return n.toString();
      }
      
      tlf_internal static function decimalLeadingZeroString(n:int) : String
      {
         return n <= 9 && n >= -9 ? "0" + n.toString() : n.toString();
      }
      
      tlf_internal static function createNumericBaseTenString(n:int, zero:int) : String
      {
         if(n == 0)
         {
            return String.fromCharCode(zero);
         }
         var rslt:String = "";
         while(n > 0)
         {
            rslt = String.fromCharCode(n % 10 + zero) + rslt;
            n /= 10;
         }
         return rslt;
      }
      
      tlf_internal static function arabicIndicString(n:int) : String
      {
         return createNumericBaseTenString(n,1632);
      }
      
      tlf_internal static function bengaliString(n:int) : String
      {
         return createNumericBaseTenString(n,2534);
      }
      
      tlf_internal static function devanagariString(n:int) : String
      {
         return createNumericBaseTenString(n,2406);
      }
      
      tlf_internal static function gujaratiString(n:int) : String
      {
         return createNumericBaseTenString(n,2790);
      }
      
      tlf_internal static function gurmukhiString(n:int) : String
      {
         return createNumericBaseTenString(n,2662);
      }
      
      tlf_internal static function kannadaString(n:int) : String
      {
         return createNumericBaseTenString(n,3302);
      }
      
      tlf_internal static function persianString(n:int) : String
      {
         return createNumericBaseTenString(n,1776);
      }
      
      tlf_internal static function thaiString(n:int) : String
      {
         return createNumericBaseTenString(n,3664);
      }
      
      tlf_internal static function urduString(n:int) : String
      {
         return createNumericBaseTenString(n,1776);
      }
      
      tlf_internal static function createContinuousAlphaString(n:int, first:int, base:int) : String
      {
         var rslt:String = "";
         while(n > 0)
         {
            rslt = String.fromCharCode((n - 1) % base + first) + rslt;
            n = (n - 1) / base;
         }
         return rslt;
      }
      
      tlf_internal static function lowerAlphaString(n:int) : String
      {
         return createContinuousAlphaString(n,97,26);
      }
      
      tlf_internal static function upperAlphaString(n:int) : String
      {
         return createContinuousAlphaString(n,65,26);
      }
      
      tlf_internal static function lowerLatinString(n:int) : String
      {
         return createContinuousAlphaString(n,97,26);
      }
      
      tlf_internal static function upperLatinString(n:int) : String
      {
         return createContinuousAlphaString(n,65,26);
      }
      
      tlf_internal static function createTableAlphaString(n:int, table:Vector.<int>) : String
      {
         var rslt:String = "";
         var base:int = table.length;
         while(n > 0)
         {
            rslt = String.fromCharCode(table[(n - 1) % base]) + rslt;
            n = (n - 1) / base;
         }
         return rslt;
      }
      
      tlf_internal static function cjkEarthlyBranchString(n:int) : String
      {
         return createTableAlphaString(n,tlf_internal::cjkEarthlyBranchData);
      }
      
      tlf_internal static function cjkHeavenlyStemString(n:int) : String
      {
         return createTableAlphaString(n,tlf_internal::cjkHeavenlyStemData);
      }
      
      tlf_internal static function hangulString(n:int) : String
      {
         return createTableAlphaString(n,tlf_internal::hangulData);
      }
      
      tlf_internal static function hangulConstantString(n:int) : String
      {
         return createTableAlphaString(n,tlf_internal::hangulConstantData);
      }
      
      tlf_internal static function hiraganaString(n:int) : String
      {
         return createTableAlphaString(n,tlf_internal::hiraganaData);
      }
      
      tlf_internal static function hiraganaIrohaString(n:int) : String
      {
         return createTableAlphaString(n,tlf_internal::hiraganaIrohaData);
      }
      
      tlf_internal static function katakanaString(n:int) : String
      {
         return createTableAlphaString(n,tlf_internal::katakanaData);
      }
      
      tlf_internal static function katakanaIrohaString(n:int) : String
      {
         return createTableAlphaString(n,tlf_internal::katakanaIrohaData);
      }
      
      tlf_internal static function lowerGreekString(n:int) : String
      {
         return createTableAlphaString(n,tlf_internal::lowerGreekData);
      }
      
      tlf_internal static function upperGreekString(n:int) : String
      {
         return createTableAlphaString(n,tlf_internal::upperGreekData);
      }
      
      override protected function get abstract() : Boolean
      {
         return false;
      }
      
      override tlf_internal function get defaultTypeName() : String
      {
         return "list";
      }
      
      override tlf_internal function canOwnFlowElement(elem:FlowElement) : Boolean
      {
         return !(elem is TextFlow) && !(elem is FlowLeafElement) && !(elem is SubParagraphGroupElementBase);
      }
      
      override tlf_internal function modelChanged(changeType:String, elem:FlowElement, changeStart:int, changeLen:int, needNormalize:Boolean = true, bumpGeneration:Boolean = true) : void
      {
         if((changeType == ModelChange.ELEMENT_ADDED || changeType == ModelChange.ELEMENT_REMOVAL) && elem is ListItemElement && this.isNumberedList())
         {
            changeStart = elem.parentRelativeStart;
            changeLen = textLength - elem.parentRelativeStart;
         }
         super.modelChanged(changeType,elem,changeStart,changeLen,needNormalize,bumpGeneration);
      }
      
      override tlf_internal function getEffectivePaddingLeft() : Number
      {
         if(computedFormat.paddingLeft != FormatValue.AUTO)
         {
            return computedFormat.paddingLeft;
         }
         var tf:TextFlow = getTextFlow();
         if(!tf || tf.computedFormat.blockProgression != BlockProgression.TB || computedFormat.direction != Direction.LTR)
         {
            return 0;
         }
         return computedFormat.listAutoPadding;
      }
      
      override tlf_internal function getEffectivePaddingRight() : Number
      {
         if(computedFormat.paddingRight != FormatValue.AUTO)
         {
            return computedFormat.paddingRight;
         }
         var tf:TextFlow = getTextFlow();
         if(!tf || tf.computedFormat.blockProgression != BlockProgression.TB || computedFormat.direction != Direction.RTL)
         {
            return 0;
         }
         return computedFormat.listAutoPadding;
      }
      
      override tlf_internal function getEffectivePaddingTop() : Number
      {
         if(computedFormat.paddingTop != FormatValue.AUTO)
         {
            return computedFormat.paddingTop;
         }
         var tf:TextFlow = getTextFlow();
         if(!tf || tf.computedFormat.blockProgression != BlockProgression.RL || computedFormat.direction != Direction.LTR)
         {
            return 0;
         }
         return computedFormat.listAutoPadding;
      }
      
      override tlf_internal function getEffectivePaddingBottom() : Number
      {
         if(computedFormat.paddingBottom != FormatValue.AUTO)
         {
            return computedFormat.paddingBottom;
         }
         var tf:TextFlow = getTextFlow();
         if(!tf || tf.computedFormat.blockProgression != BlockProgression.RL || computedFormat.direction != Direction.RTL)
         {
            return 0;
         }
         return computedFormat.listAutoPadding;
      }
      
      tlf_internal function computeListItemText(child:ListItemElement, listMarkerFormat:IListMarkerFormat) : String
      {
         var listStyleType:String = null;
         var rslt:String = null;
         var suffixOverride:String = null;
         var list:ListElement = null;
         var childListMarkerFormat:IListMarkerFormat = null;
         if(listMarkerFormat.content && listMarkerFormat.content.hasOwnProperty("counters"))
         {
            rslt = "";
            listStyleType = listMarkerFormat.content.ordered;
            suffixOverride = listMarkerFormat.content.suffix;
            list = this;
            childListMarkerFormat = listMarkerFormat;
            while(true)
            {
               rslt = list.computeListItemTextSpecified(child,childListMarkerFormat,listStyleType == null ? list.computedFormat.listStyleType : listStyleType,suffixOverride) + rslt;
               child = list.getParentByType(ListItemElement) as ListItemElement;
               if(!child)
               {
                  break;
               }
               list = child.parent as ListElement;
               childListMarkerFormat = child.computedListMarkerFormat();
            }
         }
         else
         {
            if(listMarkerFormat.content !== undefined)
            {
               if(listMarkerFormat.content == FormatValue.NONE)
               {
                  listStyleType = ListStyleType.NONE;
               }
               else
               {
                  listStyleType = listMarkerFormat.content.ordered;
               }
            }
            if(listStyleType == null)
            {
               listStyleType = computedFormat.listStyleType;
            }
            rslt = this.computeListItemTextSpecified(child,listMarkerFormat,listStyleType,null);
         }
         var beforeContent:String = !!listMarkerFormat.beforeContent ? listMarkerFormat.beforeContent : "";
         var afterContent:String = !!listMarkerFormat.afterContent ? listMarkerFormat.afterContent : "";
         return beforeContent + rslt + afterContent;
      }
      
      tlf_internal function computeListItemTextSpecified(child:ListItemElement, listMarkerFormat:IListMarkerFormat, listStyleType:String, suffixOverride:String) : String
      {
         var rslt:String = null;
         var n:int = 0;
         var f:Function = null;
         var val:* = tlf_internal::constantListStyles[listStyleType];
         if(val !== undefined)
         {
            rslt = val as String;
         }
         else
         {
            n = child.getListItemNumber(listMarkerFormat);
            f = tlf_internal::numericListStyles[listStyleType];
            if(f != null)
            {
               rslt = n < 0 ? "-" + f(-n) : f(n);
            }
            else if(n <= 0)
            {
               rslt = n == 0 ? "0" : "-" + decimalString(-n);
            }
            else
            {
               f = tlf_internal::alphabeticListStyles[listStyleType];
               if(f != null)
               {
                  rslt = f(n);
               }
               else
               {
                  rslt = tlf_internal::algorithmicListStyles[listStyleType](n);
               }
            }
            if(suffixOverride != null)
            {
               rslt += suffixOverride;
            }
            else if(listMarkerFormat.suffix != Suffix.NONE)
            {
               rslt += tlf_internal::listSuffixes[listStyleType];
            }
         }
         return rslt;
      }
      
      tlf_internal function isNumberedList() : Boolean
      {
         return tlf_internal::constantListStyles[computedFormat.listStyleType] === undefined;
      }
   }
}
