package id.co.akhdani.smartqueue.engine.queue;

import labs.akhdani.alt.AltDbo;
import labs.akhdani.alt.AltHttpRequest;

public class QueueArchive extends AltDbo {

    public QueueArchive(){
        this(null);
    }

    public QueueArchive(AltHttpRequest request){
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
}