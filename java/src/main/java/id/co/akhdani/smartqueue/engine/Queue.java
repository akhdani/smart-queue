package id.co.akhdani.smartqueue.engine;

import id.co.akhdani.smartqueue.engine.queue.QueueArchive;
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

    public AltDbRow next(Map<String, String> data){
        return null;
    }

    public AltDbRow call(Map<String, String> data){
        return null;
    }

    public AltDbRow skip(Map<String, String> data){
        return null;
    }

    public AltDbRow finish(Map<String, String> data){
        return null;
    }

    public AltDbRow take(Map<String, String> data){
        return null;
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
                put("numberid", item.getString("numberid"));
            }});
        }

        return res;
    }

    /**
     * Notify user via realtime socket
     *
     * @param data
     * @return
     */
    public int notify(Map<String, String> data){

        return 0;
    }
}