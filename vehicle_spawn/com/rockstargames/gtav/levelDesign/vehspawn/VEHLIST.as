class com.rockstargames.gtav.levelDesign.vehspawn.VEHLIST extends com.rockstargames.gtav.levelDesign.vehspawn.Screen
{
   function VEHLIST(app, viewContainer, cursor)
   {
      super(app,viewContainer,cursor,"VEHLIST");
      this.init();
   }
   function init()
   {
      this.app.SET_MOUSE_INPUT(0.605,0.57);
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
      for (i=0;i < this.app.vehList.length;i++)
      {
         var card = this.app.vehList[i];
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
   /*function handleButtonInput(inputID)
   {
      if(inputID == com.rockstargames.gtav.levelDesign.SPAWN_MENU.ACCEPT || inputID == com.rockstargames.gtav.levelDesign.SPAWN_MENU.LEFT_MOUSE)
      {
         var _loc0_ = this.app.GET_CURRENT_SELECTION();
         if( _loc0_ === this.VEH_CLASS_0.id)
         {
            com.rockstargames.gtav.levelDesign.SPAWN_MENU.playSound("Log_In");
            this.showNextScreen();
         }
         else
            com.rockstargames.gtav.levelDesign.SPAWN_MENU.playSound("Log_In");
      }
   }
   function showNextScreen()
   {
      this.app.showScreen(this.app.VEHLIST);
   }*/
   function updateButtons()
   {
      var buttons = [];
      for (i=0;i < this.app.vehList.length;i++)
      {
         var view = this.app.vehList[i].view;
         var button = this.app.vehList[i].button;
         button.top = Math.max(this.view.listMask._y,view._y + view._parent._y);
         button.bottom = Math.min(this.view.listMask._y + this.view.listMask._height,view._y + view._height + view._parent._y);
         if(button.bottom - button.top > 0)
         {
            buttons.push(button);
         }
      }
      this.cursor.setTargetRects(buttons);
   }
   function dispose()
   {
      com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf(this.view);
      super.dispose();
   }
}