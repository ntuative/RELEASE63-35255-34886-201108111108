package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;

    public class BorderController extends ContainerController implements IBorderWindow 
    {

        public function BorderController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function=null, param9:Array=null, param10:Array=null, param11:uint=0)
        {
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
        }

    }
}