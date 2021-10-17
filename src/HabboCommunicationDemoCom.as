package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboCommunicationDemo;

    public class HabboCommunicationDemoCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboCommunicationDemoCom_manifest;
        public static var requiredClasses:Array = new Array(HabboCommunicationDemo);
        public static var login_window:Class = HabboCommunicationDemoCom_login_window;
        public static var air_login_window:Class = HabboCommunicationDemoCom_air_login_window;
        public static var hotel_view_window:Class = HabboCommunicationDemoCom_hotel_view_window;
        public static var login_user_list_item:Class = HabboCommunicationDemoCom_login_user_list_item;
        public static var message_tester:Class = HabboCommunicationDemoCom_message_tester;


    }
}