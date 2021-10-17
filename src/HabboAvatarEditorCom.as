package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboAvatarEditorManager;
    import com.sulake.iid.IIDHabboAvatarEditor;

    public class HabboAvatarEditorCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboAvatarEditorCom_manifest;
        public static var AvatarEditor:Class = HabboAvatarEditorCom_AvatarEditor;
        public static var AvatarEditorFrame:Class = HabboAvatarEditorCom_AvatarEditorFrame;
        public static var AvatarEditorContent:Class = HabboAvatarEditorCom_AvatarEditorContent;
        public static var AvatarEditorGrid:Class = HabboAvatarEditorCom_AvatarEditorGrid;
        public static var AvatarEditorImage:Class = HabboAvatarEditorCom_AvatarEditorImage;
        public static var AvatarEditorThumb:Class = HabboAvatarEditorCom_AvatarEditorThumb;
        public static var ViewConfiguration:Class = HabboAvatarEditorCom_ViewConfiguration;
        public static var StripClubItemsInfo:Class = HabboAvatarEditorCom_StripClubItemsInfo;
        public static var color_chooser_cell:Class = HabboAvatarEditorCom_color_chooser_cell;
        public static var avatareditor_generic_base:Class = HabboAvatarEditorCom_avatareditor_generic_base;
        public static var avatareditor_head_base:Class = HabboAvatarEditorCom_avatareditor_head_base;
        public static var avatareditor_legs_base:Class = HabboAvatarEditorCom_avatareditor_legs_base;
        public static var avatareditor_club_promo_try:Class = HabboAvatarEditorCom_avatareditor_club_promo_try;
        public static var avatareditor_club_promo_buy:Class = HabboAvatarEditorCom_avatareditor_club_promo_buy;
        public static var avatareditor_torso_base:Class = HabboAvatarEditorCom_avatareditor_torso_base;
        public static var Outfit:Class = HabboAvatarEditorCom_Outfit;
        public static var Selector:Class = HabboAvatarEditorCom_Selector;
        public static var avatareditor_wardrobe_base:Class = HabboAvatarEditorCom_avatareditor_wardrobe_base;
        public static var wardrobe_slot:Class = HabboAvatarEditorCom_wardrobe_slot;
        public static var avatareditor_hotlooks_base:Class = HabboAvatarEditorCom_avatareditor_hotlooks_base;
        public static var avatar_editor_download_icon:Class = HabboAvatarEditorCom_avatar_editor_download_icon;
        public static var editor_clr_40x32_1:Class = HabboAvatarEditorCom_editor_clr_40x32_1;
        public static var editor_clr_40x32_2:Class = HabboAvatarEditorCom_editor_clr_40x32_2;
        public static var editor_clr_40x32_3:Class = HabboAvatarEditorCom_editor_clr_40x32_3;
        public static var platform:Class = HabboAvatarEditorCom_platform;
        public static var removeSelection:Class = HabboAvatarEditorCom_removeSelection;
        public static var ae_tabs_generic:Class = HabboAvatarEditorCom_ae_tabs_generic;
        public static var ae_tabs_head:Class = HabboAvatarEditorCom_ae_tabs_head;
        public static var ae_tabs_legs:Class = HabboAvatarEditorCom_ae_tabs_legs;
        public static var ae_tabs_torso:Class = HabboAvatarEditorCom_ae_tabs_torso;
        public static var ae_tabs_hotlooks:Class = HabboAvatarEditorCom_ae_tabs_hotlooks;
        public static var ae_tabs_wardrobe:Class = HabboAvatarEditorCom_ae_tabs_wardrobe;
        public static var bottom_accessories:Class = HabboAvatarEditorCom_bottom_accessories;
        public static var bottom_accessories_on:Class = HabboAvatarEditorCom_bottom_accessories_on;
        public static var bottom_shoes:Class = HabboAvatarEditorCom_bottom_shoes;
        public static var bottom_shoes_on:Class = HabboAvatarEditorCom_bottom_shoes_on;
        public static var bottom_trousers:Class = HabboAvatarEditorCom_bottom_trousers;
        public static var bottom_trousers_on:Class = HabboAvatarEditorCom_bottom_trousers_on;
        public static var gender_female:Class = HabboAvatarEditorCom_gender_female;
        public static var gender_female_on:Class = HabboAvatarEditorCom_gender_female_on;
        public static var gender_male:Class = HabboAvatarEditorCom_gender_male;
        public static var gender_male_on:Class = HabboAvatarEditorCom_gender_male_on;
        public static var head_accessories:Class = HabboAvatarEditorCom_head_accessories;
        public static var head_accessories_on:Class = HabboAvatarEditorCom_head_accessories_on;
        public static var head_eyewear:Class = HabboAvatarEditorCom_head_eyewear;
        public static var head_eyewear_on:Class = HabboAvatarEditorCom_head_eyewear_on;
        public static var head_face_accessories:Class = HabboAvatarEditorCom_head_face_accessories;
        public static var head_face_accessories_on:Class = HabboAvatarEditorCom_head_face_accessories_on;
        public static var head_hair:Class = HabboAvatarEditorCom_head_hair;
        public static var head_hair_on:Class = HabboAvatarEditorCom_head_hair_on;
        public static var head_hats:Class = HabboAvatarEditorCom_head_hats;
        public static var head_hats_on:Class = HabboAvatarEditorCom_head_hats_on;
        public static var top_accessories:Class = HabboAvatarEditorCom_top_accessories;
        public static var top_accessories_on:Class = HabboAvatarEditorCom_top_accessories_on;
        public static var top_shirt:Class = HabboAvatarEditorCom_top_shirt;
        public static var top_jacket_on:Class = HabboAvatarEditorCom_top_jacket_on;
        public static var top_jacket:Class = HabboAvatarEditorCom_top_jacket;
        public static var top_prints_on:Class = HabboAvatarEditorCom_top_prints_on;
        public static var top_prints:Class = HabboAvatarEditorCom_top_prints;
        public static var top_shirt_on:Class = HabboAvatarEditorCom_top_shirt_on;
        public static var selectOutfit:Class = HabboAvatarEditorCom_selectOutfit;
        public static var selectOutfit_over:Class = HabboAvatarEditorCom_selectOutfit_over;
        public static var wardrobe_empty_slot:Class = HabboAvatarEditorCom_wardrobe_empty_slot;
        public static var requiredClasses:Array = new Array(HabboAvatarEditorManager, IIDHabboAvatarEditor);


    }
}