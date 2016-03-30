define([
], function(){
    alt.factory('Api', ['$log', '$api', '$alert', '$q', '$rootScope', function($log, $api, $alert, $q, $rootScope){
        return function(url){
            return $api(url, '', {
                connect: function(params){
                    $rootScope.isloading = true;
                },
                success: function(response, params, deferred, iscancelled){
                    $rootScope.isloading = false;
                },
                error: function(error, params, deferred, iscancelled){
                    $rootScope.isloading = false;
                    if(error.code == 1){
                        this.success(error, params, deferred, iscancelled);
                        deferred.resolve(error);
                        return false;
                    }else{
                        $alert.add(typeof error.data === "string" ? error.data : (typeof error.message === "string" ? error.message : 'Tidak dapat melakukan koneksi ke server!'));
                    }
                }
            });
        };
    }]);
});