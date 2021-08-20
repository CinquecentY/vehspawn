class com.rockstargames.gtav.levelDesign.vehspawn.VEHLIST extends com.rockstargames.gtav.levelDesign.vehspawn.Screen
{
   var vehList = -1;
   function VEHLIST(app, viewContainer, cursor)
   {
      super(app,viewContainer,cursor,"VEHLIST");
      this.init();
   }
   function init()
   {
      this.c_1_1 = new com.rockstargames.gtav.levelDesign.vehspawn.Button(com.rockstargames.gtav.levelDesign.vehspawn.VEHLIST.c_1_1,this.view.c_1_1);
      this.app.SET_MOUSE_INPUT(0.605,0.57);
      this.view._visible = true;
      this.vehList = [];
   }
   function __get__isReady()
   {
      return true;
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
   function dispose()
   {
      com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf(this.view);
      super.dispose();
   }
}