package id.co.akhdani.smartqueue.route.admin;

import id.co.akhdani.smartqueue.engine.master.MasterClient;
import labs.akhdani.alt.*;

public class Client {
    private static final String TAG = Client.class.getName();

    public AltDbRow retrieve(AltHttpRequest req, AltHttpResponse res) throws AltException {
        Index.init(req, res);

        AltValidation.instance()
                .rule(AltValidation.required(req.data.get("clientid")), "Klien harus dipilih!")
                .check();

        MasterClient dbo = new MasterClient(req);
        return dbo.retrieve(req.data);
    }

    public int update(AltHttpRequest req, AltHttpResponse res) throws AltException {
        Index.init(req, res);

        AltValidation.instance()
                .rule(AltValidation.required(req.data.get("clientid")), "Klien belum dipilih!")
                .rule(AltValidation.required(req.data.get("name")), "Nama belum diisi!")
                .rule(AltValidation.required(req.data.get("shortname")), "Nama singkat belum diisi!")
                .rule(AltValidation.required(req.data.get("address")), "Alamat belum diisi!")
                .rule(AltValidation.required(req.data.get("phone")), "Telepon belum diisi!")
                .rule(AltValidation.required(req.data.get("email")), "Emsil belum diisi!")
                .check();

        // insert
        MasterClient dbo = new MasterClient(req);
        return dbo.update(req.data);
    }
}