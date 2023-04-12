package com.ankamagames.jerakine.json
{
   public class JSONDecoder
   {
       
      
      protected var strict:Boolean;
      
      protected var value;
      
      protected var tokenizer:JSONTokenizer;
      
      protected var token:JSONToken;
      
      public function JSONDecoder(s:String, strict:Boolean)
      {
         super();
         this.init(s,strict);
      }
      
      protected function init(s:String, strict:Boolean) : void
      {
         this.strict = strict;
         this.tokenizer = new JSONTokenizer(s,strict);
         this.nextToken();
         if(this.token)
         {
            this.value = this.parseValue();
         }
         if(strict && this.nextToken() != null)
         {
            this.tokenizer.parseError("Unexpected characters left in input stream");
         }
      }
      
      public function getValue() : *
      {
         return this.value;
      }
      
      private function nextToken() : JSONToken
      {
         return this.token = this.tokenizer.getNextToken();
      }
      
      private function parseArray() : Array
      {
         var result:Array = [];
         this.nextToken();
         if(this.token.type == JSONTokenType.RIGHT_BRACKET)
         {
            return result;
         }
         if(!this.strict && this.token.type == JSONTokenType.COMMA)
         {
            this.nextToken();
            if(this.token.type == JSONTokenType.RIGHT_BRACKET)
            {
               return result;
            }
            this.tokenizer.parseError("Leading commas are not supported.  Expecting \']\' but found " + this.token.value);
         }
         while(true)
         {
            result.push(this.parseValue());
            this.nextToken();
            if(this.token.type == JSONTokenType.RIGHT_BRACKET)
            {
               break;
            }
            if(this.token.type == JSONTokenType.COMMA)
            {
               this.nextToken();
               if(!this.strict)
               {
                  if(this.token.type == JSONTokenType.RIGHT_BRACKET)
                  {
                     break;
                  }
               }
            }
            else
            {
               this.tokenizer.parseError("Expecting ] or , but found " + this.token.value);
            }
         }
         return result;
      }
      
      private function parseObject() : Object
      {
         var key:String = null;
         var result:Object = {};
         this.nextToken();
         if(this.token.type == JSONTokenType.RIGHT_BRACE)
         {
            return result;
         }
         if(!this.strict && this.token.type == JSONTokenType.COMMA)
         {
            this.nextToken();
            if(this.token.type == JSONTokenType.RIGHT_BRACE)
            {
               return result;
            }
            this.tokenizer.parseError("Leading commas are not supported.  Expecting \'}\' but found " + this.token.value);
         }
         while(true)
         {
            if(this.token.type == JSONTokenType.STRING)
            {
               key = String(this.token.value);
               this.nextToken();
               if(this.token.type == JSONTokenType.COLON)
               {
                  this.nextToken();
                  result[key] = this.parseValue();
                  this.nextToken();
                  if(this.token.type == JSONTokenType.RIGHT_BRACE)
                  {
                     break;
                  }
                  if(this.token.type == JSONTokenType.COMMA)
                  {
                     this.nextToken();
                     if(!this.strict)
                     {
                        if(this.token.type == JSONTokenType.RIGHT_BRACE)
                        {
                           break;
                        }
                     }
                  }
                  else
                  {
                     this.tokenizer.parseError("Expecting } or , but found " + this.token.value);
                  }
               }
               else
               {
                  this.tokenizer.parseError("Expecting : but found " + this.token.value);
               }
            }
            else
            {
               this.tokenizer.parseError("Expecting string but found " + this.token.value);
            }
         }
         return result;
      }
      
      private function parseValue() : Object
      {
         if(this.token == null)
         {
            this.tokenizer.parseError("Unexpected end of input");
         }
         switch(this.token.type)
         {
            case JSONTokenType.LEFT_BRACE:
               return this.parseObject();
            case JSONTokenType.LEFT_BRACKET:
               return this.parseArray();
            case JSONTokenType.STRING:
            case JSONTokenType.NUMBER:
            case JSONTokenType.TRUE:
            case JSONTokenType.FALSE:
            case JSONTokenType.NULL:
               return this.token.value;
            case JSONTokenType.NAN:
               if(!this.strict)
               {
                  return this.token.value;
               }
               this.tokenizer.parseError("Unexpected " + this.token.value);
               break;
         }
         this.tokenizer.parseError("Unexpected " + this.token.value);
         return null;
      }
   }
}
