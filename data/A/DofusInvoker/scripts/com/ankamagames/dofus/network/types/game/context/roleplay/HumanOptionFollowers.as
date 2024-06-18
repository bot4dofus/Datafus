package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.look.IndexedEntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class HumanOptionFollowers extends HumanOption implements INetworkType
   {
      
      public static const protocolId:uint = 8287;
       
      
      public var followingCharactersLook:Vector.<IndexedEntityLook>;
      
      private var _followingCharactersLooktree:FuncTree;
      
      public function HumanOptionFollowers()
      {
         this.followingCharactersLook = new Vector.<IndexedEntityLook>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8287;
      }
      
      public function initHumanOptionFollowers(followingCharactersLook:Vector.<IndexedEntityLook> = null) : HumanOptionFollowers
      {
         this.followingCharactersLook = followingCharactersLook;
         return this;
      }
      
      override public function reset() : void
      {
         this.followingCharactersLook = new Vector.<IndexedEntityLook>();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_HumanOptionFollowers(output);
      }
      
      public function serializeAs_HumanOptionFollowers(output:ICustomDataOutput) : void
      {
         super.serializeAs_HumanOption(output);
         output.writeShort(this.followingCharactersLook.length);
         for(var _i1:uint = 0; _i1 < this.followingCharactersLook.length; _i1++)
         {
            (this.followingCharactersLook[_i1] as IndexedEntityLook).serializeAs_IndexedEntityLook(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HumanOptionFollowers(input);
      }
      
      public function deserializeAs_HumanOptionFollowers(input:ICustomDataInput) : void
      {
         var _item1:IndexedEntityLook = null;
         super.deserialize(input);
         var _followingCharactersLookLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _followingCharactersLookLen; _i1++)
         {
            _item1 = new IndexedEntityLook();
            _item1.deserialize(input);
            this.followingCharactersLook.push(_item1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HumanOptionFollowers(tree);
      }
      
      public function deserializeAsyncAs_HumanOptionFollowers(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._followingCharactersLooktree = tree.addChild(this._followingCharactersLooktreeFunc);
      }
      
      private function _followingCharactersLooktreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._followingCharactersLooktree.addChild(this._followingCharactersLookFunc);
         }
      }
      
      private function _followingCharactersLookFunc(input:ICustomDataInput) : void
      {
         var _item:IndexedEntityLook = new IndexedEntityLook();
         _item.deserialize(input);
         this.followingCharactersLook.push(_item);
      }
   }
}
