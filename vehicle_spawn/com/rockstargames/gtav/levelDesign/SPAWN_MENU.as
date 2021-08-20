class com.rockstargames.gtav.levelDesign.SPAWN_MENU extends com.rockstargames.gtav.levelDesign.BaseScriptUI
{

   static var DPAD_DOWN = 187;
   static var DPAD_UP = 188;
   static var DPAD_LEFT = 189;
   static var DPAD_RIGHT = 190;
   static var ACCEPT = 201;
   static var CANCEL = 202;
   static var X = 203;
   static var Y = 204;
   static var LB = 205;
   static var RB = 206;
   static var LT = 207;
   static var RT = 208;
   static var LEFT_MOUSE = 237;
   static var RIGHT_MOUSE = 238;
   static var SCROLL_UP_MOUSE = 241;
   static var SCROLL_DOWN_MOUSE = 242;
   static var KEY_DOWN = 300;
   static var KEY_UP = 301;

   var HOMEPAGE = 0;
   var CLASSES = 1
   var VEH_LIST= 2;
   var SCREEN_CLASSES = [com.rockstargames.gtav.levelDesign.vehspawn.HOMEPAGE,com.rockstargames.gtav.levelDesign.vehspawn.CLASSES,com.rockstargames.gtav.levelDesign.vehspawn.VEHLIST];   
   var vehclassList = [];
   
   function SPAWN_MENU()
   {
      super();
      _global.gfxExtensions = true;
      this._name = "SPAWN_MENU";
   }
   function INITIALISE(mc)
   {
      this.TIMELINE = mc;
      this.BOUNDING_BOX = this.TIMELINE.attachMovie("BOUNDING_BOX","BOUNDING_BOX",this.TIMELINE.getNextHighestDepth());
      this.BOUNDING_BOX._visible = false;
      this.CONTENT = this.TIMELINE.attachMovie("CONTENT","CONTENT",this.TIMELINE.getNextHighestDepth());
      this.displayConfig = new com.rockstargames.ui.utils.DisplayConfig();
      com.rockstargames.ui.game.GameInterface.call("SET_DISPLAY_CONFIG",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,this.displayConfig);
      this.imageManager = new com.rockstargames.gtav.levelDesign.vehspawn.ImageManager();
      this.screenContainer = this.CONTENT.createEmptyMovieClip("screenContainer",this.CONTENT.getNextHighestDepth());
      var _loc2_ = this.CONTENT.createEmptyMovieClip("cursorDebugView",this.CONTENT.getNextHighestDepth());
      var _loc3_ = this.CONTENT.attachMovie("cursor","cursor",this.CONTENT.getNextHighestDepth());
      this.cursor = new com.rockstargames.gtav.levelDesign.vehspawn.Cursor(_loc3_,_loc2_,this.displayConfig);
      this.lastClickedButtonID = -1;
      this.vehclassList = [];
      showScreen(this.HOMEPAGE);
   }
   
   function ACTIVATE()
   {
      this.deactivated = false;
   }
   function DEACTIVATE()
   {
      this.deactivated = true;
   }

   function ADD_VEH_CLASS(id,label)
   {
      var card = new com.rockstargames.gtav.levelDesign.vehspawn.Card(id,label);
      this.vehclassList.push(card);
   }

   function SET_PLAYER_NAME(str)
   {
      if(this.currScreen instanceof com.rockstargames.gtav.levelDesign.vehspawn.HOMEPAGE)
      {
         com.rockstargames.gtav.levelDesign.vehspawn.HOMEPAGE(this.currScreen).setPLAYER_NAME(str);
      }
   }

   function SET_MOUSE_INPUT(x, y)
   {
      this.cursor.moveTo(x,y,true);
      this.currScreen.handleMouseInput(x,y);
   }

   function SET_INPUT_EVENT(inputID)
   {
      if(this.deactivated)
      {
         return undefined;
      }
      this.inputReceived = true;
      switch(inputID)
      {
         case com.rockstargames.gtav.levelDesign.vehspawn.Cursor.UP:
         case com.rockstargames.gtav.levelDesign.vehspawn.Cursor.RIGHT:
         case com.rockstargames.gtav.levelDesign.vehspawn.Cursor.DOWN:
         case com.rockstargames.gtav.levelDesign.vehspawn.Cursor.LEFT:
            this.cursor.setTarget(inputID);
            break;
         case com.rockstargames.gtav.levelDesign.SPAWN_MENU.ACCEPT:
            this.lastClickedButtonID = this.cursor.getTargetIDUnderCursor();
      }
      this.currScreen.handleButtonInput(inputID);
   }

   function SET_SCROLL_INPUT(y)
   {
      this.currScreen.handleMouseScrollInput(y)
   }

   function GET_CURRENT_SELECTION()
   {
      if(this.inputReceived)
      {
         return this.cursor.getTargetIDUnderCursor();
      }
      return this.lastClickedButtonID;
   }

   function showScreen(screenID)
   {
      if(this.currScreen)
      {
         this.imageManager.clearImageQueue();
         this.currScreen.dispose();
      }
      this.cursor.setState(com.rockstargames.gtav.levelDesign.vehspawn.Cursor.STATE_ARROW);
      this.currScreen = new this.SCREEN_CLASSES[screenID](this,this.screenContainer,this.cursor);
      this.currScreenID = screenID;
      this.inputReceived = false;
   }

   static function setSpacedTextField(tf, label)
   {
      tf.text = label;
      var _loc2_ = tf.getTextFormat();
      _loc2_.letterSpacing = 2;
      tf.setTextFormat(_loc2_);
   }
   static function formatNumber(value)
   {
      var _loc3_ = Math.abs(int(value)).toString();
      var _loc4_ = _loc3_.length;
      var _loc2_ = 0;
      var _loc1_ = _loc4_ % 3 || 3;
      var _loc5_ = (value >= 0?"":"-") + _loc3_.slice(_loc2_,_loc1_);
      while(_loc1_ < _loc4_)
      {
         _loc2_ = _loc1_;
         _loc1_ = _loc1_ + 3;
         _loc5_ = _loc5_ + ("," + _loc3_.slice(_loc2_,_loc1_));
      }
      return _loc5_;
   }
   static function truncate(tf, txt, autoSize, letterSpacing)
   {
      tf.text = txt;
      if(!isNaN(letterSpacing))
      {
         var _loc3_ = tf.getTextFormat();
         _loc3_.letterSpacing = letterSpacing;
         tf.setTextFormat(_loc3_);
      }
      if(tf.textWidth > tf._width)
      {
         var _loc6_ = tf._width;
         tf.autoSize = autoSize;
         var _loc2_ = txt.length;
         while(_loc2_ > 0)
         {
            tf.text = txt.substring(0,_loc2_) + "...";
            if(!isNaN(letterSpacing))
            {
               _loc3_ = tf.getTextFormat();
               _loc3_.letterSpacing = letterSpacing;
               tf.setTextFormat(_loc3_);
            }
            if(tf._width <= _loc6_)
            {
               break;
            }
            _loc2_ = _loc2_ - 1;
         }
         tf.autoSize = "none";
         tf._width = _loc6_;
      }
   }
   static function playSound(soundName, soundSet)
   {
      if(soundSet == undefined)
      {
         soundSet = "DLC_GR_MOC_Computer_Sounds";
      }
      com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,soundName,soundSet);
   }
}