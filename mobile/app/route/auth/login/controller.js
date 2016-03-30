define([

], function(){
    return [
        '$scope', '$rootScope',
        function($scope, $rootScope){
            if($auth.islogin()) $rootScope.redirect('home');

            // login data
            $scope.data = {
                username: '',
                password: '',
                imei: '123',
                latitude: '',
                longitude: ''
            };

            
        }
    ];
});