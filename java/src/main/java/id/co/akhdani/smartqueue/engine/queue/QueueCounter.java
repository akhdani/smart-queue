package id.co.akhdani.smartqueue.engine.queue;

import labs.akhdani.alt.AltDbo;
import labs.akhdani.alt.AltHttpRequest;

public class QueueCounter extends AltDbo {

    public QueueCounter(){
        this(null);
    }

    public QueueCounter(AltHttpRequest request){
        super(request);

        this.pkey           = "counterid";
        this.table_name     = "queue_counter";
        this.table_fields.put("counterid", "");
        this.table_fields.put("queueid", "");
        this.table_fields.put("clientid", "");
        this.table_fields.put("name", "");
        this.table_fields.put("description", "");
        this.table_fields.put("numberid", "");
        this.table_fields.put("number", "");
        this.table_fields.put("entrytime", "");
        this.table_fields.put("entryuser", "");
        this.table_fields.put("modifiedtime", "");
        this.table_fields.put("modifieduser", "");
        this.table_fields.put("deletedtime", "");
        this.table_fields.put("deleteduser", "");
        this.table_fields.put("isdeleted", "");
    }
}