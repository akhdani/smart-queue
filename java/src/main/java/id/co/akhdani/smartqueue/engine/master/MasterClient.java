package id.co.akhdani.smartqueue.engine.master;

import labs.akhdani.alt.AltDbo;
import labs.akhdani.alt.AltHttpRequest;

public class MasterClient extends AltDbo {

    public MasterClient(){
        this(null);
    }

    public MasterClient(AltHttpRequest request){
        super(request);

        this.pkey           = "clientid";
        this.table_name     = "master_client";
        this.table_fields.put("clientid", "");
        this.table_fields.put("name", "");
        this.table_fields.put("shortname", "");
        this.table_fields.put("address", "");
        this.table_fields.put("phone", "");
        this.table_fields.put("email", "");
        this.table_fields.put("isactive", "");
        this.table_fields.put("entrytime", "");
        this.table_fields.put("entryuser", "");
        this.table_fields.put("modifiedtime", "");
        this.table_fields.put("modifieduser", "");
        this.table_fields.put("deletedtime", "");
        this.table_fields.put("deleteduser", "");
        this.table_fields.put("isdeleted", "");
    }
}