package id.co.akhdani.smartqueue.engine;

import id.co.akhdani.smartqueue.engine.queue.QueueArchive;
import id.co.akhdani.smartqueue.engine.queue.QueueCounter;
import id.co.akhdani.smartqueue.engine.queue.QueueNumber;
import labs.akhdani.Alt;
import labs.akhdani.alt.*;

import java.time.Instant;
import java.util.HashMap;
import java.util.Map;

import static com.sun.org.apache.xalan.internal.lib.ExsltDatetime.time;

public class Queue extends AltDbo {

    public Queue(){
        this(null);
    }

    public Queue(AltHttpRequest request){
        super(request);

        this.pkey           = "queueid";
        this.table_name     = "queue";
        this.table_fields.put("queueid", "");
        this.table_fields.put("typeid", "");
        this.table_fields.put("clientid", "");
        this.table_fields.put("name", "");
        this.table_fields.put("description", "");
        this.table_fields.put("starttime", "");
        this.table_fields.put("endtime", "");
        this.table_fields.put("avgtime", "");
        this.table_fields.put("numberid", "");
        this.table_fields.put("number", "");
        this.table_fields.put("counterid", "");
        this.table_fields.put("counter", "");
        this.table_fields.put("isactive", "");
        this.table_fields.put("entrytime", "");
        this.table_fields.put("entryuser", "");
        this.table_fields.put("modifiedtime", "");
        this.table_fields.put("modifieduser", "");
        this.table_fields.put("deletedtime", "");
        this.table_fields.put("deleteduser", "");
        this.table_fields.put("isdeleted", "");
    }

    /**
     * Call next number
     * @param data
     * @return array
     * @throws AltException
     */
    public AltDbRow next(Map<String, String> data) throws AltException {
        QueueNumber dboNumber = new QueueNumber(this.request);
        AltDbRows next = dboNumber.get(new HashMap<String, String>(){{
            put("select", "numberid, number");
            put("queueid", data.get("queueid"));
            put("where", "numberid > "  +  dboNumber.quote(data.get("numberid") + " and isfinish <> 1 and iscancel = 0"));
            put("order", "number asc");
            put("limit", "1");
        }});

        if(next.size() <= 0)
            throw new AltException("Nomor antrian sudah habis!");

        data.put("numberid", next.get(0).get("numberid"));
        data.put("number", next.get(0).get("number"));

        return this.call(data);
    }

    /**
     * Call specific number
     * @param data
     * @return array
     * @throws AltException
     */
    public AltDbRow call(Map<String, String> data) throws AltException {
        // validate
        AltValidation.instance()
                .rule(AltValidation.required(data.get("queueid")), "Queueid tidak boleh kosong")
                .rule(AltValidation.required(data.get("counterid")), "Counterid tidak boleh kosong")
                .rule(AltValidation.required(data.get("number")), "Nomor antrian berikutnya tidak boleh kosong")
                .check();

        // get new numberid
        QueueNumber dboNumber = new QueueNumber(this.request);
        AltDbRows next = dboNumber.get(new HashMap<String, String>(){{
            put("number", "= " + dboNumber.quote(data.get("number")));
            put("queueid", "= " + dboNumber.quote(data.get("queueid")));
            put("isfinish", "0");
        }});

        if(next.size() <= 0)
            throw new AltException("Nomor antrian tidak ditemukan!");

        // check counter
        QueueCounter dboCounter = new QueueCounter(this.request);
        AltDbRow counter = dboCounter.retrieve(new HashMap<String, String>(){{
            put("select", "counterid, name");
            put("counterid", data.get("counterid"));
        }});

        // update queue
        Queue dboQueue = new Queue(this.request);
        dboQueue.update(new HashMap<String, String>(){{
            put("queueid", data.get("queueid"));
            put("counterid", data.get("counterid"));
            put("counter", counter.get("name"));
            put("numberid", next.get(0).get("numberid"));
            put("number", next.get(0).get("number"));
        }});

        // update counter
        dboCounter.update(new HashMap<String, String>(){{
            put("counterid", data.get("counterid"));
            put("numberid", next.get(0).get("numberid"));
            put("number", next.get(0).get("number"));
        }});

        // update next number
        dboNumber.update(new HashMap<String, String>(){{
            put("numberid", next.get(0).get("numberid"));
            put("counterid", data.get("counterid"));
            put("starttime", String.valueOf(Instant.now().getEpochSecond()));
        }});

        return dboQueue.retrieve(new HashMap<String, String>(){{
            put("queueid", data.get("queueid"));
        }});
    }

    /**
     * Skip a number
     * @param data
     * @return
     */
    public int skip(Map<String, String> data) throws AltException {
        // validate
        AltValidation.instance()
                .rule(AltValidation.required(data.get("queueid")), "Queueid tidak boleh kosong!")
                .rule(AltValidation.required(data.get("counterid")), "Counterid tidak boleh kosong!")
                .rule(AltValidation.required(data.get("numberid")), "Numberid tidak boleh kosong!")
                .check();

        // update number
        QueueNumber dboNumber = new QueueNumber(this.request);
        AltDbRow number = dboNumber.retrieve(new HashMap<String, String>(){{
            put("numberid", data.get("numberid"));
        }});

        number.put("starttime", "");
        number.put("endtime", "");
        number.put("counter", 0);
        number.put("isfinish", 0);

        return dboNumber.update(number.map());
    }

    public int finish(Map<String, String> data) throws AltException {
        // validate
        AltValidation.instance()
                .rule(AltValidation.required(data.get("queueid")), "Queueid tidak boleh kosong")
                .rule(AltValidation.required(data.get("counterid")), "Counterid tidak boleh kosong")
                .check();

        // check queue
        Queue dboQueue = new Queue(this.request);
        AltDbRow queue = dboQueue.retrieve(new HashMap<String, String>(){{
            put("queueid", data.get("queueid"));
            put("isactive", "1");
        }});

        // if no previous number, return nothing
        if(queue.get("number").equalsIgnoreCase("0"))
            return 0;

        // check counter
        QueueCounter dboCounter = new QueueCounter(this.request);
        AltDbRow counter = dboCounter.retrieve(new HashMap<String, String>(){{
            put("select", "counterid, name");
            put("counterid", data.get("counterid"));
        }});

        // update previous number
        QueueNumber dboNumber = new QueueNumber(this.request);
        AltDbRow number = dboNumber.retrieve(new HashMap<String, String>(){{
            put("numberid", queue.get("numberid"));
        }});

        if(number.get("isfinish").equalsIgnoreCase("1"))
            throw new AltException("Nomor antrian sudah selesai!");

        number.put("counter", data.get("counterid"));
        number.put("endtime", String.valueOf(Instant.now().getEpochSecond()));
        number.put("isfinish", "1");
        dboNumber.update(number.map());

        // update queue
        queue.put("avgtime", String.valueOf(queue.get("avgtime") + Math.abs(number.getInteger("endtime") - number.getInteger("starttime")) / 2));
        dboQueue.update(queue.map());

        // update counter
        return dboCounter.update(new HashMap<String, String>(){{
            put("counterid", data.get("counterid"));
            put("number", "0");
        }});
    }

    public AltDbRow take(Map<String, String> data) throws AltException {
        // validate
        AltValidation.instance()
                .rule(AltValidation.required(data.get("clientid")), "Clientid tidak boleh kosong")
                .rule(AltValidation.required(data.get("queueid")), "Queueid tidak boleh kosong")
                .check();

        // check queue
        Queue dboQueue = new Queue(this.request);
        AltDbRow queue = dboQueue.retrieve(new HashMap<String, String>(){{
            put("queueid", data.get("queueid"));
            put("isactive", "1");
        }});

        // get last number
        QueueNumber dboNumber = new QueueNumber(this.request);
        AltDbRows lastNumber = dboNumber.get(new HashMap<String, String>(){{
            put("select", "number");
            put("queueid", "= " + dboNumber.quote(data.get("queueid")));
            put("clientid", "= " + dboNumber.quote(data.get("clientid")));
            put("limit", "1");
            put("order", "number desc");
        }});

        int last = lastNumber.size() > 0 ? lastNumber.get(0).getInteger("number") : 1;

        // try to insert
        int i = 0;
        boolean isinserted = false;
        int insertid = 0;
        while(!isinserted && i < 10){
            try{
                data.put("number", String.valueOf(last));
                insertid = dboNumber.insert(data);
                isinserted = true;
            }catch(Exception e){
                last++;
            }
            i++;
        }

        if(i >= 10)
            throw new AltException("Tidak dapat mengambil nomor antrian!");

        final int finalInsertid = insertid;
        return dboNumber.retrieve(new HashMap<String, String>(){{
            put("select", "numberid, number");
            put("numberid", String.valueOf(finalInsertid));
        }});
    }

    /**
     * Cancel number
     * @param data
     * @return
     * @throws AltException
     */
    public int cancel(Map<String, String> data) throws AltException {
        // validate
        AltValidation.instance()
                .rule(AltValidation.required(data.get("numberid")), "Numberid tidak boleh kosong")
                .check();

        Map<String, String> userdata = Alt.get_userdata(this.request);

        QueueNumber dboNumber = new QueueNumber(this.request);
        return dboNumber.update(new HashMap<String, String>(){{
            put("numberid", data.get("numberid"));
            put("iscancel", "1");
            put("canceltime", String.valueOf(Instant.now().getEpochSecond()));
            put("canceluser", userdata.get("username"));
        }});
    }

    /**
     * Checking number
     * @param data with numberid
     * @return
     * @throws AltException
     */
    public AltDbRow check(Map<String, String> data) throws AltException {
        // validate
        AltValidation.instance()
                .rule(AltValidation.required(data.get("numberid")), "Numberid tidak boleh kosong")
                .check();

        QueueNumber dboNumber = new QueueNumber(this.request);
        return dboNumber.retrieve(new HashMap<String, String>(){{
            put("select", "number");
            put("numberid", data.get("numberid"));
        }});
    }

    /**
     * Archiving queue number on specific day
     *
     * @param data
     * @return
     * @throws AltException
     */
    public int archive(Map<String, String> data) throws AltException {
        data.putIfAbsent("user", "system");

        AltValidation.instance()
                .rule(AltValidation.required(data.get("date")), "Tanggal tidak boleh kosong!")
                .rule(AltValidation.required(data.get("user")), "User tidak boleh kosong!")
                .check();

        QueueNumber dboNumber = new QueueNumber(this.request);
        AltDbRows list = dboNumber.get(new HashMap<String, String>(){{
            put("where", "date = " + dboNumber.quote(data.get("date")));
        }});

        int res = 0;
        QueueArchive dboArchive = new QueueArchive(this.request);
        for(int i=0; i<list.size(); i++){
            AltDbRow item = list.get(i);
            item.put("entryuser", data.get("user"));
            dboArchive.insert(item.map());
            res += dboNumber.delete(new HashMap<String, String>(){{
                put("numberid", item.get("numberid"));
            }});
        }

        return res;
    }
}