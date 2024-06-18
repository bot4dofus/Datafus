package com.ankamagames.dofus.network.messages.game.tinsel
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TitlesAndOrnamentsListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3749;
       
      
      private var _isInitialized:Boolean = false;
      
      public var titles:Vector.<uint>;
      
      public var ornaments:Vector.<uint>;
      
      public var activeTitle:uint = 0;
      
      public var activeOrnament:uint = 0;
      
      private var _titlestree:FuncTree;
      
      private var _ornamentstree:FuncTree;
      
      public function TitlesAndOrnamentsListMessage()
      {
         this.titles = new Vector.<uint>();
         this.ornaments = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3749;
      }
      
      public function initTitlesAndOrnamentsListMessage(titles:Vector.<uint> = null, ornaments:Vector.<uint> = null, activeTitle:uint = 0, activeOrnament:uint = 0) : TitlesAndOrnamentsListMessage
      {
         this.titles = titles;
         this.ornaments = ornaments;
         this.activeTitle = activeTitle;
         this.activeOrnament = activeOrnament;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.titles = new Vector.<uint>();
         this.ornaments = new Vector.<uint>();
         this.activeTitle = 0;
         this.activeOrnament = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:ICustomDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      override public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         var tree:FuncTree = new FuncTree();
         tree.setRoot(input);
         this.deserializeAsync(tree);
         return tree;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_TitlesAndOrnamentsListMessage(output);
      }
      
      public function serializeAs_TitlesAndOrnamentsListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.titles.length);
         for(var _i1:uint = 0; _i1 < this.titles.length; _i1++)
         {
            if(this.titles[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.titles[_i1] + ") on element 1 (starting at 1) of titles.");
            }
            output.writeVarShort(this.titles[_i1]);
         }
         output.writeShort(this.ornaments.length);
         for(var _i2:uint = 0; _i2 < this.ornaments.length; _i2++)
         {
            if(this.ornaments[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.ornaments[_i2] + ") on element 2 (starting at 1) of ornaments.");
            }
            output.writeVarShort(this.ornaments[_i2]);
         }
         if(this.activeTitle < 0)
         {
            throw new Error("Forbidden value (" + this.activeTitle + ") on element activeTitle.");
         }
         output.writeVarShort(this.activeTitle);
         if(this.activeOrnament < 0)
         {
            throw new Error("Forbidden value (" + this.activeOrnament + ") on element activeOrnament.");
         }
         output.writeVarShort(this.activeOrnament);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TitlesAndOrnamentsListMessage(input);
      }
      
      public function deserializeAs_TitlesAndOrnamentsListMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _val2:uint = 0;
         var _titlesLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _titlesLen; _i1++)
         {
            _val1 = input.readVarUhShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of titles.");
            }
            this.titles.push(_val1);
         }
         var _ornamentsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _ornamentsLen; _i2++)
         {
            _val2 = input.readVarUhShort();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of ornaments.");
            }
            this.ornaments.push(_val2);
         }
         this._activeTitleFunc(input);
         this._activeOrnamentFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TitlesAndOrnamentsListMessage(tree);
      }
      
      public function deserializeAsyncAs_TitlesAndOrnamentsListMessage(tree:FuncTree) : void
      {
         this._titlestree = tree.addChild(this._titlestreeFunc);
         this._ornamentstree = tree.addChild(this._ornamentstreeFunc);
         tree.addChild(this._activeTitleFunc);
         tree.addChild(this._activeOrnamentFunc);
      }
      
      private function _titlestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._titlestree.addChild(this._titlesFunc);
         }
      }
      
      private function _titlesFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of titles.");
         }
         this.titles.push(_val);
      }
      
      private function _ornamentstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._ornamentstree.addChild(this._ornamentsFunc);
         }
      }
      
      private function _ornamentsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of ornaments.");
         }
         this.ornaments.push(_val);
      }
      
      private function _activeTitleFunc(input:ICustomDataInput) : void
      {
         this.activeTitle = input.readVarUhShort();
         if(this.activeTitle < 0)
         {
            throw new Error("Forbidden value (" + this.activeTitle + ") on element of TitlesAndOrnamentsListMessage.activeTitle.");
         }
      }
      
      private function _activeOrnamentFunc(input:ICustomDataInput) : void
      {
         this.activeOrnament = input.readVarUhShort();
         if(this.activeOrnament < 0)
         {
            throw new Error("Forbidden value (" + this.activeOrnament + ") on element of TitlesAndOrnamentsListMessage.activeOrnament.");
         }
      }
   }
}
