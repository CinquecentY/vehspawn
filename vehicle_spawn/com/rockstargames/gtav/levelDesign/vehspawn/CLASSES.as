class com.rockstargames.gtav.levelDesign.vehspawn.CLASSES extends com.rockstargames.gtav.levelDesign.vehspawn.Screen
{
      static var SCROLL_SPEED = 20;
   function CLASSES(app, viewContainer, cursor)
   {
      super(app,viewContainer,cursor,"CLASSES");
      this.init();
   }
   function init()
   {
      this.scrollTimeDelta = 0;
      this.app.SET_MOUSE_INPUT(0.605,0.57);
      this.view._visible = true;
      this.initList();
      this.closeButton = new com.rockstargames.gtav.levelDesign.vehspawn.Button(com.rockstargames.gtav.levelDesign.vehspawn.CLASSES.CLOSE,this.view.closeBtn);
      this.updateButtons();
   }
   function __get__isReady()
   {
      return true;
   }
   function initList()
   {
      var list = this.view.createEmptyMovieClip("list",this.view.getNextHighestDepth());
      list._x = this.view.listMask._x;
      list._y = this.view.listMask._y;
      list.setMask(this.view.listMask);
      var col = 4;
      var width = 280;
      var height = 250;
      for (i=0;i < this.app.vehclassList.length;i++)
      {
         var card = this.app.vehclassList[i];
         var cardView = list.attachMovie("card",card.get_id(),list.getNextHighestDepth());
         cardView._x = i % col * width;
         cardView._y = Math.floor(i / col) * height;
         this.initListItem(cardView,card);
      }
      if(this.view.listMask._height > list._height)
      {
         this.view.listMask._height = list._height;
         /*var _loc9_ = list._y + list._height + 16;
         this.view.panelBG._height = _loc9_ - this.view.panelBG._y;*/
      }
   }
   function initListItem(view, card)
   {
      this.app.imageManager.addImage("veh_img"+card.get_txd(),card.get_vehname(),view.image);
      view.label.text = card.label;
      card.view = view;
      card.button = new com.rockstargames.gtav.levelDesign.vehspawn.Button(card.get_id(),view);
   }
   
   function handleButtonInput(inputID)
   {
      switch(inputID)
      {
         case com.rockstargames.gtav.levelDesign.VEHICLE_SPAWN.ACCEPT:
         case com.rockstargames.gtav.levelDesign.VEHICLE_SPAWN.LEFT_MOUSE:
         var currentSelection = this.app.GET_CURRENT_SELECTION();
         if(currentSelection != -1)
            com.rockstargames.gtav.levelDesign.VEHICLE_SPAWN.playSound("Type_Enter");
         break;
         case com.rockstargames.gtav.levelDesign.VEHICLE_SPAWN.KEY_UP:
            this.activeScrollKey = com.rockstargames.gtav.levelDesign.VEHICLE_SPAWN.KEY_UP;
            this.scrollListFromKeyboard(-1);
            break;
         case com.rockstargames.gtav.levelDesign.VEHICLE_SPAWN.KEY_DOWN:
            this.activeScrollKey = com.rockstargames.gtav.levelDesign.VEHICLE_SPAWN.KEY_DOWN;
            this.scrollListFromKeyboard(1);
            break;
      }
   }
   
   function updateButtons()
   {
      var buttons = [];
      for (i=0;i < this.app.vehclassList.length;i++)
      {
         var view = this.app.vehclassList[i].view;
         var button = this.app.vehclassList[i].button;
         button.top = Math.max(this.view.listMask._y,view._y + view._parent._y);
         button.bottom = Math.min(this.view.listMask._y + this.view.listMask._height,view._y + view._height + view._parent._y);
         if(button.bottom - button.top > 0)
         {
            buttons.push(button);
         }
      }
      buttons.push(this.closeButton);
      this.cursor.setTargetRects(buttons);
   }
   function dispose()
   {
      com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf(this.view);
      super.dispose();
   }

   function handleMouseScrollInput(y)
   {
      var _loc4_ = (y - 130) / 130;
      _loc4_ *= 2;
      var _loc5_ = getTimer();
      var _loc3_ = _loc5_ - this.scrollTimeDelta;
      _loc3_ = Math.max(16,Math.min(40,_loc3_));
      var _loc6_ = com.rockstargames.gtav.levelDesign.vehspawn.CLASSES.SCROLL_SPEED * _loc3_ / 32;
      this.scrollTimeDelta = _loc5_;
      this.scrollList((- _loc6_) * _loc4_);
      if(y != 127)
      {
         y += 0.17 * (127 - y);
         if(Math.abs(y - 127) < 1)
         {
            y = 127;
         }
         //this.view.onEnterFrame = this.delegate(this,this.handleMouseScrollInput(y,true));
      }
      else if(isSlowingDown)
      {
         delete this.view.onEnterFrame;
      }
   }

   function scrollListFromKeyboard(direction)
   {
      var _loc3_ = getTimer();
      var _loc2_ = _loc3_ - this.scrollTimeDelta;
      _loc2_ = Math.max(16,Math.min(40,_loc2_));
      var _loc4_ = com.rockstargames.gtav.levelDesign.vehspawn.CLASSES.SCROLL_SPEED * _loc2_ / 32;
      this.scrollTimeDelta = _loc3_;
      this.scrollList((- _loc4_) * direction);
      //this.view.onEnterFrame = this.delegate(this,this.scrollListFromKeyboard,direction);
   }
   function scrollList(dy)
   {
      this.app.CONTENT.dummy.htmlText = dy;
      var _loc2_ = this.view.listMask._y;
      var _loc3_ = this.view.listMask._y + this.view.listMask._height - this.view.list._height;
      var _loc4_ = this.view.list._y + dy;
      if(this.view.list._height > this.view.listMask._height)
      {
         this.view.list._y = Math.max(Math.min(_loc2_,_loc4_),_loc3_);
      }
      this.updateButtons();
      this.updateScrollbar();
   }
   function resetScroll()
   {
      this.view.list._y = this.view.listMask._y;
      this.updateScrollbar();
   }
   function updateScrollbar()
   {
      var _loc2_ = this.view.listMask._y;
      var _loc3_ = this.view.listMask._y + this.view.listMask._height;
      var _loc4_ = this.view.listMask._y + this.view.listMask._height - this.view.list._height;
      var _loc7_ = this.view.listMask._y;
      var _loc6_ = (this.view.list._y - _loc4_) / (_loc7_ - _loc4_);
      var _loc8_ = Math.min(_loc2_ + this.view.listMask._height,this.view.list._y + this.view.list._height);
      var _loc9_ = Math.min(1,(_loc8_ - _loc2_) / this.view.list._height);
      this.view.scrollbar._height = _loc9_ * (_loc3_ - _loc2_);
      var _loc5_ = _loc3_ - this.view.scrollbar._height;
      this.view.scrollbar._y = (1 - _loc6_) * (_loc5_ - _loc2_) + _loc2_;
      this.view.scrollbar._alpha = 100;
      com.rockstargames.ui.tweenStar.TweenStarLite.to(this.view.scrollbar,0.75,{_alpha:0,delay:0.25});
   }
   
   function delegate(scope, method)
   {
      var params = arguments.splice(2,arguments.length - 2);
      var _loc2_ = function()
      {
         method.apply(scope,arguments.concat(params));
      };
      return _loc2_;
   }
}