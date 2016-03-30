define([
    'component/api'
], function(){
    alt.factory('System_Auth', ['Api', '$log', function(Api, $log){
        var api = Api('system/auth');

        api.login = function(data){
            return this.connect('login', data);
        };

        api.logout = function(data){
            return this.connect('logout', data);
        };

        api.register = function(data){
            return this.connect('register', data);
        };

        return api;
    }]);
});