package id.co.akhdani.smartqueue.engine.queue;

import id.co.akhdani.smartqueue.engine.Queue;
import labs.akhdani.alt.*;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

public class QueueNumber extends AltDbo {

    public QueueNumber(){
        this(null);
    }

    public QueueNumber(AltHttpRequest request){
        super(request);

        this.pkey           = "numberid";
        this.table_name     = "queue_number";
        this.table_fields.put("numberid", "");
        this.table_fields.put("queueid", "");
        this.table_fields.put("counterid", "");
        this.table_fields.put("clientid", "");
        this.table_fields.put("number", "");
        this.table_fields.put("date", "");
        this.table_fields.put("ipaddress", "");
        this.table_fields.put("useragent", "");
        this.table_fields.put("session", "");
        this.table_fields.put("starttime", "");
        this.table_fields.put("endtime", "");
        this.table_fields.put("isfinish", "");
        this.table_fields.put("entrytime", "");
        this.table_fields.put("entryuser", "");
        this.table_fields.put("iscancel", "");
        this.table_fields.put("canceltime", "");
        this.table_fields.put("canceluser", "");
    }

    public AltDbRow retrieve(Map<String, String> data) throws AltException {
        AltValidation.instance()
                .rule(AltValidation.required(data.get("numberid")), "Nomor belum dipilih!")
                .check();

        AltDbRow number = super.retrieve(data);

        Queue dboQueue = new Queue(this.request);
        AltDbRow queue = dboQueue.retrieve(new HashMap<String, String>(){{
            put("queueid", number.getString("queueid"));
        }});

        // predict time remaining
        number.put("timeremaining", (number.getInteger("number") - queue.getInteger("number")) > 0 ? queue.getInteger("avgtime") * (number.getInteger("number") - queue.getInteger("number")) : 0);

        // check counter time open and close
        LocalDateTime timenow = LocalDateTime.now();

        String[] starttime = queue.getString("starttime").split(":");
        LocalDateTime timestart = LocalDateTime.of(timenow.getYear(), timenow.getMonthValue(), timenow.getDayOfMonth(), Integer.valueOf(starttime[0]), Integer.valueOf(starttime[1]));

        String[] endtime = queue.getString("endtime").split(":");
        LocalDateTime timeend = LocalDateTime.of(timenow.getYear(), timenow.getMonthValue(), timenow.getDayOfMonth(), Integer.valueOf(endtime[0]), Integer.valueOf(endtime[1]));

        if(timenow.isBefore(timeend))
            throw new AltException("Antrian sudah tidak berlaku karena sudah tutup!");

        // calculate time
        number.put("timeremaining", (timestart.isAfter(timenow) ? Timestamp.valueOf(timestart).getTime() - Timestamp.valueOf(timenow).getTime() : 0) + number.getInteger("timeremaining"));

        return number;
    }
}