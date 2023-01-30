(function ($) {
    $(document).ready(function () {
        var main_menu = $('ul.nav');

        main_menu.superfish({
            delay: 500, 									// one second delay on mouseout
            animation: {opacity: 'show', height: 'show'},	// fade-in and slide-down animation
            speed: 'fast', 									// faster animation speed
            autoArrows: true, 								// disable generation of arrow mark-up
            dropShadows: false								// disable drop shadows
        });
        (function et_search_bar() {
            var $searchinput = $(".et-search-form .search_input"),
                searchvalue = $searchinput.val();

            $searchinput.focus(function () {
                if (jQuery(this).val() === searchvalue) jQuery(this).val("");
            }).blur(function () {
                if (jQuery(this).val() === "") jQuery(this).val(searchvalue);
            });
        })();


        et_duplicate_menu($('ul.nav'), $('.mobile_nav'), 'mobile_menu', 'et_mobile_menu');

        function et_duplicate_menu(menu, append_to, menu_id, menu_class) {
            var $cloned_nav;

            menu.clone().attr('id', menu_id).removeClass().attr('class', menu_class).appendTo(append_to);
            $cloned_nav = append_to.find('> ul');
            $cloned_nav.find('.menu_slide').remove();
            $cloned_nav.find('li:first').addClass('et_first_mobile_item');

            append_to.click(function () {
                if ($(this).hasClass('closed')) {
                    $(this).removeClass('closed').addClass('opened');
                    $cloned_nav.slideDown(500);
                } else {
                    $(this).removeClass('opened').addClass('closed');
                    $cloned_nav.slideUp(500);
                }
                return false;
            });

            append_to.find('a').click(function (event) {
                event.stopPropagation();
            });
        }
    });
})
(jQuery);