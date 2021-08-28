class com.rockstargames.gtav.levelDesign.vehspawn.classCard extends com.rockstargames.gtav.levelDesign.vehspawn.Card
{
    function classCard(id,label,txd,hash)
    {
        super(id,label,txd);
        this.hash = hash;
    }

    function get_hash()
    {
        return this.hash;
    }

}