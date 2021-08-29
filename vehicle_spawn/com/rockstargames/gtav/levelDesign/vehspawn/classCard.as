class com.rockstargames.gtav.levelDesign.vehspawn.classCard extends com.rockstargames.gtav.levelDesign.vehspawn.Card
{
    function classCard(id,label,txd,vehname)
    {
        super(id,label,txd);
        this.vehname = vehname;
    }

    function get_vehname()
    {
        return this.vehname;
    }

}