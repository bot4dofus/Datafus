package com.ankamagames.jerakine.console
{
   import com.ankamagames.jerakine.messages.Message;
   
   public class ConsoleInstructionMessage implements Message
   {
       
      
      private var _cmd:String;
      
      private var _args:Array;
      
      private var _localCmd:Boolean;
      
      public function ConsoleInstructionMessage(cmd:String, args:Array)
      {
         super();
         this._localCmd = cmd.charAt(0) == "/";
         this._cmd = cmd.toLocaleLowerCase();
         if(this._localCmd)
         {
            this._cmd = this._cmd.substr(1);
         }
         this._args = args;
      }
      
      public function get cmd() : String
      {
         return this._cmd;
      }
      
      public function get completCmd() : String
      {
         return (!!this._localCmd ? "/" : "") + this._cmd;
      }
      
      public function get args() : Array
      {
         return this._args;
      }
      
      public function get isLocalCmd() : Boolean
      {
         return this._localCmd;
      }
      
      public function equals(cim:ConsoleInstructionMessage) : Boolean
      {
         var result:Boolean = false;
         var i:uint = 0;
         result = cim.completCmd == this.completCmd && this.args.length == cim.args.length;
         if(result)
         {
            for(i = 0; i < this.args.length; i++)
            {
               result = result && this.args[i] == cim.args[i];
            }
         }
         return result;
      }
   }
}
