package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.network.types.game.character.guild.note.PlayerNote;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class GuildNoteWrapper
   {
      
      public static const MIN_EDIT_DELAY:Number = 30000;
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(GuildNoteWrapper));
       
      
      private var _text:String = "";
      
      private var _editDate:Number = 0;
      
      private var _playerId:Number = 0;
      
      public function GuildNoteWrapper(playerId:Number, text:String, editDate:Number)
      {
         super();
         this._playerId = playerId;
         this._text = text;
         this._editDate = editDate;
      }
      
      public static function wrap(playerId:Number, networkNote:PlayerNote) : GuildNoteWrapper
      {
         return new GuildNoteWrapper(playerId,networkNote.content,networkNote.lastEditDate);
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function get editDate() : Number
      {
         return this._editDate;
      }
      
      public function get playerId() : Number
      {
         return this._playerId;
      }
      
      public function get isEditable() : Boolean
      {
         return this._editDate === 0 || TimeManager.getInstance().getUtcTimestamp() - this._editDate >= MIN_EDIT_DELAY;
      }
      
      public function unwrap() : PlayerNote
      {
         var protocolNote:PlayerNote = new PlayerNote();
         protocolNote.initPlayerNote(this._text,this._editDate);
         return protocolNote;
      }
      
      public function toString() : String
      {
         return "GuildNote[Player ID: " + this._playerId + ", edit date: " + this._editDate + ", text: " + this._text + "]";
      }
      
      public function edit(text:String) : void
      {
         if(!this.isEditable)
         {
            _log.error(this.toString() + " is not editable");
            return;
         }
         this._text = text;
         this._editDate = TimeManager.getInstance().getUtcTimestamp();
         if(this._text === null)
         {
            this._text = "";
         }
      }
   }
}
