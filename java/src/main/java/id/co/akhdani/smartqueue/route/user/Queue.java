package id.co.akhdani.smartqueue.route.user;

import id.co.akhdani.smartqueue.engine.master.MasterClient;
import id.co.akhdani.smartqueue.route.admin.Index;
import labs.akhdani.alt.*;

public class Queue {
    private static final String TAG = Queue.class.getName();

    public AltDbRow retrieve(AltHttpRequest req, AltHttpResponse res) throws AltException {
        Index.init(req, res);

        AltValidation.instance()
                .rule(AltValidation.required(req.data.get("clientid")), "Klien harus dipilih!")
                .check();

        MasterClient dbo = new MasterClient(req);
        return dbo.retrieve(req.data);
    }
}