package com.sulake.core.window.utils.tablet
{
    import com.sulake.core.window.utils.MouseEventProcessor;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.utils.EventProcessorState;
    import com.sulake.core.window.utils.IEventQueue;

    public class TabletEventProcessor extends MouseEventProcessor 
    {

        private var var_2781:String = "";


        override public function process(param1:EventProcessorState, param2:IEventQueue):void
        {
            if (param2.length == 0)
            {
                return;
            };
            var_1981 = param1.desktop;
            var_1982 = (param1.var_1974 as WindowController);
            var_1983 = (param1.var_1975 as WindowController);
            var_1112 = param1.renderer;
            var_1984 = param1.var_1976;
            param2.begin();
            param2.end();
            param1.desktop = var_1981;
            param1.var_1974 = var_1982;
            param1.var_1975 = var_1983;
            param1.renderer = var_1112;
            param1.var_1976 = var_1984;
        }


    }
}