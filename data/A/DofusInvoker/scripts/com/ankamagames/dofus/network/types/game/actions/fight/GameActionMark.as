package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameActionMark implements INetworkType
   {
      
      public static const protocolId:uint = 8022;
       
      
      public var markAuthorId:Number = 0;
      
      public var markTeamId:uint = 2;
      
      public var markSpellId:uint = 0;
      
      public var markSpellLevel:int = 0;
      
      public var markId:int = 0;
      
      public var markType:int = 0;
      
      public var markimpactCell:int = 0;
      
      public var cells:Vector.<GameActionMarkedCell>;
      
      public var active:Boolean = false;
      
      private var _cellstree:FuncTree;
      
      public function GameActionMark()
      {
         this.cells = new Vector.<GameActionMarkedCell>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 8022;
      }
      
      public function initGameActionMark(markAuthorId:Number = 0, markTeamId:uint = 2, markSpellId:uint = 0, markSpellLevel:int = 0, markId:int = 0, markType:int = 0, markimpactCell:int = 0, cells:Vector.<GameActionMarkedCell> = null, active:Boolean = false) : GameActionMark
      {
         this.markAuthorId = markAuthorId;
         this.markTeamId = markTeamId;
         this.markSpellId = markSpellId;
         this.markSpellLevel = markSpellLevel;
         this.markId = markId;
         this.markType = markType;
         this.markimpactCell = markimpactCell;
         this.cells = cells;
         this.active = active;
         return this;
      }
      
      public function reset() : void
      {
         this.markAuthorId = 0;
         this.markTeamId = 2;
         this.markSpellId = 0;
         this.markSpellLevel = 0;
         this.markId = 0;
         this.markType = 0;
         this.markimpactCell = 0;
         this.cells = new Vector.<GameActionMarkedCell>();
         this.active = false;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameActionMark(output);
      }
      
      public function serializeAs_GameActionMark(output:ICustomDataOutput) : void
      {
         if(this.markAuthorId < -9007199254740992 || this.markAuthorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.markAuthorId + ") on element markAuthorId.");
         }
         output.writeDouble(this.markAuthorId);
         output.writeByte(this.markTeamId);
         if(this.markSpellId < 0)
         {
            throw new Error("Forbidden value (" + this.markSpellId + ") on element markSpellId.");
         }
         output.writeInt(this.markSpellId);
         if(this.markSpellLevel < 1 || this.markSpellLevel > 32767)
         {
            throw new Error("Forbidden value (" + this.markSpellLevel + ") on element markSpellLevel.");
         }
         output.writeShort(this.markSpellLevel);
         output.writeShort(this.markId);
         output.writeByte(this.markType);
         if(this.markimpactCell < -1 || this.markimpactCell > 559)
         {
            throw new Error("Forbidden value (" + this.markimpactCell + ") on element markimpactCell.");
         }
         output.writeShort(this.markimpactCell);
         output.writeShort(this.cells.length);
         for(var _i8:uint = 0; _i8 < this.cells.length; _i8++)
         {
            (this.cells[_i8] as GameActionMarkedCell).serializeAs_GameActionMarkedCell(output);
         }
         output.writeBoolean(this.active);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionMark(input);
      }
      
      public function deserializeAs_GameActionMark(input:ICustomDataInput) : void
      {
         var _item8:GameActionMarkedCell = null;
         this._markAuthorIdFunc(input);
         this._markTeamIdFunc(input);
         this._markSpellIdFunc(input);
         this._markSpellLevelFunc(input);
         this._markIdFunc(input);
         this._markTypeFunc(input);
         this._markimpactCellFunc(input);
         var _cellsLen:uint = input.readUnsignedShort();
         for(var _i8:uint = 0; _i8 < _cellsLen; _i8++)
         {
            _item8 = new GameActionMarkedCell();
            _item8.deserialize(input);
            this.cells.push(_item8);
         }
         this._activeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionMark(tree);
      }
      
      public function deserializeAsyncAs_GameActionMark(tree:FuncTree) : void
      {
         tree.addChild(this._markAuthorIdFunc);
         tree.addChild(this._markTeamIdFunc);
         tree.addChild(this._markSpellIdFunc);
         tree.addChild(this._markSpellLevelFunc);
         tree.addChild(this._markIdFunc);
         tree.addChild(this._markTypeFunc);
         tree.addChild(this._markimpactCellFunc);
         this._cellstree = tree.addChild(this._cellstreeFunc);
         tree.addChild(this._activeFunc);
      }
      
      private function _markAuthorIdFunc(input:ICustomDataInput) : void
      {
         this.markAuthorId = input.readDouble();
         if(this.markAuthorId < -9007199254740992 || this.markAuthorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.markAuthorId + ") on element of GameActionMark.markAuthorId.");
         }
      }
      
      private function _markTeamIdFunc(input:ICustomDataInput) : void
      {
         this.markTeamId = input.readByte();
         if(this.markTeamId < 0)
         {
            throw new Error("Forbidden value (" + this.markTeamId + ") on element of GameActionMark.markTeamId.");
         }
      }
      
      private function _markSpellIdFunc(input:ICustomDataInput) : void
      {
         this.markSpellId = input.readInt();
         if(this.markSpellId < 0)
         {
            throw new Error("Forbidden value (" + this.markSpellId + ") on element of GameActionMark.markSpellId.");
         }
      }
      
      private function _markSpellLevelFunc(input:ICustomDataInput) : void
      {
         this.markSpellLevel = input.readShort();
         if(this.markSpellLevel < 1 || this.markSpellLevel > 32767)
         {
            throw new Error("Forbidden value (" + this.markSpellLevel + ") on element of GameActionMark.markSpellLevel.");
         }
      }
      
      private function _markIdFunc(input:ICustomDataInput) : void
      {
         this.markId = input.readShort();
      }
      
      private function _markTypeFunc(input:ICustomDataInput) : void
      {
         this.markType = input.readByte();
      }
      
      private function _markimpactCellFunc(input:ICustomDataInput) : void
      {
         this.markimpactCell = input.readShort();
         if(this.markimpactCell < -1 || this.markimpactCell > 559)
         {
            throw new Error("Forbidden value (" + this.markimpactCell + ") on element of GameActionMark.markimpactCell.");
         }
      }
      
      private function _cellstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._cellstree.addChild(this._cellsFunc);
         }
      }
      
      private function _cellsFunc(input:ICustomDataInput) : void
      {
         var _item:GameActionMarkedCell = new GameActionMarkedCell();
         _item.deserialize(input);
         this.cells.push(_item);
      }
      
      private function _activeFunc(input:ICustomDataInput) : void
      {
         this.active = input.readBoolean();
      }
   }
}
