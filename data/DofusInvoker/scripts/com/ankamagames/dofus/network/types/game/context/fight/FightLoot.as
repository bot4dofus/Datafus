package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightLoot implements INetworkType
   {
      
      public static const protocolId:uint = 1192;
       
      
      public var objects:Vector.<uint>;
      
      public var kamas:Number = 0;
      
      private var _objectstree:FuncTree;
      
      public function FightLoot()
      {
         this.objects = new Vector.<uint>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 1192;
      }
      
      public function initFightLoot(objects:Vector.<uint> = null, kamas:Number = 0) : FightLoot
      {
         this.objects = objects;
         this.kamas = kamas;
         return this;
      }
      
      public function reset() : void
      {
         this.objects = new Vector.<uint>();
         this.kamas = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightLoot(output);
      }
      
      public function serializeAs_FightLoot(output:ICustomDataOutput) : void
      {
         output.writeShort(this.objects.length);
         for(var _i1:uint = 0; _i1 < this.objects.length; _i1++)
         {
            if(this.objects[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.objects[_i1] + ") on element 1 (starting at 1) of objects.");
            }
            output.writeVarInt(this.objects[_i1]);
         }
         if(this.kamas < 0 || this.kamas > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.kamas + ") on element kamas.");
         }
         output.writeVarLong(this.kamas);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightLoot(input);
      }
      
      public function deserializeAs_FightLoot(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _objectsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _objectsLen; _i1++)
         {
            _val1 = input.readVarUhInt();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of objects.");
            }
            this.objects.push(_val1);
         }
         this._kamasFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightLoot(tree);
      }
      
      public function deserializeAsyncAs_FightLoot(tree:FuncTree) : void
      {
         this._objectstree = tree.addChild(this._objectstreeFunc);
         tree.addChild(this._kamasFunc);
      }
      
      private function _objectstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._objectstree.addChild(this._objectsFunc);
         }
      }
      
      private function _objectsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of objects.");
         }
         this.objects.push(_val);
      }
      
      private function _kamasFunc(input:ICustomDataInput) : void
      {
         this.kamas = input.readVarUhLong();
         if(this.kamas < 0 || this.kamas > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.kamas + ") on element of FightLoot.kamas.");
         }
      }
   }
}
