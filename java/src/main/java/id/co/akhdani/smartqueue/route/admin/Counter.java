package id.co.akhdani.smartqueue.route.admin;

import id.co.akhdani.smartqueue.engine.Queue;
import id.co.akhdani.smartqueue.engine.queue.QueueCounter;
import labs.akhdani.alt.*;

import java.util.HashMap;

public class Counter {
    private static final String TAG = Counter.class.getName();

    public AltDbRow retrieve(AltHttpRequest req, AltHttpResponse res) throws AltException {
        Index.init(req, res);

        AltValidation.instance()
                .rule(AltValidation.required(req.data.get("clientid")), "Klien harus dipilih!")
                .rule(AltValidation.required(req.data.get("counterid")), "Loket harus dipilih!")
                .check();

        QueueCounter dbo = new QueueCounter(req);
        return dbo.retrieve(req.data);
    }

    public HashMap<String, Object> table(AltHttpRequest req, AltHttpResponse res) throws AltException {
        Index.init(req, res);

        AltValidation.instance()
                .rule(AltValidation.required(req.data.get("clientid")), "Klien harus dipilih!")
                .check();

        QueueCounter dbo = new QueueCounter(req);
        return new HashMap<String, Object>(){{
            put("total", dbo.count(req.data));
            put("list", dbo.get(req.data));
        }};
    }

    public int insert(AltHttpRequest req, AltHttpResponse res) throws AltException {
        Index.init(req, res);

        AltValidation.instance()
                .rule(AltValidation.required(req.data.get("clientid")), "Klien harus dipilih!")
                .rule(AltValidation.required(req.data.get("queueid")), "Antrian harus dipilih!")
                .rule(AltValidation.required(req.data.get("name")), "Nama harus diisi!")
                .check();

        QueueCounter dbo = new QueueCounter(req);
        AltDbRow row = dbo.retrieve(req.data);

        if(!row.getString("clientid").equalsIgnoreCase(req.data.get("clientid")))
            throw new AltException("Anda tidak berhak mengakses data!");

        return dbo.insert(req.data);
    }

    public int update(AltHttpRequest req, AltHttpResponse res) throws AltException {
        Index.init(req, res);

        AltValidation.instance()
                .rule(AltValidation.required(req.data.get("clientid")), "Klien harus dipilih!")
                .rule(AltValidation.required(req.data.get("queueid")), "Antrian harus dipilih!")
                .rule(AltValidation.required(req.data.get("name")), "Nama harus diisi!")
                .check();

        QueueCounter dbo = new QueueCounter(req);
        return dbo.update(req.data);
    }

    public int delete(AltHttpRequest req, AltHttpResponse res) throws AltException {
        Index.init(req, res);

        AltValidation.instance()
                .rule(AltValidation.required(req.data.get("clientid")), "Klien harus dipilih!")
                .check();

        QueueCounter dbo = new QueueCounter(req);
        return dbo.delete(req.data);
    }
}