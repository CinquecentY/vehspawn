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
      this.view._visible = true;
      this.initList();
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
      var width = 285;
      var height = 248;
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
      view.label.text = card.label;
      card.view = view;
      card.button = new com.rockstargames.gtav.levelDesign.vehspawn.Button(card.get_id(),view);
   }


   /*function set_veh_class(vehclass)
   {
      this.view.buttonTest.label.text = vehclass.label;
   }*/
   function handleButtonInput(inputID)
   {
      if(inputID == com.rockstargames.gtav.levelDesign.SPAWN_MENU.ACCEPT || inputID == com.rockstargames.gtav.levelDesign.SPAWN_MENU.LEFT_MOUSE)
      {
         var currentSelection = this.app.GET_CURRENT_SELECTION();
         if( currentSelection.slice(0,currentSelection.length-1) == "VEH_CLASS_")
         {
            this.showNextScreen();
            
         }
            
      }
   }
   function handleMouseScrollInput(y, isSlowingDown)
   {
      var _loc4_ = (y - 128) / 128;
      _loc4_ *= 2;
      var timer = getTimer();
      var _loc3_ = timer - this.scrollTimeDelta;
      _loc3_ = Math.max(16,Math.min(40,_loc3_));
      var _loc6_ = com.rockstargames.gtav.levelDesign.vehspawn.MainScreen.SCROLL_SPEED * _loc3_ / 32;
      this.scrollTimeDelta = timer;
      this.scrollList((- _loc6_) * _loc4_);
      if(y != 127)
      {
         y += 0.17 * (127 - y);
         if(Math.abs(y - 127) < 1)
         {
            y = 127;
         }
         //this.view.onEnterFrame = this.delegate(this,this.handleMouseScrollInput,y,true);
      }
      /*else if(isSlowingDown)
      {
         delete this.view.onEnterFrame;
      }*/
      
   }
   
   function scrollList(dy)
   {
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
   function updateScrollbar()
   {
            com.rockstargames.gtav.levelDesign.SPAWN_MENU.playSound("Type_Enter");

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
      this.cursor.setTargetRects(buttons);
   }
   
   function showNextScreen()
   {
      this.app.showScreen(this.app.VEH_LIST);
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

   function dispose()
   {
      com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf(this.view);
      super.dispose();
   }
}