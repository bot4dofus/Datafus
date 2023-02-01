package com.ankamagames.dofus.console.debug.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.events.Event;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.utils.ByteArray;
   
   public class ReccordNetworkPacketFrame implements Frame
   {
       
      
      private var _buffer:ByteArray;
      
      private var _msgCount:uint;
      
      public function ReccordNetworkPacketFrame()
      {
         super();
      }
      
      public function get reccordedMessageCount() : uint
      {
         return this._msgCount;
      }
      
      public function get priority() : int
      {
         return Priority.ULTIMATE_HIGHEST_DEPTH_OF_DOOM;
      }
      
      public function pushed() : Boolean
      {
         this._buffer = new ByteArray();
         this._msgCount = 0;
         return true;
      }
      
      public function pulled() : Boolean
      {
         var f:File = null;
         this._msgCount = 0;
         if(this._buffer.length)
         {
            f = File.desktopDirectory;
            f.addEventListener(Event.CANCEL,this.onFileSelectionCancel);
            f.addEventListener(Event.SELECT,this.onFileSelected);
            f.browseForSave("Save");
         }
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         if(msg is INetworkMessage)
         {
            INetworkMessage(msg).pack(new CustomDataWrapper(this._buffer));
            ++this._msgCount;
         }
         return false;
      }
      
      private function onFileSelected(e:Event) : void
      {
         File(e.target).removeEventListener(Event.CANCEL,this.onFileSelected);
         var fs:FileStream = new FileStream();
         fs.open(File(e.target),FileMode.WRITE);
         fs.writeBytes(this._buffer);
         fs.close();
         this._buffer = null;
      }
      
      private function onFileSelectionCancel(e:Event) : void
      {
         File(e.target).removeEventListener(Event.CANCEL,this.onFileSelectionCancel);
         this._buffer = null;
      }
   }
}
