class com.rockstargames.gtav.levelDesign.vehspawn.Card
{
   function Card(id, label,txd)
   {
      this.id = id;
      this.label = label;
      this.txd = txd;
   }
   function get_id()
   {
      return this.id;
   }
   function get_label()
   {
      return this.label;
   }
   function get_txd()
   {
      return this.txd;
   }
}
