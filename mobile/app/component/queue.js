define([
    'component/api'
], function(){
    alt.factory('Queue', ['Api', '$log', function(Api, $log){
        var api = Api('system/auth');

        api.take = function(data){
            return this.connect('take', data);
        };

        api.cancel = function(data){
            return this.connect('cancel', data);
        };

        api.check = function(data){
            return this.connect('check', data);
        };

        return api;
    }]);
});