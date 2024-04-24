package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ObjectEffects implements INetworkType
   {
      
      public static const protocolId:uint = 5223;
       
      
      public var effects:Vector.<ObjectEffect>;
      
      private var _effectstree:FuncTree;
      
      public function ObjectEffects()
      {
         this.effects = new Vector.<ObjectEffect>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 5223;
      }
      
      public function initObjectEffects(effects:Vector.<ObjectEffect> = null) : ObjectEffects
      {
         this.effects = effects;
         return this;
      }
      
      public function reset() : void
      {
         this.effects = new Vector.<ObjectEffect>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectEffects(output);
      }
      
      public function serializeAs_ObjectEffects(output:ICustomDataOutput) : void
      {
         output.writeShort(this.effects.length);
         for(var _i1:uint = 0; _i1 < this.effects.length; _i1++)
         {
            output.writeShort((this.effects[_i1] as ObjectEffect).getTypeId());
            (this.effects[_i1] as ObjectEffect).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectEffects(input);
      }
      
      public function deserializeAs_ObjectEffects(input:ICustomDataInput) : void
      {
         var _id1:uint = 0;
         var _item1:ObjectEffect = null;
         var _effectsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _effectsLen; _i1++)
         {
            _id1 = input.readUnsignedShort();
            _item1 = ProtocolTypeManager.getInstance(ObjectEffect,_id1);
            _item1.deserialize(input);
            this.effects.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectEffects(tree);
      }
      
      public function deserializeAsyncAs_ObjectEffects(tree:FuncTree) : void
      {
         this._effectstree = tree.addChild(this._effectstreeFunc);
      }
      
      private function _effectstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._effectstree.addChild(this._effectsFunc);
         }
      }
      
      private function _effectsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:ObjectEffect = ProtocolTypeManager.getInstance(ObjectEffect,_id);
         _item.deserialize(input);
         this.effects.push(_item);
      }
   }
}
