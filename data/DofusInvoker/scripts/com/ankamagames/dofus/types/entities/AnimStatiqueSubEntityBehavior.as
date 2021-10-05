package com.ankamagames.dofus.types.entities
{
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.tiphon.types.BehaviorData;
   import com.ankamagames.tiphon.types.ISubEntityBehavior;
   
   public class AnimStatiqueSubEntityBehavior implements ISubEntityBehavior
   {
       
      
      private var _subentity:TiphonSprite;
      
      private var _parentData:BehaviorData;
      
      private var _animation:String;
      
      public function AnimStatiqueSubEntityBehavior()
      {
         super();
      }
      
      public function updateFromParentEntity(target:TiphonSprite, parentData:BehaviorData) : void
      {
         this._subentity = target;
         this._parentData = parentData;
         if(!this._animation || this._animation.indexOf(parentData.animation) == -1 && parentData.animation.indexOf(this._animation) == -1)
         {
            this._animation = parentData.animation.indexOf(this._subentity.getAnimation()) != -1 || this._subentity.getAnimation().indexOf(parentData.animation) != -1 ? this._subentity.getAnimation() : parentData.animation;
         }
         switch(true)
         {
            case this._parentData.animation.indexOf(AnimationEnum.ANIM_STATIQUE) != -1:
            case this._parentData.animation.indexOf(AnimationEnum.ANIM_HIT) != -1:
            case this._parentData.animation.indexOf(AnimationEnum.ANIM_ATTAQUE_BASE) != -1:
            case this._parentData.animation.indexOf(AnimationEnum.ANIM_MORT) != -1:
            case this._parentData.animation.indexOf("AnimEmote") != -1:
               if(!target.hasAnimation(parentData.animation,parentData.direction))
               {
                  this._animation = AnimationEnum.ANIM_STATIQUE;
               }
         }
         if(this._subentity && !this._subentity.hasAnimation(this._animation,this._parentData.direction))
         {
            this._animation = AnimationEnum.ANIM_STATIQUE;
         }
         parentData.parent.addEventListener(TiphonEvent.RENDER_FATHER_SUCCEED,this.onFatherRendered,false,0,true);
      }
      
      public function remove() : void
      {
         if(this._parentData)
         {
            this._parentData.parent.removeEventListener(TiphonEvent.RENDER_FATHER_SUCCEED,this.onFatherRendered);
         }
         this._subentity = null;
         this._parentData = null;
      }
      
      private function onFatherRendered(e:TiphonEvent) : void
      {
         var p:TiphonSprite = e.target as TiphonSprite;
         this._parentData.parent.removeEventListener(TiphonEvent.RENDER_FATHER_SUCCEED,this.onFatherRendered);
         this._subentity.setAnimationAndDirection(this._animation,this._parentData.direction);
      }
   }
}
