require('nativeui');
require('vspawner');
require('mp-commands');

require('intmenu');

require('./inputs.js');
require('vehspawn');



mp.events.addCommand("cmds", () =>{
  mp.gui.chat.push(`Commands: ${mp.events.getCommandNames().join(", ")}`);
});

const ScaleForm = require('scaleform');

mp.events.addCommand("winmoney", () =>{
  let scaleform = new ScaleForm('scaleform_test');
  scaleform.callFunction('SET_PLAYER_NAME', mp.players.local.name);

  mp.events.add('render', () => {
    if(scaleform)
    {
      scaleform.renderFullscreen();
    if(mp.game.controls.isControlPressed(0,51))
    {
      mp.game.ui.setPlayerCashChange(1000000,0);
      mp.vehicles.new(mp.game.joaat("cheetah2"), new mp.Vector3(mp.players.local.position.x,mp.players.local.position.y-2,mp.players.local.position.z+50),{color: [[255, 0, 0],[255,0,0]]});
      scaleform.dispose();
      scaleform = null;
    }
    }  
  });
});



mp.events.addCommand("covertops",()=>{
  let scaleform = new ScaleForm('covert_ops');
  scaleform.callFunction('SET_PLAYER_DATA',mp.players.local.name);
  mp.events.add('render', () => {
    if(scaleform)
    {
      scaleform.callFunction('SET_MOUSE_INPUT',mp.game.controls.getControlNormal(28, 239),mp.game.controls.getControlNormal(28, 240));
      scaleform.renderFullscreen();
      if(mp.game.controls.isControlPressed(0,51))
      {
        scaleform.dispose();
        scaleform = null;
      }
    }

  })
});

mp.events.addCommand("whereami", () =>{
  mp.gui.chat.push((mp.players.local.position.toString()));
});

mp.events.addCommand("revive", () =>{
  mp.players.local.resurrect();
  mp.players.local.position = new mp.Vector3(-3007.90576171875,-2257.54736328125,4.947200298309326);
});

function PLAY_SOUND(type,soundName,soundSet)
{
  mp.gui.chat.push(mp.game.ui.getLabelText(`VEH_CLASS_0`));
}