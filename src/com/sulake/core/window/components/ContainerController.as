package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.utils.Iterator;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.graphics.GraphicContext;
    import com.sulake.core.window.graphics.IGraphicContext;

    public class ContainerController extends WindowController implements IWindowContainer 
    {

        public function ContainerController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function=null, param9:Array=null, param10:Array=null, param11:uint=0)
        {
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
            var_2666 = (((var_1200) || (testParamFlag(WindowParam.var_609))) || (!(testParamFlag(WindowParam.var_713))));
        }

        public function get iterator():IIterator
        {
            return (new Iterator(this));
        }

        override public function getGraphicContext(param1:Boolean):IGraphicContext
        {
            if (((param1) && (!(var_1252))))
            {
                var_1252 = new GraphicContext((("GC {" + _name) + "}"), ((testParamFlag(WindowParam.var_713)) ? GraphicContext.GC_TYPE_CONTAINER : GraphicContext.GC_TYPE_BITMAP), var_1202);
                var_1252.visible = var_1169;
            };
            return (var_1252);
        }


    }
}