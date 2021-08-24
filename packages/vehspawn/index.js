mp.events.add("vehspawn_Spawn", (player, model) => {
    var vehicle = mp.vehicles.new(model, player.position,{heading:player.heading});
    //player.putIntoVehicle(vehicle, 0);
});