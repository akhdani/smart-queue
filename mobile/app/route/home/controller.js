define([
    'asset/js/moment-with-locales.min',
    'asset/js/swiper.min'
], function(moment){

    return [
        '$scope',
        function($scope){
            // Right Sidebar
            $('#open-right').sideNav({
                menuWidth: 240, // Default is 240
                edge: 'right', // Choose the horizontal origin
                closeOnClick: false // Closes side-nav on <a> clicks, useful for Angular/Meteor
            });

            // Left Sidebar
            $('#open-left').sideNav({
                menuWidth: 240, // Default is 240
                edge: 'left', // Choose the horizontal origin
                closeOnClick: true // Closes side-nav on <a> clicks, useful for Angular/Meteor
            });

            var mySwiper = new Swiper ('.swiper-container', {
                autoplay: 3000,
                loop: true
            });
        }
    ];
});