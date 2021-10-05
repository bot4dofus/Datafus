package com.ankamagames.jerakine.utils.pattern
{
   public class PatternDecoder
   {
       
      
      public function PatternDecoder()
      {
         super();
      }
      
      public static function getDescription(sText:String, aParams:Array) : String
      {
         return decodeDescription(sText,aParams);
      }
      
      public static function combine(str:String, gender:String, singular:Boolean, zero:Boolean = false) : String
      {
         if(!str)
         {
            return "";
         }
         var oParams:Object = {
            "m":gender == "m",
            "f":gender == "f",
            "n":gender == "n",
            "z":zero && str.indexOf("~z") != -1,
            "p":!singular && !zero,
            "s":singular && !zero
         };
         return decodeCombine(str,oParams);
      }
      
      public static function decode(str:String, params:Array) : String
      {
         if(!str)
         {
            return "";
         }
         return decodeCombine(str,params);
      }
      
      public static function replace(sSrc:String, sPattern:String) : String
      {
         var aTmp2:Array = null;
         var aTmp:Array = sSrc.split("##");
         for(var i:uint = 1; i < aTmp.length; i += 2)
         {
            aTmp2 = aTmp[i].split(",");
            aTmp[i] = getDescription(sPattern,aTmp2);
         }
         return aTmp.join("");
      }
      
      public static function replaceStr(sSrc:String, sSearchPattern:String, sReplaceStr:String) : String
      {
         return sSrc.split(sSearchPattern).join(sReplaceStr);
      }
      
      private static function findOptionnalDices(aStr:String, aParams:Array) : String
      {
         var aStrCopyFirstPart:String = null;
         var aStrCopySecondPart:String = null;
         var nBlancDebut:uint = 0;
         var nBlancFin:uint = 0;
         var returnValue:String = aStr;
         var posAcc1:int = aStr.indexOf("{");
         var posAcc2:int = aStr.indexOf("}");
         if(posAcc1 >= 0 && posAcc2 > posAcc1)
         {
            nBlancDebut = 0;
            while(aStr.charAt(posAcc1 - (nBlancDebut + 1)) == " ")
            {
               nBlancDebut++;
            }
            nBlancFin = 0;
            while(aStr.charAt(posAcc2 + (nBlancFin + 1)) == " ")
            {
               nBlancFin++;
            }
            aStrCopyFirstPart = aStr.substring(0,posAcc1 - (2 + nBlancDebut));
            aStrCopySecondPart = aStr.substring(posAcc2 - posAcc1 + 5 + nBlancFin + nBlancDebut,aStr.length - (posAcc2 - posAcc1));
            if(aStr.charAt(0) == "#" && aStr.charAt(aStr.length - 2) == "#")
            {
               if(aParams[1] == null && aParams[2] == null && aParams[3] == null)
               {
                  aStrCopyFirstPart += aParams[0];
               }
               else if(aParams[0] == 0 && aParams[1] == 0)
               {
                  aStrCopyFirstPart += aParams[2];
               }
               else if(!aParams[2])
               {
                  aStr = aStr.substring(0,aStr.indexOf("#")) + aParams[0] + aStr.substring(aStr.indexOf("{") + 5,aStr.indexOf("}")) + aParams[1] + aStr.substring(aStr.indexOf("#",aStr.indexOf("}")));
                  aStrCopyFirstPart += aStr;
               }
               else
               {
                  aStr = aStr.substring(0,aStr.indexOf("#")) + (aParams[0] + aParams[2]) + aStr.substring(aStr.indexOf("{") + 5,aStr.indexOf("}")) + (aParams[0] * aParams[1] + aParams[2]) + aStr.substring(aStr.indexOf("#",aStr.indexOf("}")));
                  aStrCopyFirstPart += aStr;
               }
               returnValue = aStrCopyFirstPart + aStrCopySecondPart;
            }
         }
         return returnValue;
      }
      
      private static function decodeDescription(aStr:String, aParams:Array) : String
      {
         var nextSharp:int = 0;
         var nextTilde:int = 0;
         var nextBrace:int = 0;
         var nextBracket:int = 0;
         var n:Number = NaN;
         var oldLength:Number = NaN;
         var n1:Number = NaN;
         var pos:int = 0;
         var rstr:String = null;
         var pos2:int = 0;
         var n2:Number = NaN;
         aStr = findOptionnalDices(aStr,aParams);
         var actualIndex:int = 0;
         while(true)
         {
            nextSharp = aStr.indexOf("#",actualIndex);
            nextTilde = aStr.indexOf("~",actualIndex);
            nextBrace = aStr.indexOf("{",actualIndex);
            nextBracket = aStr.indexOf("[",actualIndex);
            if(nextSharp != -1 && (nextTilde == -1 || nextSharp < nextTilde) && (nextBrace == -1 || nextSharp < nextBrace) && (nextBracket == -1 || nextSharp < nextBracket))
            {
               n = parseInt(aStr.charAt(nextSharp + 1));
               oldLength = aStr.length;
               if(!isNaN(n))
               {
                  if(aParams[n - 1] != undefined)
                  {
                     aStr = aStr.substring(0,nextSharp) + aParams[n - 1] + aStr.substring(nextSharp + 2);
                  }
                  else
                  {
                     aStr = aStr.substring(0,nextSharp) + aStr.substring(nextSharp + 2);
                  }
               }
               actualIndex = nextSharp + aStr.length - oldLength;
            }
            else if(nextTilde != -1 && (nextBrace == -1 || nextTilde < nextBrace) && (nextBracket == -1 || nextTilde < nextBracket))
            {
               n1 = parseInt(aStr.charAt(nextTilde + 1));
               if(isNaN(n1))
               {
                  break;
               }
               if(aParams[n1 - 1] == null)
               {
                  return aStr.substring(0,nextTilde);
               }
               aStr = aStr.substring(0,nextTilde) + aStr.substring(nextTilde + 2);
               actualIndex = nextTilde;
            }
            else if(nextBrace != -1 && (nextBracket == -1 || nextBrace < nextBracket))
            {
               pos = aStr.indexOf("}",nextBrace);
               rstr = decodeDescription(aStr.substring(nextBrace + 1,pos),aParams);
               aStr = aStr.substring(0,nextBrace) + rstr + aStr.substring(pos + 1);
               actualIndex = nextBrace;
            }
            else if(nextBracket != -1)
            {
               pos2 = aStr.indexOf("]",nextBracket);
               n2 = Number(aStr.substring(nextBracket + 1,pos2));
               if(!isNaN(n2))
               {
                  aStr = aStr.substring(0,nextBracket) + aParams[n2] + " " + aStr.substring(pos2 + 1);
               }
               actualIndex = nextBracket;
            }
            if(!(nextSharp != -1 || nextTilde != -1 || nextBrace != -1 || nextBracket != -1))
            {
               return aStr;
            }
         }
         if(aParams.length > 5)
         {
            return combine(aStr,aParams[5],aParams[6],aParams[7]);
         }
         return "";
      }
      
      private static function decodeCombine(aStr:String, oParams:Object) : String
      {
         var nextTilde:int = 0;
         var nextBrace:int = 0;
         var key:String = null;
         var pos:int = 0;
         var content:String = null;
         var twoDotsPos:int = 0;
         var rstr:String = null;
         var actualIndex:int = 0;
         while(true)
         {
            nextTilde = aStr.indexOf("~",actualIndex);
            nextBrace = aStr.indexOf("{",actualIndex);
            if(nextTilde != -1 && (nextBrace == -1 || nextTilde < nextBrace))
            {
               key = aStr.charAt(nextTilde + 1);
               if(!oParams[key])
               {
                  break;
               }
               aStr = aStr.substring(0,nextTilde) + aStr.substring(nextTilde + 2);
               actualIndex = nextTilde;
            }
            else if(nextBrace != -1)
            {
               pos = aStr.indexOf("}",nextBrace);
               content = aStr.substring(nextBrace + 1,pos);
               twoDotsPos = -1;
               if(pos > -1)
               {
                  twoDotsPos = content.indexOf(":");
               }
               if((twoDotsPos == -1 || twoDotsPos + 1 > content.length || content.charAt(twoDotsPos + 1) != ":") && content.indexOf("~") != -1)
               {
                  rstr = decodeCombine(content,oParams);
                  if(content != rstr)
                  {
                     aStr = aStr.substring(0,nextBrace) + rstr + aStr.substring(pos + 1);
                  }
                  actualIndex = nextBrace;
               }
               else
               {
                  actualIndex = pos;
               }
            }
            if(!(nextTilde != -1 || nextBrace != -1))
            {
               return aStr;
            }
         }
         return aStr.substring(0,nextTilde);
      }
   }
}
