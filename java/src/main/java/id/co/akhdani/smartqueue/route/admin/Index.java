package id.co.akhdani.smartqueue.route.admin;

import labs.akhdani.Alt;
import labs.akhdani.alt.AltException;
import labs.akhdani.alt.AltHttpRequest;
import labs.akhdani.alt.AltHttpResponse;

import java.util.Map;

public class Index {
    public static void init(AltHttpRequest req, AltHttpResponse res) throws AltException {
        Alt.set_permission(2, req);

        Map<String, String> userdata = Alt.get_userdata(req);
        req.data.put("clientid", userdata.get("clientid"));
    }
}
